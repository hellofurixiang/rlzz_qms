import 'package:json_annotation/json_annotation.dart';
import 'package:qms/common/modal/BaseEntity.dart';

part 'EnumInfoVo.g.dart';

@JsonSerializable()
class EnumInfoVo extends BaseEntity {
  ///枚举ID
  @JsonKey(name: 'id')
  String id;

  ///行号
  @JsonKey(name: 'rowNum')
  int rowNum;

  ///枚举值
  @JsonKey(name: 'enumValue')
  String enumValue;

  ///状态:0未勾选1勾选
  @JsonKey(name: 'status')
  int status;

  ///指标类型（false 单选、true 多选）
  @JsonKey(name: 'quotaType')
  bool quotaType;

  EnumInfoVo(
    this.id,
    this.rowNum,
    this.enumValue,
    this.status,
    this.quotaType,
  );

  factory EnumInfoVo.fromJson(Map<String, dynamic> srcJson) =>
      _$EnumInfoVoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$EnumInfoVoToJson(this);
}
