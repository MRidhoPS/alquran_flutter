part of 'surah_bloc.dart';

abstract class SurahEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchSurahList extends SurahEvent {}
