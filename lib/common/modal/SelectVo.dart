import 'package:json_annotation/json_annotation.dart';
import 'package:qms/common/modal/BaseEntity.dart';

///选择实体类
@JsonSerializable()
class SelectVo extends BaseEntity {
  String value;

  String text;

  bool isSelect;

  bool isDefault;

  SelectVo.empty();

  SelectVo(this.value, this.text,
      {this.isSelect: false, this.isDefault: false});
}
