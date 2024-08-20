import 'package:al_quran_app/widgets/detail_surah_widget/detail_surah_container.dart';
import 'package:flutter/material.dart';
import '../widgets/detail_surah_widget/header_detail_widget.dart';
import '../widgets/detail_surah_widget/next_surah_widget.dart';

class DetailSurahPage extends StatelessWidget {
  const DetailSurahPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: CustomScrollView(
        slivers: [
          const HeaderDetailSurah(),
          DetailSurahContainer().detailSurahContainer(),
          const NextSurahContainer(),
        ],
      ),
    );
  }
}
