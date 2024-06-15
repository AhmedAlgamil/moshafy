import 'dart:convert';
/// id : "1"
/// number : "1"
/// surah_name : "سُورَةُ ٱلْفَاتِحَةِ"
/// surahEnglishName : "Al-Faatiha"
/// surahEnglishNameTranslation : "The Opening"
/// numberOfAyahs : "7"
/// revelationType : "Meccan"
/// surah_page : "1"

Surah surahFromJson(String str) => Surah.fromJson(json.decode(str));
String surahToJson(Surah data) => json.encode(data.toJson());
class Surah {
  Surah({
      String? id,
      String? number, 
      String? surahName, 
      String? surahEnglishName, 
      String? surahEnglishNameTranslation, 
      String? numberOfAyahs, 
      String? revelationType, 
      String? surahPage,}){
    _id = id;
    _number = number;
    _surahName = surahName;
    _surahEnglishName = surahEnglishName;
    _surahEnglishNameTranslation = surahEnglishNameTranslation;
    _numberOfAyahs = numberOfAyahs;
    _revelationType = revelationType;
    _surahPage = surahPage;
}

  Surah.fromJson(dynamic json) {
    _id = json['id'];
    _number = json['number'];
    _surahName = json['surah_name'];
    _surahEnglishName = json['surahEnglishName'];
    _surahEnglishNameTranslation = json['surahEnglishNameTranslation'];
    _numberOfAyahs = json['numberOfAyahs'];
    _revelationType = json['revelationType'];
    _surahPage = json['surah_page'];
  }
  String? _id;
  String? _number;
  String? _surahName;
  String? _surahEnglishName;
  String? _surahEnglishNameTranslation;
  String? _numberOfAyahs;
  String? _revelationType;
  String? _surahPage;
Surah copyWith({  String? id,
  String? number,
  String? surahName,
  String? surahEnglishName,
  String? surahEnglishNameTranslation,
  String? numberOfAyahs,
  String? revelationType,
  String? surahPage,
}) => Surah(  id: id ?? _id,
  number: number ?? _number,
  surahName: surahName ?? _surahName,
  surahEnglishName: surahEnglishName ?? _surahEnglishName,
  surahEnglishNameTranslation: surahEnglishNameTranslation ?? _surahEnglishNameTranslation,
  numberOfAyahs: numberOfAyahs ?? _numberOfAyahs,
  revelationType: revelationType ?? _revelationType,
  surahPage: surahPage ?? _surahPage,
);
  String? get id => _id;
  String? get number => _number;
  String? get surahName => _surahName;
  String? get surahEnglishName => _surahEnglishName;
  String? get surahEnglishNameTranslation => _surahEnglishNameTranslation;
  String? get numberOfAyahs => _numberOfAyahs;
  String? get revelationType => _revelationType;
  String? get surahPage => _surahPage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['number'] = _number;
    map['surah_name'] = _surahName;
    map['surahEnglishName'] = _surahEnglishName;
    map['surahEnglishNameTranslation'] = _surahEnglishNameTranslation;
    map['numberOfAyahs'] = _numberOfAyahs;
    map['revelationType'] = _revelationType;
    map['surah_page'] = _surahPage;
    return map;
  }

}