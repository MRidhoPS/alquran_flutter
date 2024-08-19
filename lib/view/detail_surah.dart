import 'package:al_quran_app/controller/list_surah/bloc/surah_bloc.dart';
import 'package:al_quran_app/controller/surah_controller.dart';
import 'package:al_quran_app/model/detail_surah_model.dart';
import 'package:al_quran_app/view/home.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controller/detail_surah/bloc/detail_surah_bloc.dart';

class DetailSurahPage extends StatelessWidget {
  const DetailSurahPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SafeArea(
              child: BlocBuilder<DetailSurahBloc, DetailSurahState>(
                builder: (context, state) {
                  if (state is DetailSurahLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is DetailSurahLoaded) {
                    final detail = state.surahRes;
                    return Container(
                      padding: const EdgeInsets.only(right: 20, top: 10),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 5,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
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
                                icon: const Icon(
                                    Icons.arrow_back_ios_new_rounded),
                              ),
                              Text(
                                detail.nama,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          Text(
                            '${detail.namaLatin} / ${detail.arti}',
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 24,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            '${detail.jumlahAyat} Ayat',
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 24,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
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
                            )
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
          SliverToBoxAdapter(
            child: SafeArea(
              child: BlocBuilder<DetailSurahBloc, DetailSurahState>(
                builder: (context, state) {
                  if (state is DetailSurahLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is DetailSurahLoaded) {
                    final detail = state.surahRes;

                    // Check the type of suratSelanjutnya before accessing it
                    if (detail.suratSelanjutnya is SuratSelanjutnya) {
                      final nextSurah =
                          detail.suratSelanjutnya as SuratSelanjutnya;
                      return Container(
                        padding: const EdgeInsets.only(
                            right: 20, top: 10, bottom: 10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              spreadRadius: 2,
                              offset: const Offset(4, 6),
                              blurRadius: 4,
                              blurStyle: BlurStyle.normal,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Next Surah: ${nextSurah.namaLatin}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => BlocProvider(
                                            create: (context) {
                                              final surahId =
                                                  state.surahRes.nomor + 1;
                                              return DetailSurahBloc(Dio())
                                                ..add(
                                                    FetchSurahDetail(surahId));
                                            },
                                            child: const DetailSurahPage(),
                                          ),
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.keyboard_arrow_right_sharp,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Surah ke: ${nextSurah.nomor}",
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                '${detail.jumlahAyat} Ayat',
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (detail.suratSelanjutnya == false) {
                      return const SizedBox();
                    } else {
                      return const SizedBox();
                    }
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ),

        ],
      ),
    );
  }
}
