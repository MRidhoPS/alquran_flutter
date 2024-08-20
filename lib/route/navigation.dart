import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/detail_surah/bloc/detail_surah_bloc.dart';
import '../controller/list_surah/bloc/surah_bloc.dart';
import '../model/surah_model.dart';
import '../view/detail_surah.dart';
import '../view/home.dart';

class Navigation {
    Future<dynamic> backHome(BuildContext context) {
    return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
            create: (context) {
              return SurahBloc()..add(FetchSurahList());
            },
            child: const HomePage()),
      ),
      (route) => false,
    );
  }

  Future<dynamic> nextSurahNav(
      BuildContext context, DetailSurahLoaded state) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) {
            final surahId = state.surahRes.nomor + 1;
            return DetailSurahBloc(Dio())..add(FetchSurahDetail(surahId));
          },
          child: const DetailSurahPage(),
        ),
      ),
    );
  }

  Future<dynamic> detailSurahNav(BuildContext context, SurahData surah) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) {
            final surahId = surah.nomor;
            return DetailSurahBloc(Dio())..add(FetchSurahDetail(surahId));
          },
          child: const DetailSurahPage(),
        ),
      ),
    );
  }
}