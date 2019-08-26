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
      json['quotaState'] as bool);
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
      'quotaState': instance.quotaState
    };
