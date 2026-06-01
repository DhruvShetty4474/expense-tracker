import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'ai_provider_interface.dart';
import 'gemini_provider.dart';
import 'huggingface_provider.dart';

/// Picks AI backend from .env: AI_PROVIDER=gemini|huggingface (default: gemini)
AiProviderInterface createAiProvider() {
  final provider = (dotenv.env['AI_PROVIDER'] ?? 'gemini').toLowerCase().trim();
  return switch (provider) {
    'huggingface' || 'hf' => HuggingFaceProvider(),
    _ => GeminiProvider(),
  };
}

String activeAiProviderLabel() {
  final provider = (dotenv.env['AI_PROVIDER'] ?? 'gemini').toLowerCase().trim();
  return switch (provider) {
    'huggingface' || 'hf' => 'Hugging Face',
    _ => 'Gemini',
  };
}
