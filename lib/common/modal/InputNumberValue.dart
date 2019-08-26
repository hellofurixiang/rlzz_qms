import 'package:json_annotation/json_annotation.dart';
import 'package:qms/common/modal/BaseEntity.dart';

part 'InputNumberValue.g.dart';

@JsonSerializable()
class InputNumberValue extends BaseEntity {
  ///行号
  @JsonKey(name: 'rowNum')
  int rowNum;

  ///检测值
  @JsonKey(name: 'testQty')
  double testQty;

  ///检验项Id
  @JsonKey(name: 'testOrderDetailId')
  int testOrderDetailId;

  InputNumberValue.empty();
  InputNumberValue(
    this.rowNum,
    this.testQty,
    this.testOrderDetailId,
  );

  factory InputNumberValue.fromJson(Map<String, dynamic> srcJson) =>
      _$InputNumberValueFromJson(srcJson);

  Map<String, dynamic> toJson() => _$InputNumberValueToJson(this);
}
