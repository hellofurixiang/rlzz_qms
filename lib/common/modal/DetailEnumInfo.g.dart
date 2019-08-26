// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DetailEnumInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailEnumInfo _$DetailEnumInfoFromJson(Map<String, dynamic> json) {
  return DetailEnumInfo(
      json['testQuotaCode'] as String,
      //json['testQuotaEnumId'] as int,
      json['rowNum'] as int,
      json['testOrderDetailId'] as String,
      json['quotaType'] as bool,
      (json['detailList'] as List)
          ?.map((e) =>
              e == null ? null : EnumInfoVo.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$DetailEnumInfoToJson(DetailEnumInfo instance) =>
    <String, dynamic>{
      'testQuotaCode': instance.testQuotaCode,
      //'testQuotaEnumId': instance.testQuotaEnumId,
      'rowNum': instance.rowNum,
      'testOrderDetailId': instance.testOrderDetailId,
      'quotaType': instance.quotaType,
      'detailList': instance.detailList
    };
