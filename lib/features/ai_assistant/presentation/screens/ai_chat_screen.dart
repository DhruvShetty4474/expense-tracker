import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/animated_background.dart';
import '../../../../shared/models/chat_message.dart';
import '../providers/ai_chat_provider.dart';

class AiChatScreen extends ConsumerStatefulWidget {
  const AiChatScreen({super.key});

  @override
  ConsumerState<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends ConsumerState<AiChatScreen> {
  final _ctrl = TextEditingController();
  final _scrollCtrl = ScrollController();

  @override
  void dispose() {
    _ctrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _send() {
    final text = _ctrl.text.trim();
    if (text.isEmpty) return;
    _ctrl.clear();
    ref.read(aiChatProvider.notifier).sendMessage(text);
    Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
  }

  void _scrollToBottom() {
    if (_scrollCtrl.hasClients) {
      _scrollCtrl.animateTo(
        _scrollCtrl.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(aiChatProvider);

    ref.listen(aiChatProvider, (_, __) {
      Future.delayed(const Duration(milliseconds: 50), _scrollToBottom);
    });

    return Scaffold(
      backgroundColor: AppColors.amoledBackground,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceDark,
        foregroundColor: Colors.white,
        title: const Row(
          children: [
            _AiAvatar(),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('FinAI',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text('Your finance assistant',
                    style: TextStyle(color: Colors.white54, fontSize: 11)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_outlined),
            onPressed: () => ref.read(aiChatProvider.notifier).clear(),
            tooltip: 'Clear chat',
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: chatState.messages.isEmpty
                ? _WelcomeView(onSuggestion: (s) {
                    _ctrl.text = s;
                    _send();
                  })
                : ListView.builder(
                    controller: _scrollCtrl,
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                    itemCount: chatState.messages.length,
                    itemBuilder: (_, i) =>
                        _MessageBubble(msg: chatState.messages[i]),
                  ),
          ),
          _InputBar(
            controller: _ctrl,
            isStreaming: chatState.isStreaming,
            onSend: _send,
          ),
        ],
      ),
    );
  }
}

class _AiAvatar extends StatelessWidget {
  const _AiAvatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.accentPurple, AppColors.accentCyan],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(Icons.auto_awesome, color: Colors.white, size: 18),
    );
  }
}

class _WelcomeView extends StatelessWidget {
  final void Function(String) onSuggestion;

  const _WelcomeView({required this.onSuggestion});

  static const _suggestions = [
    'How much did I spend this month?',
    'Where am I overspending?',
    'Give me savings tips based on my habits',
    'How can I reduce my food expenses?',
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const _AiAvatar(),
            const SizedBox(height: 16),
            const Text(
              'Hi! I\'m FinAI',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Ask me anything about your finances.\nYour data stays private — I only see anonymized summaries.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white54, fontSize: 13),
            ),
            const SizedBox(height: 24),
            ..._suggestions.map((s) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: GestureDetector(
                    onTap: () => onSuggestion(s),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.cardDark,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color:
                                AppColors.accentPurple.withValues(alpha: 0.3)),
                      ),
                      child: Text(s,
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 14)),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final ChatMessage msg;

  const _MessageBubble({required this.msg});

  @override
  Widget build(BuildContext context) {
    final isUser = msg.role == ChatRole.user;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser) ...[
            const _AiAvatar(),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: isUser
                    ? AppColors.accentPurple.withValues(alpha: 0.25)
                    : AppColors.cardDark,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isUser ? 16 : 4),
                  bottomRight: Radius.circular(isUser ? 4 : 16),
                ),
                border: Border.all(
                  color: isUser
                      ? AppColors.accentPurple.withValues(alpha: 0.4)
                      : Colors.white.withValues(alpha: 0.06),
                ),
              ),
              child: msg.content.isEmpty
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: AppColors.accentPurple),
                    )
                  : Text(
                      msg.content,
                      style: const TextStyle(color: Colors.white, fontSize: 14, height: 1.5),
                    ),
            ),
          ),
          if (isUser) const SizedBox(width: 8),
        ],
      ),
    );
  }
}

class _InputBar extends StatelessWidget {
  final TextEditingController controller;
  final bool isStreaming;
  final VoidCallback onSend;

  const _InputBar({
    required this.controller,
    required this.isStreaming,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          16, 8, 16, MediaQuery.of(context).viewInsets.bottom + 12),
      color: AppColors.surfaceDark,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              style: const TextStyle(color: Colors.white),
              maxLines: 4,
              minLines: 1,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => onSend(),
              decoration: InputDecoration(
                hintText: 'Ask about your finances…',
                hintStyle: const TextStyle(color: Colors.white38),
                filled: true,
                fillColor: AppColors.cardDark,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            child: isStreaming
                ? const SizedBox(
                    width: 44,
                    height: 44,
                    child: Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: AppColors.accentPurple),
                      ),
                    ),
                  )
                : IconButton(
                    onPressed: onSend,
                    icon: const Icon(Icons.send_rounded),
                    color: AppColors.accentPurple,
                    style: IconButton.styleFrom(
                      backgroundColor:
                          AppColors.accentPurple.withValues(alpha: 0.15),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
