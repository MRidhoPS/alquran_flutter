import 'package:al_quran_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/detail_surah/bloc/detail_surah_bloc.dart';

class DetailSurahContainer{
  BlocBuilder<DetailSurahBloc, DetailSurahState> detailSurahContainer() {
    return BlocBuilder<DetailSurahBloc, DetailSurahState>(
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
                            TextWidget(
                              data: "${ayah.nomorAyat}.",
                              textColor: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextRIchWidget(
                                data: ayah.teksArab,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.right,
                                maxLines: 7,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextRIchWidget(
                          data: ayah.teksLatin,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          maxLines: 7,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextRIchWidget(
                          data: 'Artinya: ${ayah.teksIndonesia}',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          maxLines: 7,
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
    );
  }
}