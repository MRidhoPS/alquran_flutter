import 'package:al_quran_app/controller/list_surah/bloc/surah_bloc.dart';
import 'package:al_quran_app/controller/surah_controller.dart';
import 'package:al_quran_app/view/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controller/detail_surah/bloc/detail_surah_bloc.dart';

class DetailSurahPage extends StatelessWidget {
  const DetailSurahPage({
    super.key,
    required this.namaLatin,
    required this.artiSurat,
    required this.jumlahAyat,
    required this.nama,
  });

  final String nama;
  final String namaLatin;
  final String artiSurat;
  final int jumlahAyat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.only(right: 20, top: 10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 5,
                decoration:  BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade200,
                        spreadRadius: 2,
                        offset: const Offset(4, 6),
                        blurRadius: 4,
                        blurStyle: BlurStyle.normal)
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                    create: (context) {
                                      return SurahBloc(SurahServices())
                                        ..add(FetchSurahList());
                                    },
                                    child: const HomePage()),
                              ),
                              (route) => false,
                            );
                          },
                          icon: const Icon(Icons.arrow_back_ios_new_rounded),
                        ),
                        Text(
                          nama,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    Text(
                      '$namaLatin / $artiSurat',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 24,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      '$jumlahAyat Ayat',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 24,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
          ),
          BlocBuilder<DetailSurahBloc, DetailSurahState>(
            builder: (context, state) {
              if (state is DetailSurahLoading) {
                return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (state is DetailSurahLoaded) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      final ayah = state.surahRes.ayat[index];
                      return Container(
                        padding: const EdgeInsets.all(25),
                        margin: const EdgeInsets.fromLTRB(10, 30, 10, 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade300,
                                  spreadRadius: 3,
                                  offset: const Offset(3, 3),
                                  blurRadius: 6,
                                  blurStyle: BlurStyle.normal)
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${ayah.nomorAyat}.", // This is the number you want to show
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      ayah.teksArab,
                                      maxLines: 7,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                ayah.teksLatin,
                                maxLines: 7,
                                textAlign: TextAlign.left,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Artinya: ${ayah.teksIndonesia}',
                                maxLines: 7,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    childCount: state.surahRes.ayat.length,
                  ),
                );
              } else if (state is DetailSurahError) {
                return SliverFillRemaining(
                  child: Center(child: Text(state.message)),
                );
              } else {
                return const SliverFillRemaining(child: SizedBox());
              }
            },
          ),
        ],
      ),
    );
  }
}
