import '../entities/answer.dart';

abstract class AnswerRepository {
  Future<Answer> getAnswer(String question);
}
