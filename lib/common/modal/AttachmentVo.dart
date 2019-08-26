import 'package:json_annotation/json_annotation.dart';
import 'package:qms/common/modal/BaseEntity.dart';
part 'AttachmentVo.g.dart';

@JsonSerializable()
class AttachmentVo extends BaseEntity {
  String id;

  String name;

  String size;

  AttachmentVo.empty();

  AttachmentVo(
    this.id,
    this.name,
    this.size,
  );

  factory AttachmentVo.fromJson(Map<String, dynamic> srcJson) =>
      _$AttachmentVoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AttachmentVoToJson(this);
}
