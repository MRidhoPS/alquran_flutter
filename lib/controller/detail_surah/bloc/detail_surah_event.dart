part of 'detail_surah_bloc.dart';

sealed class DetailSurahEvent extends Equatable {
  const DetailSurahEvent();

  @override
  List<Object> get props => [];
}

class FetchSurahDetail extends DetailSurahEvent {
  final int surahId;

  const FetchSurahDetail(this.surahId);

  @override
  List<Object> get props => [surahId];
}
