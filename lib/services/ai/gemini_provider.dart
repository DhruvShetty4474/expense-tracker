import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../../shared/models/chat_message.dart';
import 'ai_provider_interface.dart';

class GeminiProvider implements AiProviderInterface {
  static const _model = 'gemini-1.5-flash';
  static const _systemInstruction = '''
You are FinAI, a personal finance assistant. You help users understand their
spending habits, create budgets, and improve their financial health.

IMPORTANT RULES:
- Never ask for or reference account numbers, card details, OTPs, or raw SMS.
- Provide specific, actionable advice based only on the financial summary given.
- Keep responses concise (2–4 sentences unless a detailed breakdown is requested).
- Always use Indian Rupee (₹) for amounts.
- Be encouraging and non-judgmental about spending habits.
''';

  late final GenerativeModel _generativeModel;

  GeminiProvider() {
    final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
    _generativeModel = GenerativeModel(
      model: _model,
      apiKey: apiKey,
      systemInstruction: Content.system(_systemInstruction),
      generationConfig: GenerationConfig(
        temperature: 0.7,
        maxOutputTokens: 512,
      ),
    );
  }

  @override
  Stream<String> chat(String systemPrompt, List<ChatMessage> messages) async* {
    final history = messages
        .where((m) => m.role == ChatRole.user || m.role == ChatRole.assistant)
        .take(messages.length - 1)
        .map((m) => Content(
              m.role == ChatRole.user ? 'user' : 'model',
              [TextPart(m.content)],
            ))
        .toList();

    final lastMessage = messages.last;
    final fullPrompt = '$systemPrompt\n\n${lastMessage.content}';

    final chat = _generativeModel.startChat(history: history);
    final stream = chat.sendMessageStream(Content.text(fullPrompt));

    await for (final chunk in stream) {
      final text = chunk.text;
      if (text != null && text.isNotEmpty) yield text;
    }
  }

  @override
  Future<String> generateInsight(FinancialContext context) async {
    final prompt = '''
Based on this financial summary, provide one concise actionable insight:
${context.toPromptContext()}
''';
    final response = await _generativeModel.generateContent([Content.text(prompt)]);
    return response.text ?? 'Unable to generate insight at this time.';
  }

  @override
  Future<String> suggestBudgets(FinancialContext context) async {
    final prompt = '''
Based on this financial summary, suggest monthly budget allocations:
${context.toPromptContext()}

Provide a category-wise budget breakdown in a simple list format.
''';
    final response = await _generativeModel.generateContent([Content.text(prompt)]);
    return response.text ?? 'Unable to generate budget suggestions at this time.';
  }

  @override
  void dispose() {}
}
