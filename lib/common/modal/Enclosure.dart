import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';
import 'package:qms/common/modal/BaseEntity.dart';

part 'Enclosure.g.dart';

@JsonSerializable()
class Enclosure extends BaseEntity {
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'size')
  String size;

  @JsonKey(name: 'remark')
  String remark;

  ///缩略图
  Future<Uint8List> thumbnail;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'uploader')
  String uploader;

  ///字节
  Future<Uint8List> uint8list;

  ///文件
  Future<File> file;

  File localFile;

  ///文件大小
  Future<Size> fileSize;

  String path;

  int index;

  Enclosure.empty();

  Enclosure(
    this.id,
    this.name,
    this.size,
  );

  factory Enclosure.fromJson(Map<String, dynamic> srcJson) =>
      _$EnclosureFromJson(srcJson);

  Map<String, dynamic> toJson() => _$EnclosureToJson(this);
}
