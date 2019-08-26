import 'package:json_annotation/json_annotation.dart';
import 'package:qms/common/modal/BaseEntity.dart';

part 'InputTextValue.g.dart';

@JsonSerializable()
class InputTextValue extends BaseEntity {
  ///行号
  @JsonKey(name: 'rowNum')
  int rowNum;

  ///检测值
  @JsonKey(name: 'testQty')
  String testQty;

  ///检验项Id
  @JsonKey(name: 'testOrderDetailId')
  int testOrderDetailId;

  InputTextValue.empty();

  InputTextValue(
    this.rowNum,
    this.testQty,
    this.testOrderDetailId,
  );

  factory InputTextValue.fromJson(Map<String, dynamic> srcJson) =>
      _$InputTextValueFromJson(srcJson);

  Map<String, dynamic> toJson() => _$InputTextValueToJson(this);
}
