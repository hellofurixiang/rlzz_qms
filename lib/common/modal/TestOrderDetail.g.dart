// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TestOrderDetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestOrderDetail _$TestOrderDetailFromJson(Map<String, dynamic> json) {
  return TestOrderDetail(
      json['id'] as int,
      json['badPictures'] as String,
      json['testItemCode'] as String,
      json['testItemName'] as String,
      json['aqlData'] as String,
      json['testQuotaCode'] as String,
      json['testQuotaName'] as String,
      json['quotaCat'] as String,
      json['testDecription'] as String,
      json['testMethodCode'] as String,
      json['testMethodName'] as String,
      json['testWay'] as String,
      json['testStringency'] as String,
      json['testLevel'] as String,
      json['aql'] as String,
      json['standardValue'] == null ? '' : json['standardValue'].toString(),
      json['upperLimitValue'] == null ? '' : json['upperLimitValue'].toString(),
      json['lowerLimitValue'] == null ? '' : json['lowerLimitValue'].toString(),
      json['testQtyInfo'] as String,
      json['testQtyInfoDetail'] as String,
      json['inspectionEquipment'] as String,
      (json['quantity'] as num)?.toDouble(),
      (json['qualifiedQty'] as num)?.toDouble(),
      (json['unQualifiedQty'] as num)?.toDouble(),
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
      json['samplingProportion'] as String,
      json['testState'] as bool,
      json['producer'] as String,
      json['unitCode'] as String,
      json['unitName'] as String,
      json['measuringToolCode'] as String,
      json['measuringToolName'] as String);
}

Map<String, dynamic> _$TestOrderDetailToJson(TestOrderDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'badPictures': instance.badPictures,
      'testItemCode': instance.testItemCode,
      'testItemName': instance.testItemName,
      'aqlData': instance.aqlData,
      'testQuotaCode': instance.testQuotaCode,
      'testQuotaName': instance.testQuotaName,
      'quotaCat': instance.quotaCat,
      'testDecription': instance.testDecription,
      'testMethodCode': instance.testMethodCode,
      'testMethodName': instance.testMethodName,
      'testWay': instance.testWay,
      'testStringency': instance.testStringency,
      'testLevel': instance.testLevel,
      'aql': instance.aql,
      'standardValue': instance.standardValue,
      'upperLimitValue': instance.upperLimitValue,
      'lowerLimitValue': instance.lowerLimitValue,
      'testQtyInfo': instance.testQtyInfo,
      'testQtyInfoDetail': instance.testQtyInfoDetail,
      'inspectionEquipment': instance.inspectionEquipment,
      'quantity': instance.quantity,
      'qualifiedQty': instance.qualifiedQty,
      'unQualifiedQty': instance.unQualifiedQty,
      'badReasonCode': instance.badReasonCode,
      'badReasonName': instance.badReasonName,
      'badReasonInfo': instance.badReasonInfo,
      'enclosureList': instance.enclosureList,
      'enclosure': instance.enclosure,
      'testQuotaEnclosureList': instance.testQuotaEnclosureList,
      'samplingWay': instance.samplingWay,
      'samplingProportion': instance.samplingProportion,
      'testState': instance.testState,
      'producer': instance.producer,
      'operTestQtyInfo': instance.operTestQtyInfo,
      'unitCode': instance.unitCode,
      'unitName': instance.unitName,
      'measuringToolCode': instance.measuringToolCode,
      'measuringToolName': instance.measuringToolName
    };
