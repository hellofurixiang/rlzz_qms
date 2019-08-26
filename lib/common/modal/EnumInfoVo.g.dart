// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EnumInfoVo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnumInfoVo _$EnumInfoVoFromJson(Map<String, dynamic> json) {
  return EnumInfoVo(
      json['id'] as String,
      json['rowNum'] as int,
      json['enumValue'] as String,
      json['status'] as int,
      json['quotaType'] as bool);
}

Map<String, dynamic> _$EnumInfoVoToJson(EnumInfoVo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rowNum': instance.rowNum,
      'enumValue': instance.enumValue,
      'status': instance.status,
      'quotaType': instance.quotaType
    };
