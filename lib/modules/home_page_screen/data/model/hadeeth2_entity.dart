import 'dart:convert';

import '../../../../generated/json/base/json_field.dart';
import '../../../../generated/json/hadeeth2_entity.g.dart';

@JsonSerializable()
class Hadeeth2Entity {
	String? id = '';
	String? text = '';

	Hadeeth2Entity();

	factory Hadeeth2Entity.fromJson(Map<String, dynamic> json) => $Hadeeth2EntityFromJson(json);

	Map<String, dynamic> toJson() => $Hadeeth2EntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}