import 'package:al_quran_app/controller/list_surah/bloc/surah_bloc.dart';
import 'package:al_quran_app/controller/surah_controller.dart';
import 'package:al_quran_app/view/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  SurahServices surahServices = SurahServices();
  runApp(MyApp(surahServices: surahServices));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.surahServices});

  final SurahServices surahServices;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => SurahBloc(surahServices)..add(FetchSurahList()),
        child: const HomePage(),
      ),
    );
  }
}
