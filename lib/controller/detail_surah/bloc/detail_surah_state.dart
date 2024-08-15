part of 'detail_surah_bloc.dart';

sealed class DetailSurahState extends Equatable {
  const DetailSurahState();
  
  @override
  List<Object> get props => [];
}

class DetailSurahInitial extends DetailSurahState {}

class DetailSurahLoading extends DetailSurahState {}

class DetailSurahLoaded extends DetailSurahState {
  final SurahDataRes surahRes;

  const DetailSurahLoaded(this.surahRes);

  @override
  List<Object> get props => [surahRes];
}

class DetailSurahError extends DetailSurahState {
  final String message;

  const DetailSurahError(this.message);

  @override
  List<Object> get props => [message];
}
