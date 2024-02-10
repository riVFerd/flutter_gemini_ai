import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini_ai/data/models/answer_model.dart';

import '../../domain/entities/answer.dart';
import '../../domain/repositories/answer_repository.dart';

part 'answer_event.dart';
part 'answer_state.dart';

class AnswerBloc extends Bloc<AnswerEvent, AnswerState> {
  final AnswerRepository _answerRepository;
  AnswerBloc(this._answerRepository) : super(AnswerInitial()) {
    on<GetAnswer>((event, emit) async {
      emit(AnswerLoading(AnswerModel(question: event.question)));
      try {
        final answer = await _answerRepository.getAnswer(event.question);
        emit(AnswerLoaded(answer));
      } catch (error) {
        emit(AnswerError(error.toString()));
      }
    });
  }
}
