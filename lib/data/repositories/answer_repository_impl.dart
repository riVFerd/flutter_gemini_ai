import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_gemini_ai/data/models/answer_model.dart';

import '../../domain/repositories/answer_repository.dart';
import '../datasources/remote/answer_remote_datasource.dart';

class AnswerRepositoryImpl implements AnswerRepository {
  final AnswerRemoteDataSource remoteDataSource;

  AnswerRepositoryImpl({required this.remoteDataSource});

  @override
  Future<AnswerModel> getAnswer(List<Content> chats) async {
    return remoteDataSource.getAnswer(chats);
  }
}
