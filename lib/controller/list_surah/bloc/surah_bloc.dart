import 'package:al_quran_app/controller/surah_controller.dart';
import 'package:al_quran_app/model/surah_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'surah_event.dart';
part 'surah_state.dart';

class SurahBloc extends Bloc<SurahEvent, SurahState> {

  SurahBloc() : super(SurahInitial()) {
    on<FetchSurahList>(_onFetchSurahList);
  }

  Future<void> _onFetchSurahList(
      FetchSurahList event, Emitter<SurahState> emit) async {
    emit(SurahLoading());

    try {
      final surahRes = await SurahServices().getListSurah();
      emit(SurahLoaded(surahRes));
    } catch (e) {
      emit(SurahError(e.toString()));
    }
  }
}
