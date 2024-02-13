import 'package:flutter_gemini/flutter_gemini.dart';

import '../entities/answer.dart';

abstract class AnswerRepository {
  Future<Answer> getAnswer(List<Content> chats);
}
