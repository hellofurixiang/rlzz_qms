// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PqcTestOrder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PqcTestOrder _$PqcTestOrderFromJson(Map<String, dynamic> json) {
  return PqcTestOrder(
    json['id'] as String,
    (json['quantity'] as num)?.toDouble(),
    (json['qualifiedQty'] as num)?.toDouble(),
    (json['scrapQty'] as num)?.toDouble(),
    (json['testQuotaList'] as List)
        ?.map((e) => e == null
            ? null
            : TestOrderDetailTestQuota.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['checkoutQty'] as num)?.toDouble(),
    (json['uncheckedQty'] as num)?.toDouble(),
    (json['mendingQty'] as num)?.toDouble(),
    (json['mendedQty'] as num)?.toDouble(),
    json['detailId'] as String,
    json['sampleBarcode'] as String,
    json['remark'] as String,
    json['tick'] as int,
    json['operator'] as String,
    json['state'] as String,
    json['testTime'] as int,
    json['measuringTool'] as String,
  );
}

Map<String, dynamic> _$PqcTestOrderToJson(PqcTestOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quantity': instance.quantity,
      'qualifiedQty': instance.qualifiedQty,
      'scrapQty': instance.scrapQty,
      'testQuotaList': instance.testQuotaList,
      'checkoutQty': instance.checkoutQty,
      'uncheckedQty': instance.uncheckedQty,
      'mendingQty': instance.mendingQty,
      'mendedQty': instance.mendedQty,
      'detailId': instance.detailId,
      'sampleBarcode': instance.sampleBarcode,
      'remark': instance.remark,
      'tick': instance.tick,
      'operator': instance.operator,
      'state': instance.state,
      'testTime': instance.testTime,
      'measuringTool': instance.measuringTool,
    };
