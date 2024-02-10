import 'package:flutter_gemini_ai/domain/entities/answer.dart';

class AnswerModel implements Answer {
  @override
  String question;

  @override
  String? answer;

  AnswerModel({required this.question, this.answer});
}
