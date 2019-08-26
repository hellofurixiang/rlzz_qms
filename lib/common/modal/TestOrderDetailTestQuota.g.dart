// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TestOrderDetailTestQuota.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestOrderDetailTestQuota _$TestOrderDetailTestQuotaFromJson(
    Map<String, dynamic> json) {
  return TestOrderDetailTestQuota(
      json['id'] as int,
      json['badPictures'] as String,
      json['testItemCode'] as String,
      json['testItemName'] as String,
      json['testQuotaCode'] as String,
      json['testQuotaName'] as String,
      json['quotaCat'] as String,
      json['testDecription'] as String,
      json['testMethodCode'] as String,
      json['testMethodName'] as String,
      json['testWay'] as String,
      json['standardValue'] == null ? '' : json['standardValue'].toString(),
      json['upperLimitValue'] == null ? '' : json['upperLimitValue'].toString(),
      json['lowerLimitValue'] == null ? '' : json['lowerLimitValue'].toString(),
      json['testVal'] as String,
      json['inspectionEquipment'] as String,
      json['badReasonCode'] as String,
      json['badReasonName'] as String,
      json['badReasonInfo'] as String,
      (json['enclosureList'] as List)
          ?.map((e) => e == null
              ? null
              : AttachmentVo.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['enclosure'] as String,
      (json['testQuotaEnclosureList'] as List)
          ?.map((e) =>
              e == null ? null : Enclosure.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['samplingWay'] as String,
      json['producer'] as String,
      json['defectLevel'] as String,
      json['orderId'] as String,
      json['orderDetailId'] as String,
      json['state'] == null ? false : json['state'] as bool,
      json['testTemplateDetailId'] as String);
}

Map<String, dynamic> _$TestOrderDetailTestQuotaToJson(
        TestOrderDetailTestQuota instance) =>
    <String, dynamic>{
      'id': instance.id,
      'badPictures': instance.badPictures,
      'testItemCode': instance.testItemCode,
      'testItemName': instance.testItemName,
      'testQuotaCode': instance.testQuotaCode,
      'testQuotaName': instance.testQuotaName,
      'quotaCat': instance.quotaCat,
      'testDecription': instance.testDecription,
      'testMethodCode': instance.testMethodCode,
      'testMethodName': instance.testMethodName,
      'testWay': instance.testWay,
      'standardValue': instance.standardValue,
      'upperLimitValue': instance.upperLimitValue,
      'lowerLimitValue': instance.lowerLimitValue,
      'testVal': instance.testVal,
      'inspectionEquipment': instance.inspectionEquipment,
      'badReasonCode': instance.badReasonCode,
      'badReasonName': instance.badReasonName,
      'badReasonInfo': instance.badReasonInfo,
      'enclosureList': instance.enclosureList,
      'enclosure': instance.enclosure,
      'testQuotaEnclosureList': instance.testQuotaEnclosureList,
      'samplingWay': instance.samplingWay,
      'producer': instance.producer,
      'defectLevel': instance.defectLevel,
      'orderId': instance.orderId,
      'orderDetailId': instance.orderDetailId,
      'state': instance.state,
      'testTemplateDetailId': instance.testTemplateDetailId,
    };
