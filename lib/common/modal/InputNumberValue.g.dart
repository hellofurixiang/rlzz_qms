// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'InputNumberValue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InputNumberValue _$InputNumberValueFromJson(Map<String, dynamic> json) {
  return InputNumberValue(json['rowNum'] as int, double.parse(json['testQty']),
      json['testOrderDetailId'] as int);
}

Map<String, dynamic> _$InputNumberValueToJson(InputNumberValue instance) =>
    <String, dynamic>{
      'rowNum': instance.rowNum,
      'testQty': instance.testQty,
      'testOrderDetailId': instance.testOrderDetailId
    };
