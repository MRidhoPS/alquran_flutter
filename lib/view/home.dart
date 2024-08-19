import 'package:al_quran_app/controller/list_surah/bloc/surah_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/detail_surah/bloc/detail_surah_bloc.dart';
import 'detail_surah.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quran Surah List')),
      body: BlocBuilder<SurahBloc, SurahState>(
        builder: (context, state) {
          if (state is SurahLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SurahLoaded) {
            return ListView.builder(
              itemCount: state.surahResponse.data.length,
              itemBuilder: (context, index) {
                final surah = state.surahResponse.data[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.black,
                    child: Center(
                      child: Text(
                        '${surah.nomor}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  title: Text(surah.namaLatin, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                  subtitle: Text(surah.arti),
                  trailing: Text('${surah.jumlahAyat} Ayahs'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) {
                            final surahId = surah.nomor;
                            return DetailSurahBloc(Dio())
                              ..add(FetchSurahDetail(surahId));
                          },
                          child: const DetailSurahPage(
                             ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is SurahError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('No data'));
          }
        },
      ),
    );
  }
}
