// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RefBasic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefBasic _$RefBasicFromJson(Map<String, dynamic> json) {
  return RefBasic(
      json['arcCode'] as String,
      json['arcName'] as String,
      json['isInDosage'] as bool,
      json['isStoSpaceMgmtWms'] as bool,
      json['isStoSpaceMgmtErp'] as bool)
    ..isSelect = json['isSelect'] as bool;
}

Map<String, dynamic> _$RefBasicToJson(RefBasic instance) => <String, dynamic>{
      'arcCode': instance.arcCode,
      'arcName': instance.arcName,
      'isInDosage': instance.isInDosage,
      'isStoSpaceMgmtWms': instance.isStoSpaceMgmtWms,
      'isStoSpaceMgmtErp': instance.isStoSpaceMgmtErp,
      'isSelect': instance.isSelect
    };
