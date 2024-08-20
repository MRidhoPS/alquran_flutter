import 'package:al_quran_app/controller/list_surah/bloc/surah_bloc.dart';
import 'package:al_quran_app/model/surah_model.dart';
import 'package:al_quran_app/route/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/text_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quran Surah List')),
      body: const ListSurahContainer(),
    );
  }

  
}

class ListSurahContainer extends StatelessWidget {
  const ListSurahContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurahBloc, SurahState>(
      builder: (context, state) {
        if (state is SurahLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SurahLoaded) {
          return ListView.builder(
            itemCount: state.surahResponse.data.length,
            itemBuilder: (context, index) {
              final surah = state.surahResponse.data[index];
              return SurahInformation(surah: surah);
            },
          );
        } else if (state is SurahError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('No data'));
        }
      },
    );
  }
}

class SurahInformation extends StatelessWidget {
  const SurahInformation({
    super.key,
    required this.surah,
  });

  final SurahData surah;

  @override
  Widget build(BuildContext context) {
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
      title: TextWidget(
        data: surah.namaLatin,
        textColor: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      subtitle: TextWidget(
        data: surah.arti,
        textColor: Colors.black54,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      trailing: TextWidget(
        data: '${surah.jumlahAyat} Ayahs',
        textColor: Colors.black54,
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
      onTap: () {
        Navigation().detailSurahNav(context, surah);
      },
    );
  }
}
