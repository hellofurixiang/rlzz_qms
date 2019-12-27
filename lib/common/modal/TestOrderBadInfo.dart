import 'package:json_annotation/json_annotation.dart';
import 'package:qms/common/modal/BaseEntity.dart';

part 'TestOrderBadInfo.g.dart';

@JsonSerializable()
class TestOrderBadInfo extends BaseEntity {
  @JsonKey(name: 'id')
  int id;

  ///行号
  @JsonKey(name: 'rowNum')
  int rowNum;

  ///不良原因编码

  @JsonKey(name: 'badReasonCode')
  String badReasonCode;

  /// 不良原因名称

  @JsonKey(name: 'badReasonName')
  String badReasonName;

  ///不良数量
  @JsonKey(name: 'badQty')
  double badQty;

  /// 检验单详情ID
  @JsonKey(name: 'testOrderDetailId')
  int testOrderDetailId;

  ///检验单ID
  @JsonKey(name: 'testOrderId')
  int testOrderId;

  TestOrderBadInfo.empty();

  TestOrderBadInfo(
    this.id,
    this.rowNum,
    this.badReasonCode,
    this.badReasonName,
    this.badQty,
    this.testOrderDetailId,
    this.testOrderId,
  );

  factory TestOrderBadInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$TestOrderBadInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TestOrderBadInfoToJson(this);
}
