import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini_ai/presentation/widgets/answer_bubble.dart';
import 'package:flutter_gemini_ai/utils/content_extentions.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../bloc/answer_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final questionController = TextEditingController();
    final listController = ScrollController();

    Future<void> scrollDown() async {
      await Future.delayed(const Duration(microseconds: 300));
      listController.jumpTo(
        listController.position.maxScrollExtent,
      );
    }

    void showDeleteDialog() {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Delete all chats?'),
              content: const Text('This action cannot be undone.'),
              actions: [
                TextButton(
                  onPressed: () {
                    context.read<AnswerBloc>().add(const ResetAnswers());
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('Delete', style: TextStyle(color: Colors.white)),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
              ],
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Ask Gemini!'),
            IconButton(
              onPressed: showDeleteDialog,
              icon: const Icon(Icons.delete_forever),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: BlocBuilder<AnswerBloc, AnswerState>(
                builder: (context, state) {
                  switch (state) {
                    case AnswerInitial():
                      return const SizedBox();
                    case AnswerError(:final message):
                      return Text(message);
                    case AnswerLoaded() || AnswerLoading():
                      final answers = context.read<AnswerBloc>().chats.toAnswers();
                      scrollDown();
                      return ListView.builder(
                        controller: listController,
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
                  BlocBuilder<AnswerBloc, AnswerState>(
                    builder: (context, state) {
                      return Stack(
                        children: [
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 300),
                            opacity: state is AnswerLoading ? 1 : 0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: LoadingAnimationWidget.waveDots(
                                color: Colors.blueAccent,
                                size: 24,
                              ),
                            ),
                          ),
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 300),
                            right: state is AnswerLoading ? -40 : 0,
                            child: IconButton(
                              onPressed: () {
                                final question = questionController.text;
                                if (question.isEmpty) return;
                                context.read<AnswerBloc>().add(GetAnswer(question));
                                questionController.clear();
                              },
                              icon: const Icon(Icons.send),
                            ),
                          ),
                        ],
                      );
                    },
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
