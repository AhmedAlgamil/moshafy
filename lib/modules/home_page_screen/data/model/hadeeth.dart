import 'dart:convert';

/// id : "1"
/// text : "1"
/// surah_name : "سُورَةُ ٱلْفَاتِحَةِ"
/// surahEnglishName : "Al-Faatiha"
/// surahEnglishNameTranslation : "The Opening"
/// textOfAyahs : "7"
/// revelationType : "Meccan"
/// surah_page : "1"

Hadeeth surahFromJson(String str) => Hadeeth.fromJson(json.decode(str));

String surahToJson(Hadeeth data) => json.encode(data.toJson());

class Hadeeth {
  Hadeeth({
    String? id,
    String? text,
  }) {
    _id = id;
    _text = text;
  }

  Hadeeth.fromJson(dynamic json) {
    _id = json['id'];
    _text = json['text'];
  }

  String? _id;
  String? _text;

  Hadeeth copyWith({
    String? id,
    String? text,
  }) =>
      Hadeeth(
        id: id ?? _id,
        text: text ?? _text,
      );

  String? get id => _id;

  String? get text => _text;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['text'] = _text;
    return map;
  }
}
