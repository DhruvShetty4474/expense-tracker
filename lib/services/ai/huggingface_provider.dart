import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../shared/models/chat_message.dart';
import 'ai_provider_interface.dart';

/// Hugging Face Router chat API (OpenAI-compatible).
/// Set AI_PROVIDER=huggingface in .env
class HuggingFaceProvider implements AiProviderInterface {
  static const _defaultModel = 'meta-llama/Llama-3.2-1B-Instruct';
  static const _chatUrl = 'https://router.huggingface.co/v1/chat/completions';

  final String _apiKey;
  final String _model;

  HuggingFaceProvider({
    String? apiKey,
    String? model,
  })  : _apiKey = apiKey ?? dotenv.env['HUGGINGFACE_API_KEY'] ?? '',
        _model = model ?? dotenv.env['HUGGINGFACE_MODEL'] ?? _defaultModel;

  Map<String, String> get _headers => {
        'Authorization': 'Bearer $_apiKey',
        'Content-Type': 'application/json',
      };

  List<Map<String, String>> _toMessages(
    String systemPrompt,
    List<ChatMessage> messages,
  ) {
    final out = <Map<String, String>>[
      {'role': 'system', 'content': systemPrompt},
    ];
    for (final m in messages) {
      if (m.role == ChatRole.user) {
        out.add({'role': 'user', 'content': m.content});
      } else if (m.role == ChatRole.assistant) {
        out.add({'role': 'assistant', 'content': m.content});
      }
    }
    return out;
  }

  Future<String> _chatComplete(List<Map<String, String>> messages) async {
    if (_apiKey.isEmpty) {
      throw StateError('HUGGINGFACE_API_KEY is missing in .env');
    }

    final response = await http.post(
      Uri.parse(_chatUrl),
      headers: _headers,
      body: jsonEncode({
        'model': _model,
        'messages': messages,
        'max_tokens': 512,
        'temperature': 0.7,
      }),
    );

    if (response.statusCode == 403) {
      throw StateError(
        'HF token lacks Inference permission. Enable "Make calls to Inference Providers" '
        'at huggingface.co/settings/tokens',
      );
    }
    if (response.statusCode == 503) {
      throw StateError('Model loading — wait ~30s and try again.');
    }
    if (response.statusCode != 200) {
      final decoded = jsonDecode(response.body);
      final msg = decoded is Map
          ? (decoded['error']?['message'] ?? decoded['error'] ?? response.body)
          : response.body;
      throw StateError('Hugging Face error (${response.statusCode}): $msg');
    }

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    final content = decoded['choices']?[0]?['message']?['content'] as String?;
    if (content == null || content.trim().isEmpty) {
      throw StateError('Empty response from Hugging Face');
    }
    return content.trim();
  }

  @override
  Stream<String> chat(String systemPrompt, List<ChatMessage> messages) async* {
    final text = await _chatComplete(_toMessages(systemPrompt, messages));
    yield text;
  }

  @override
  Future<String> generateInsight(FinancialContext context) => _chatComplete([
        {
          'role': 'system',
          'content':
              'You are FinAI. Give ONE actionable insight in 2-3 sentences.',
        },
        {
          'role': 'user',
          'content':
              '${context.toPromptContext()}\n${context.patternSummary}',
        },
      ]);

  @override
  Future<String> suggestBudgets(FinancialContext context) => _chatComplete([
        {
          'role': 'system',
          'content':
              'You are FinAI. Suggest monthly category budgets in ₹.',
        },
        {
          'role': 'user',
          'content':
              '${context.toPromptContext()}\n${context.budgetSummary}',
        },
      ]);

  @override
  void dispose() {}
}
