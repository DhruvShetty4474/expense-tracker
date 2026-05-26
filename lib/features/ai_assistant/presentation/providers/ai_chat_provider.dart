import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/di/providers.dart';
import '../../../../services/ai/ai_context_builder.dart';
import '../../../../services/ai/ai_provider_interface.dart';
import '../../../../services/ai/gemini_provider.dart';
import '../../../../shared/models/chat_message.dart';

// AI service (swap to OpenAI by changing this one line)
final aiServiceProvider = Provider<AiProviderInterface>((ref) => GeminiProvider());

// Context builder — takes AppDatabase directly
final aiContextBuilderProvider = Provider<AiContextBuilder>((ref) {
  return AiContextBuilder(ref.watch(databaseProvider));
});

// ── Chat state ──────────────────────────────────────────────────────────────

class ChatState {
  final List<ChatMessage> messages;
  final bool isStreaming;

  const ChatState({this.messages = const [], this.isStreaming = false});

  ChatState copyWith({List<ChatMessage>? messages, bool? isStreaming}) =>
      ChatState(
        messages: messages ?? this.messages,
        isStreaming: isStreaming ?? this.isStreaming,
      );
}

class AiChatNotifier extends Notifier<ChatState> {
  @override
  ChatState build() => const ChatState();

  Future<void> sendMessage(String userText) async {
    if (userText.trim().isEmpty) return;

    final userMsg = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      role: ChatRole.user,
      content: userText.trim(),
      timestamp: DateTime.now(),
    );

    state = state.copyWith(
      messages: [...state.messages, userMsg],
      isStreaming: true,
    );

    // Build sanitized context (no raw SMS, no account numbers)
    final ctx = await ref.read(aiContextBuilderProvider).build(
          month: DateTime.now(),
          userQuery: userText.trim(),
        );

    final ai = ref.read(aiServiceProvider);
    final assistantId = '${DateTime.now().millisecondsSinceEpoch}_ai';

    final placeholder = ChatMessage(
      id: assistantId,
      role: ChatRole.assistant,
      content: '',
      timestamp: DateTime.now(),
      isStreaming: true,
    );

    state = state.copyWith(messages: [...state.messages, placeholder]);

    final buffer = StringBuffer();
    try {
      await for (final chunk in ai.chat(
        _systemPrompt(ctx),
        state.messages.where((m) => m.id != assistantId).toList(),
      )) {
        buffer.write(chunk);
        state = state.copyWith(
          messages: state.messages.map((m) {
            if (m.id != assistantId) return m;
            return m.copyWith(content: buffer.toString());
          }).toList(),
        );
      }
    } catch (_) {
      state = state.copyWith(
        messages: state.messages.map((m) {
          if (m.id != assistantId) return m;
          return m.copyWith(
            content: 'Sorry, something went wrong. Please try again.',
            isStreaming: false,
          );
        }).toList(),
      );
    } finally {
      state = state.copyWith(
        isStreaming: false,
        messages: state.messages.map((m) {
          if (m.id != assistantId) return m;
          return m.copyWith(isStreaming: false);
        }).toList(),
      );
    }
  }

  void clear() => state = const ChatState();

  String _systemPrompt(FinancialContext ctx) => '''
You are FinAI, a helpful personal finance assistant. You have access to the user's anonymized financial summary.

${ctx.toPromptContext()}

RULES:
- Never ask for or reference account numbers, card numbers, OTPs, or raw SMS text
- Give concise, actionable advice
- Use ₹ for all amounts
- Be encouraging and non-judgmental
- Keep responses under 200 words unless asked for detail
''';
}

final aiChatProvider =
    NotifierProvider<AiChatNotifier, ChatState>(AiChatNotifier.new);
