import 'package:al_quran_app/controller/list_surah/bloc/surah_bloc.dart';
import 'package:al_quran_app/model/surah_model.dart';
import 'package:al_quran_app/route/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:shimmer/shimmer.dart';
import '../widgets/text_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: SafeArea(
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            const SliverToBoxAdapter(
              child: HomeHeader(),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ), // Add spacing between the header and list
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => const ListSurahContainer(),
                childCount: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurahBloc, SurahState>(
      builder: (context, state) {
        if (state is SurahLoading) {
          return Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          );
        } else if (state is SurahLoaded) {
          return Image.asset(
            'assets/images/banner.png',
            fit: BoxFit.cover,
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class ListSurahContainer extends StatelessWidget {
  const ListSurahContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurahBloc, SurahState>(
      builder: (context, state) {
        if (state is SurahLoading) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 12,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else if (state is SurahLoaded) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
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
  const SurahInformation({super.key, required this.surah});

  final SurahData surah;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        border: const GradientBoxBorder(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF64B5F6),
              Color(0xFFBA68C8),
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
