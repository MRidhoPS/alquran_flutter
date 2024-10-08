import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/detail_surah/bloc/detail_surah_bloc.dart';
import '../../model/detail_surah_model.dart';
import '../../route/navigation.dart';
import '../text_widget.dart';

class NextSurahContainer extends StatelessWidget {
  const NextSurahContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
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
                final nextSurah = detail.suratSelanjutnya as SuratSelanjutnya;
                return Container(
                  padding:
                      const EdgeInsets.only(right: 20, top: 10, bottom: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.purple.shade300,
                        Colors.blue.shade300,
                      ],
                    ),
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextWidget(
                              data: "Next Surah: ${nextSurah.namaLatin}",
                              textColor: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                            IconButton(
                              onPressed: () {
                                Navigation().nextSurahNav(context, state);
                              },
                              icon: const Icon(
                                Icons.keyboard_arrow_right_sharp,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        TextWidget(
                          data: "Surah ke: ${nextSurah.nomor}",
                          textColor: Colors.white.withOpacity(0.9),
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                        TextWidget(
                          data: '${detail.jumlahAyat} Ayat',
                          textColor: Colors.white.withOpacity(0.9),
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
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
    );
  }
}
