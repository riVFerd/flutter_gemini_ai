import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini_ai/presentation/widgets/answer_bubble.dart';

import '../bloc/answer_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final questionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ask Gemini!'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: BlocBuilder<AnswerBloc, AnswerState>(
                  builder: (context, state) {
                    return switch (state) {
                      AnswerInitial() => const SizedBox(),
                      AnswerLoading(:final answer) => AnswerBubble(answer: answer),
                      AnswerLoaded(:final answer) => AnswerBubble(answer: answer),
                      AnswerError() => const Text('Error'),
                    };
                  },
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              // color: Colors.blueAccent,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Ask me anything!',
                      ),
                      controller: questionController,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      final question = questionController.text;
                      context.read<AnswerBloc>().add(GetAnswer(question));
                      questionController.clear();
                    },
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
