import 'package:flutter_gemini/flutter_gemini.dart';

import '../data/models/answer_model.dart';

extension ContentsToAnswer on List<Content> {
  List<AnswerModel> toAnswers() {
    final List<AnswerModel> answers = [];
    if (isEmpty) return answers;
    int currentIndex = 0;
    for (int i = 0; i < length; i++) {
      if (i % 2 == 0) {
        answers.add(AnswerModel(question: this[i].parts?.first.text ?? 'Failed to get question'));
      } else {
        answers[currentIndex].answer = this[i].parts?.first.text;
        currentIndex++;
      }
    }
    return answers;
  }
}
