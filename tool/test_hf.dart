import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  final key = dotenv.env['HUGGINGFACE_API_KEY'] ?? '';
  final model = dotenv.env['HUGGINGFACE_MODEL'] ?? 'HuggingFaceH4/zephyr-7b-beta';

  if (key.isEmpty) {
    print('FAIL: HUGGINGFACE_API_KEY missing');
    exit(1);
  }

  final endpoints = [
    'https://router.huggingface.co/hf-inference/models/$model',
    'https://api-inference.huggingface.co/models/$model',
  ];

  for (final url in endpoints) {
    print('Testing: $url');
    final client = HttpClient();
    try {
      final req = await client.postUrl(Uri.parse(url));
      req.headers.set('Authorization', 'Bearer $key');
      req.headers.set('Content-Type', 'application/json');
      req.write(jsonEncode({
        'inputs': 'Say hello in one short sentence.',
        'parameters': {'max_new_tokens': 32, 'return_full_text': false},
      }));
      final res = await req.close();
      final body = await res.transform(utf8.decoder).join();
      print('Status: ${res.statusCode}');
      if (res.statusCode == 200) {
        print('OK: ${body.length > 200 ? '${body.substring(0, 200)}…' : body}');
        exit(0);
      }
      print('Body: ${body.length > 300 ? '${body.substring(0, 300)}…' : body}');
    } catch (e) {
      print('Error: $e');
    } finally {
      client.close();
    }
  }
  print('FAIL: no endpoint succeeded');
  exit(1);
}
