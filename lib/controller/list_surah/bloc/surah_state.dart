part of 'surah_bloc.dart';

abstract class SurahState extends Equatable {
  @override
  List<Object> get props => [];
}

final class SurahInitial extends SurahState {}

final class SurahLoading extends SurahState {}

final class SurahLoaded extends SurahState {
  final SurahResponse surahResponse;

  SurahLoaded(this.surahResponse);

  @override
  List<Object> get props=> [surahResponse];
}

final class SurahError extends SurahState{
  final String message;

  SurahError(this.message);

  @override
  List<Object> get props => [message];
}