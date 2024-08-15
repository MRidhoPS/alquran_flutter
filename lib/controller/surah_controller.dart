import 'package:al_quran_app/model/detail_surah_model.dart';
import 'package:al_quran_app/model/surah_model.dart';
import 'package:dio/dio.dart';

class SurahServices{

  Dio dio  = Dio();
  final String baseUrl = 'https://equran.id/api/v2/surat';

  Future<SurahResponse> getListSurah() async{
    try {
      Response response = await dio.get(baseUrl);

      if(response.statusCode == 200){
        return SurahResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load surah');
      }

    } on DioException catch (e) {
      // Handle Dio-specific exceptions
      print('Dio error: ${e.message}');
      throw Exception('Failed to load surah');
    }
  }

  Future<SurahDataRes> getDetailSurah(int id) async{
    try {
      Response response = await dio.get('$baseUrl/$id');
      if(response.statusCode == 200){
        return SurahDataRes.fromJson(response.data['data']);
      } else {
        throw Exception('Salah di api');
      }
    } on DioException catch (e) {
      // Handle Dio-specific exceptions
      print('Dio error: ${e.message}');
      throw Exception('Salah di api');
    }
  }

}