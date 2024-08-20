import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/detail_surah/bloc/detail_surah_bloc.dart';
import '../../route/navigation.dart';
import '../text_widget.dart';

class HeaderDetailSurah extends StatelessWidget {
  const HeaderDetailSurah({
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
                            Navigation().backHome(context);
                          },
                          icon: const Icon(Icons.arrow_back_ios_new_rounded),
                        ),
                        TextWidget(
                          data: detail.nama,
                          textColor: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                    TextWidget(
                      data: '${detail.namaLatin} / ${detail.arti}',
                      textColor: Colors.black.withOpacity(0.5),
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                    TextWidget(
                      data: '${detail.jumlahAyat} Ayat',
                      textColor: Colors.black.withOpacity(0.5),
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
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
    );
  }
}
