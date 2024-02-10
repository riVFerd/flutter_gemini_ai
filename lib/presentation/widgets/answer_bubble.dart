import 'package:flutter/material.dart';

import '../../domain/entities/answer.dart';

class AnswerBubble extends StatelessWidget {
  final Answer answer;

  const AnswerBubble({super.key, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _ChatBubble(text: answer.question),
          const SizedBox(height: 8),
          switch (answer.answer) {
            null => const Center(
                child: CircularProgressIndicator(),
              ),
            String() => _ChatBubble(text: answer.answer!, isUser: false),
          }
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final String text;
  final bool isUser;

  const _ChatBubble({required this.text, this.isUser = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: (isUser) ? const EdgeInsets.only(left: 32) : const EdgeInsets.only(right: 32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: (isUser) ? Colors.blueAccent : Colors.pinkAccent,
      ),
      child: Text(text, textAlign: (isUser) ? TextAlign.right : null),
    );
  }
}
