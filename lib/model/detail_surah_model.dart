class DetailSurah {
  final int code;
  final String message;
  final SurahDataRes data;

  DetailSurah({
    required this.code,
    required this.message,
    required this.data,
  });

  factory DetailSurah.fromJson(Map<String, dynamic> json) {
    return DetailSurah(
      code: json['code'],
      message: json['message'],
      data: SurahDataRes.fromJson(json['data']),
    );
  }
}

class SurahDataRes {
  final int nomor;
  final String nama;
  final String namaLatin;
  final int jumlahAyat;
  final String tempatTurun;
  final String arti;
  final String deskripsi;
  final Map<String, String> audioFull;
  final List<Ayat> ayat;
  final SuratSelanjutnya? suratSelanjutnya;
  final dynamic suratSebelumnya;

  SurahDataRes({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
    required this.tempatTurun,
    required this.arti,
    required this.deskripsi,
    required this.audioFull,
    required this.ayat,
     this.suratSelanjutnya,
    this.suratSebelumnya,
  });

  factory SurahDataRes.fromJson(Map<String, dynamic> json) {
    return SurahDataRes(
      nomor: json['nomor'],
      nama: json['nama'],
      namaLatin: json['namaLatin'],
      jumlahAyat: json['jumlahAyat'],
      tempatTurun: json['tempatTurun'],
      arti: json['arti'],
      deskripsi: json['deskripsi'],
      audioFull: Map<String, String>.from(json['audioFull']),
      ayat: (json['ayat'] as List).map((item) => Ayat.fromJson(item)).toList(),
      suratSelanjutnya: json['suratSelanjutnya'] != null
          ? SuratSelanjutnya.fromJson(json['suratSelanjutnya'])
          : null,
      suratSebelumnya: json['suratSebelumnya'], // Bisa berupa bool atau null
      // suratSebelumnya: json['suratSebelumnya'] != false
      //     ? SuratSebelumnya.fromJson(json['suratSebelumnya'])
      //     : false,
    );
  }
}

class Ayat {
  final int nomorAyat;
  final String teksArab;
  final String teksLatin;
  final String teksIndonesia;
  final Map<String, String> audio;

  Ayat({
    required this.nomorAyat,
    required this.teksArab,
    required this.teksLatin,
    required this.teksIndonesia,
    required this.audio,
  });

  factory Ayat.fromJson(Map<String, dynamic> json) {
    return Ayat(
      nomorAyat: json['nomorAyat'],
      teksArab: json['teksArab'],
      teksLatin: json['teksLatin'],
      teksIndonesia: json['teksIndonesia'],
      audio: Map<String, String>.from(json['audio']),
    );
  }
}

class SuratSelanjutnya {
  final int nomor;
  final String nama;
  final String namaLatin;
  final int jumlahAyat;

  SuratSelanjutnya({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
  });

  factory SuratSelanjutnya.fromJson(Map<String, dynamic> json) {
    return SuratSelanjutnya(
      nomor: json['nomor'],
      nama: json['nama'],
      namaLatin: json['namaLatin'],
      jumlahAyat: json['jumlahAyat'],
    );
  }
}

class SuratSebelumnya {
  final int nomor;
  final String nama;
  final String namaLatin;
  final int jumlahAyat;

  SuratSebelumnya({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
  });
  factory SuratSebelumnya.fromJson(Map<String, dynamic> json) {
    return SuratSebelumnya(
      nomor: json['nomor'],
      nama: json['nama'],
      namaLatin: json['namaLatin'],
      jumlahAyat: json['jumlahAyat'],
    );
  }
}
