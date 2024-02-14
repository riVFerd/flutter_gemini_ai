import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../domain/entities/answer.dart';

class AnswerBubble extends StatelessWidget {
  final Answer answer;

  const AnswerBubble({super.key, required this.answer});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ChatBubble(text: answer.question),
          switch (answer.answer) {
            null => LoadingAnimationWidget.prograssiveDots(color: Colors.pinkAccent, size: 50),
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
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Align(
        alignment: (isUser) ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.all(12),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.8,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: (isUser) ? Colors.blueAccent : Colors.pinkAccent,
          ),
          child: Text(text, textAlign: (isUser) ? TextAlign.right : null),
        ),
      ),
    );
  }
}
