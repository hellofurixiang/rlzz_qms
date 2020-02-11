// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QmsConfig.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QmsConfig _$QmsConfigFromJson(Map<String, dynamic> json) {
  return QmsConfig(
    json['config1'] as String,
    json['config2'] as String,
    json['enclosureServiceUrl'] as String,
    json['qtyScale'] as int,
  );
}

Map<String, dynamic> _$QmsConfigToJson(QmsConfig instance) => <String, dynamic>{
      'config1': instance.config1,
      'config2': instance.config2,
      'enclosureServiceUrl': instance.enclosureServiceUrl,
      'qtyScale': instance.qtyScale
    };
