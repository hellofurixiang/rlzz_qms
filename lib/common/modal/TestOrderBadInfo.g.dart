// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TestOrderBadInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestOrderBadInfo _$TestOrderBadInfoFromJson(Map<String, dynamic> json) {
  return TestOrderBadInfo(
    json['id'] as int,
    json['rowNum'] as int,
    json['badReasonCode'] as String,
    json['badReasonName'] as String,
    json['badQty'] as double,
    json['testOrderDetailId'] as int,
    json['testOrderId'] as int,
  );
}

Map<String, dynamic> _$TestOrderBadInfoToJson(TestOrderBadInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rowNum': instance.rowNum,
      'badReasonCode': instance.badReasonCode,
      'badReasonName': instance.badReasonName,
      'badQty': instance.badQty,
      'testOrderDetailId': instance.testOrderDetailId,
      'testOrderId': instance.testOrderId
    };
