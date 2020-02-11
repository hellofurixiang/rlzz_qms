import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';
import 'package:qms/common/modal/BaseEntity.dart';

part 'QmsConfig.g.dart';

@JsonSerializable()
class QmsConfig extends BaseEntity {
  @JsonKey(name: 'config1')
  String config1;

  @JsonKey(name: 'config2')
  String config2;

  @JsonKey(name: 'enclosureServiceUrl')
  String enclosureServiceUrl;

  @JsonKey(name: 'qtyScale')
  int qtyScale;

  QmsConfig.empty();

  QmsConfig(
    this.config1,
    this.config2,
    this.enclosureServiceUrl,
    this.qtyScale,
  );

  factory QmsConfig.fromJson(Map<String, dynamic> srcJson) =>
      _$QmsConfigFromJson(srcJson);

  Map<String, dynamic> toJson() => _$QmsConfigToJson(this);
}
