// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'InvEnclosure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvEnclosure _$InvEnclosureFromJson(Map<String, dynamic> json) {
  return InvEnclosure(
      json['code'] as String,
      json['name'] as String,
      json['size'] as String,
      json['effectiveDate'] as String,
      json['deactivationDate'] as String,
      json['docVer'] as String,
      json['docFullName'] as String,
      json['docFullNameBak'] as String,
      json['docFileType'] as String);
}

Map<String, dynamic> _$InvEnclosureToJson(InvEnclosure instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'size': instance.size,
      'effectiveDate': instance.effectiveDate,
      'deactivationDate': instance.deactivationDate,
      'docVer': instance.docVer,
      'docFullName': instance.docFullName,
      'docFullNameBak': instance.docFullNameBak,
      'docFileType': instance.docFileType,
    };
