import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_gemini_ai/presentation/bloc/answer_bloc.dart';
import 'package:flutter_gemini_ai/presentation/router/app_router.dart';

import 'data/datasources/remote/answer_remote_datasource.dart';
import 'data/repositories/answer_repository_impl.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  final geminiApiKey = dotenv.env['GEMINI_KEY'];
  Gemini.init(apiKey: geminiApiKey!);
  runApp(
    BlocProvider(
      create: (context) {
        final gemini = Gemini.instance;
        final answerRemoteDataSource = AnswerRemoteDataSource(gemini: gemini);
        final answerRepository = AnswerRepositoryImpl(remoteDataSource: answerRemoteDataSource);
        return AnswerBloc(answerRepository);
      },
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ask Gemini!',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
