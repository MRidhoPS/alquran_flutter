// import 'package:al_quran_app/controller/surah_controller.dart';
import 'package:al_quran_app/controller/surah_controller.dart';
import 'package:al_quran_app/model/detail_surah_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'detail_surah_event.dart';
part 'detail_surah_state.dart';

class DetailSurahBloc extends Bloc<DetailSurahEvent, DetailSurahState> {
  final Dio dio;
  DetailSurahBloc(this.dio) : super(DetailSurahInitial()) {
    on<FetchSurahDetail>(_onFetchDetailSurah);
  }

  Future<void> _onFetchDetailSurah(
      FetchSurahDetail event, Emitter<DetailSurahState> emit) async {
    emit(DetailSurahLoading());
    try {
      final res = await SurahServices().getDetailSurah(event.surahId);
      print('Response: $res');
      emit(DetailSurahLoaded(res));
    } catch (e) {
      emit(DetailSurahError('Salah di bloc: ${e.toString()}'));
    }
  }
}
