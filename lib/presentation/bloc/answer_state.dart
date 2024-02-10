part of 'answer_bloc.dart';

sealed class AnswerState extends Equatable {
  const AnswerState();
}

class AnswerInitial extends AnswerState {
  @override
  List<Object> get props => [];
}

class AnswerLoading extends AnswerState {
  final Answer answer;

  const AnswerLoading(this.answer);

  @override
  List<Object> get props => [answer];
}

class AnswerLoaded extends AnswerState {
  final Answer answer;

  const AnswerLoaded(this.answer);

  @override
  List<Object> get props => [answer];
}

class AnswerError extends AnswerState {
  final String message;

  const AnswerError(this.message);

  @override
  List<Object> get props => [message];
}
