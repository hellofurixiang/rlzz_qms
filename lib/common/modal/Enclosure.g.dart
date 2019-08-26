// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Enclosure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Enclosure _$EnclosureFromJson(Map<String, dynamic> json) {
  return Enclosure(
      json['id'] as String, json['name'] as String, json['size'] as String)
    ..remark = json['remark'] as String
    ..type = json['type'] as String
    ..uploader = json['uploader'] as String;
}

Map<String, dynamic> _$EnclosureToJson(Enclosure instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'size': instance.size,
      'remark': instance.remark,
      'type': instance.type,
      'uploader': instance.uploader
    };
