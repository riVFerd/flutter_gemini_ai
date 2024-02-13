import 'package:flutter_gemini/flutter_gemini.dart';

import '../../models/answer_model.dart';

class AnswerRemoteDataSource {
  final Gemini gemini;

  AnswerRemoteDataSource({required this.gemini});

  Future<AnswerModel> getAnswer(List<Content> chats) async {
    final candidate = await gemini.chat(chats);
    final answerText = candidate?.output;
    return AnswerModel(
      question: chats.last.parts!.last.text!,
      answer: answerText,
    );
  }
}
