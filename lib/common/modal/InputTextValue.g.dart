// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'InputTextValue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InputTextValue _$InputTextValueFromJson(Map<String, dynamic> json) {
  return InputTextValue(json['rowNum'] as int, json['testQty'] as String,
      json['testOrderDetailId'] as int);
}

Map<String, dynamic> _$InputTextValueToJson(InputTextValue instance) =>
    <String, dynamic>{
      'rowNum': instance.rowNum,
      'testQty': instance.testQty,
      'testOrderDetailId': instance.testOrderDetailId
    };
