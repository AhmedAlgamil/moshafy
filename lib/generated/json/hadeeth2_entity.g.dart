
import '../../modules/home_page_screen/data/model/hadeeth2_entity.dart';
import 'base/json_convert_content.dart';

Hadeeth2Entity $Hadeeth2EntityFromJson(Map<String, dynamic> json) {
  final Hadeeth2Entity hadeeth2Entity = Hadeeth2Entity();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    hadeeth2Entity.id = id;
  }
  final String? text = jsonConvert.convert<String>(json['text']);
  if (text != null) {
    hadeeth2Entity.text = text;
  }
  return hadeeth2Entity;
}

Map<String, dynamic> $Hadeeth2EntityToJson(Hadeeth2Entity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['text'] = entity.text;
  return data;
}

extension Hadeeth2EntityExtension on Hadeeth2Entity {
  Hadeeth2Entity copyWith({
    String? id,
    String? text,
  }) {
    return Hadeeth2Entity()
      ..id = id ?? this.id
      ..text = text ?? this.text;
  }
}