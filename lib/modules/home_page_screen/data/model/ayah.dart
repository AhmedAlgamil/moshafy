import 'dart:convert';
/// id : "1"
/// number : "1"
/// textAyah : "﻿بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ"
/// numberInSurah : "1"
/// juz : "1"
/// manzil : "1"
/// page : "1"
/// ruku : "1"
/// hizbQuarter : "1"
/// surahNumber : "1"

Ayah ayahFromJson(String str) => Ayah.fromJson(json.decode(str));
String ayahToJson(Ayah data) => json.encode(data.toJson());
class Ayah {
  Ayah({
      String? id, 
      String? number, 
      String? textAyah, 
      String? numberInSurah, 
      String? juz, 
      String? manzil, 
      String? page, 
      String? ruku, 
      String? hizbQuarter, 
      String? surahNumber,}){
    _id = id;
    _number = number;
    _textAyah = textAyah;
    _numberInSurah = numberInSurah;
    _juz = juz;
    _manzil = manzil;
    _page = page;
    _ruku = ruku;
    _hizbQuarter = hizbQuarter;
    _surahNumber = surahNumber;
}

  Ayah.fromJson(dynamic json) {
    _id = json['id'];
    _number = json['number'];
    _textAyah = json['textAyah'];
    _numberInSurah = json['numberInSurah'];
    _juz = json['juz'];
    _manzil = json['manzil'];
    _page = json['page'];
    _ruku = json['ruku'];
    _hizbQuarter = json['hizbQuarter'];
    _surahNumber = json['surahNumber'];
  }
  String? _id;
  String? _number;
  String? _textAyah;
  String? _numberInSurah;
  String? _juz;
  String? _manzil;
  String? _page;
  String? _ruku;
  String? _hizbQuarter;
  String? _surahNumber;
Ayah copyWith({  String? id,
  String? number,
  String? textAyah,
  String? numberInSurah,
  String? juz,
  String? manzil,
  String? page,
  String? ruku,
  String? hizbQuarter,
  String? surahNumber,
}) => Ayah(  id: id ?? _id,
  number: number ?? _number,
  textAyah: textAyah ?? _textAyah,
  numberInSurah: numberInSurah ?? _numberInSurah,
  juz: juz ?? _juz,
  manzil: manzil ?? _manzil,
  page: page ?? _page,
  ruku: ruku ?? _ruku,
  hizbQuarter: hizbQuarter ?? _hizbQuarter,
  surahNumber: surahNumber ?? _surahNumber,
);
  String? get id => _id;
  String? get number => _number;
  String? get textAyah => _textAyah;
  String? get numberInSurah => _numberInSurah;
  String? get juz => _juz;
  String? get manzil => _manzil;
  String? get page => _page;
  String? get ruku => _ruku;
  String? get hizbQuarter => _hizbQuarter;
  String? get surahNumber => _surahNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['number'] = _number;
    map['textAyah'] = _textAyah;
    map['numberInSurah'] = _numberInSurah;
    map['juz'] = _juz;
    map['manzil'] = _manzil;
    map['page'] = _page;
    map['ruku'] = _ruku;
    map['hizbQuarter'] = _hizbQuarter;
    map['surahNumber'] = _surahNumber;
    return map;
  }

}