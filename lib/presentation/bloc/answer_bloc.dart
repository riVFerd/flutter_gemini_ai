import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_gemini_ai/data/models/answer_model.dart';

import '../../domain/entities/answer.dart';
import '../../domain/repositories/answer_repository.dart';

part 'answer_event.dart';
part 'answer_state.dart';

class AnswerBloc extends Bloc<AnswerEvent, AnswerState> {
  final AnswerRepository _answerRepository;
  final List<Content> chats = [];
  AnswerBloc(this._answerRepository) : super(AnswerInitial()) {
    on<GetAnswer>((event, emit) async {
      chats.add(Content(role: 'user', parts: [Parts(text: event.question)]));
      emit(AnswerLoading(AnswerModel(question: event.question)));
      try {
        final answer = await _answerRepository.getAnswer(chats);
        chats.add(Content(role: 'model', parts: [Parts(text: answer.answer)]));
        emit(AnswerLoaded(answer));
      } catch (error) {
        chats.add(Content(role: 'model', parts: [Parts(text: error.toString())]));
        emit(AnswerError(error.toString()));
      }
    });
    on<ResetAnswers>((event, emit) {
      chats.clear();
      emit(AnswerInitial());
    });
  }
}
