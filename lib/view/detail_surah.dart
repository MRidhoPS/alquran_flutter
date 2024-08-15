import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/detail_surah/bloc/detail_surah_bloc.dart';

class DetailSurahPage extends StatelessWidget {
  const DetailSurahPage({super.key, required this.surahId});

  final int surahId;

  @override
  Widget build(BuildContext context) {

    context.read<DetailSurahBloc>().add(FetchSurahDetail(surahId));
    return Scaffold(
      body: BlocBuilder<DetailSurahBloc, DetailSurahState>(
        builder: (context, state) {
          if (state is DetailSurahLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DetailSurahLoaded) {
            return ListView.builder(
              itemCount: state.surahRes.ayat.length,
              itemBuilder: (BuildContext context, int index) {
                final ayah = state.surahRes.ayat[index];
                return ListTile(
                  title: Text(
                    ayah.teksArab,
                    style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  subtitle: Text(ayah.teksLatin),
                  leading: CircleAvatar(
                    child: Text("${ayah.nomorAyat}"),
                  ),
                );
              },
            );
          } else if (state is DetailSurahError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
