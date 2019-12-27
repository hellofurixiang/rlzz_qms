// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TestOrderSampleDetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

List<TestOrderDetailTestQuota> testOrderDetailTestQuota;

TestOrderSampleDetail _$TestOrderSampleDetailFromJson(
    Map<String, dynamic> json) {
  return TestOrderSampleDetail(
    json['id'] as String,
    json['remark'] as String,
    json['sampleBarcode'] as String,
    json['oper'] as String,
    (json['generalDefectsQty'] as num)?.toInt(),
    (json['majorDefectsQty'] as num)?.toInt(),
    (json['seriousDefectsQty'] as num)?.toInt(),
    json['quotaState'] as bool,
    json['timeInterval'] as String,
    (json['testOrderDetailTestQuota'] as List)
        ?.map((e) => e == null
            ? null
            : TestOrderDetailTestQuota.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['rowNo'] as int,
    json['state'] as String,
    json['testTime'] as int,
    (json['tick'] as num)?.toInt(),
    json['operator'] as String,
    json['measuringTool'] as String,
  );
}

Map<String, dynamic> _$TestOrderSampleDetailToJson(
        TestOrderSampleDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'remark': instance.remark,
      'sampleBarcode': instance.sampleBarcode,
      'oper': instance.oper,
      'generalDefectsQty': instance.generalDefectsQty,
      'majorDefectsQty': instance.majorDefectsQty,
      'seriousDefectsQty': instance.seriousDefectsQty,
      'edited': instance.edited,
      'quotaState': instance.quotaState,
      'timeInterval': instance.timeInterval,
      'testOrderDetailTestQuota': instance.testOrderDetailTestQuota,
      'rowNo': instance.rowNo,
      'state': instance.state,
      'testTime': instance.testTime,
      'tick': instance.tick,
      'operator': instance.operator,
      'measuringTool': instance.measuringTool,
    };
