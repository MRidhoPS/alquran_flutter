import 'package:al_quran_app/controller/list_surah/bloc/surah_bloc.dart';
import 'package:al_quran_app/model/surah_model.dart';
import 'package:al_quran_app/route/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import '../widgets/text_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black54,
      body: Column(
        children: [
          SafeArea(child: HeaderHome()),
          ListSurahContainer(),
        ],
      ),
    );
  }
}

class HeaderHome extends StatelessWidget {
  const HeaderHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 20),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 6,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.purple.shade300,
            Colors.blue.shade300,
          ],
        ),
      ),
      child: const TextWidget(
          data: 'Quran App',
          textColor: Colors.white,
          fontSize: 40,
          fontWeight: FontWeight.bold),
    );
  }
}

class ListSurahContainer extends StatelessWidget {
  const ListSurahContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<SurahBloc, SurahState>(
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
      ),
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
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
      decoration: BoxDecoration(
        border: GradientBoxBorder(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.blue.shade300,
              Colors.purple.shade300,
            ],
          ),
        ),
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white24,
            Colors.white24,
            Colors.white10,
            Colors.white10,

          ],
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white12,
          child: Center(
            child: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.purple.shade300,
                  Colors.blue.shade300,
                ],
              ).createShader(bounds),
              child: Text(
                '${surah.nomor}',
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        title: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.purple.shade300,
              Colors.blue.shade300,
            ],
          ).createShader(bounds),
          child: TextWidget(
            data: surah.namaLatin,
            textColor: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: TextWidget(
          data: surah.arti,
          textColor: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        trailing: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.purple.shade300,
              Colors.blue.shade300,
            ],
          ).createShader(bounds),
          child: TextWidget(
            data: '${surah.jumlahAyat} Ayahs',
            textColor: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () {
          Navigation().detailSurahNav(context, surah);
        },
      ),
    );
  }
}
