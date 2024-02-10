part of 'answer_bloc.dart';

sealed class AnswerEvent extends Equatable {
  const AnswerEvent();
}

class GetAnswer extends AnswerEvent {
  final String question;

  const GetAnswer(this.question);

  @override
  List<Object> get props => [question];
}
