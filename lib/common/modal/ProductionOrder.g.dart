// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProductionOrder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductionOrder _$ProductionOrderFromJson(Map<String, dynamic> json) {
  return ProductionOrder(
    json['docNo'] as String,
    json['docDate'] as String,
    json['customerName'] as String,
    json['remark'] as String,
    json['enclosure'] as String,
    json['rowNo'] as String,
    json['bodyEnclosure'] as String,
    json['invCode'] as String,
    json['invName'] as String,
    json['invSpec'] as String,
    json['qty'] as String,
    json['mainUnit'] as String,
    json['batchNumber'] as String,
    json['startDate'] as String,
    json['completionDate'] as String,
    json['followNumber'] as String,
  );
}

Map<String, dynamic> _$ProductionOrderToJson(ProductionOrder instance) =>
    <String, dynamic>{
      'docNo': instance.docNo,
      'docDate': instance.docDate,
      'customerName': instance.customerName,
      'remark': instance.remark,
      'enclosure': instance.enclosure,
      'rowNo': instance.rowNo,
      'bodyEnclosure': instance.bodyEnclosure,
      'invCode': instance.invCode,
      'invName': instance.invName,
      'invSpec': instance.invSpec,
      'qty': instance.qty,
      'mainUnit': instance.mainUnit,
      'batchNumber': instance.batchNumber,
      'startDate': instance.startDate,
      'completionDate': instance.completionDate,
      'followNumber': instance.followNumber
    };
