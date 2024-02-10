import 'package:flutter_gemini/flutter_gemini.dart';

import '../../models/answer_model.dart';

class AnswerRemoteDataSource {
  final Gemini gemini;

  AnswerRemoteDataSource({required this.gemini});

  Future<AnswerModel> getAnswer(String question) async {
    final candidate = await gemini.text(question);
    final answerText = candidate?.output;
    return AnswerModel(question: question, answer: answerText);
  }
}
