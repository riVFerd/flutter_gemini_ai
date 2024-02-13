import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini_ai/presentation/widgets/answer_bubble.dart';
import 'package:flutter_gemini_ai/utils/content_extentions.dart';

import '../bloc/answer_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final questionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Ask Gemini!'),
            IconButton(
              onPressed: () => context.read<AnswerBloc>().add(const ResetAnswers()),
              icon: const Icon(Icons.delete_forever),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: BlocBuilder<AnswerBloc, AnswerState>(
                builder: (context, state) {
                  switch (state) {
                    case AnswerInitial():
                      return const SizedBox();
                    case AnswerError():
                      return const Text('Error');
                    case AnswerLoaded() || AnswerLoading():
                      final answers = context.read<AnswerBloc>().chats.toAnswers();
                      return ListView.builder(
                        itemCount: answers.length,
                        itemBuilder: (context, index) {
                          return AnswerBubble(answer: answers[index]);
                        },
                      );
                  }
                },
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
