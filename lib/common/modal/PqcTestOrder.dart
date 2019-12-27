import 'package:json_annotation/json_annotation.dart';
import 'package:qms/common/modal/BaseEntity.dart';
import 'package:qms/common/modal/TestOrderDetailTestQuota.dart';

part 'PqcTestOrder.g.dart';

@JsonSerializable()
class PqcTestOrder extends BaseEntity {
  ///单据ID
  @JsonKey(name: 'id')
  String id;

  ///报检数量
  @JsonKey(name: 'quantity')
  double quantity;

  ///合格数量
  @JsonKey(name: 'qualifiedQty')
  double qualifiedQty;

  ///报废数量
  @JsonKey(name: 'scrapQty')
  double scrapQty;

  ///检验指标信息列表
  @JsonKey(name: 'testQuotaList')
  List<TestOrderDetailTestQuota> testQuotaList;

  ///已检数量
  @JsonKey(name: 'checkoutQty')
  double checkoutQty;

  ///未检数量
  @JsonKey(name: 'uncheckedQty')
  double uncheckedQty;

  ///在修数量
  @JsonKey(name: 'mendingQty')
  double mendingQty;

  ///已修数量
  @JsonKey(name: 'mendedQty')
  double mendedQty;

  ///表体ID
  @JsonKey(name: 'detailId')
  String detailId;

  ///样本条码
  @JsonKey(name: 'sampleBarcode')
  String sampleBarcode;

  ///描述
  @JsonKey(name: 'remark')
  String remark;

  ///次数
  @JsonKey(name: 'tick')
  int tick;

  ///操作者
  @JsonKey(name: 'operator')
  String operator;

  ///状态
  @JsonKey(name: 'state')
  String state;

  ///检测时间
  @JsonKey(name: 'testTime')
  int testTime;

  ///测量工具
  @JsonKey(name: 'measuringTool')
  String measuringTool;

  PqcTestOrder.empty();

  PqcTestOrder(
      this.id,
      this.quantity,
      this.qualifiedQty,
      this.scrapQty,
      this.testQuotaList,
      this.checkoutQty,
      this.uncheckedQty,
      this.mendingQty,
      this.mendedQty,
      this.detailId,
      this.sampleBarcode,
      this.remark,
      this.tick,
      this.operator,
      this.state,
      this.testTime,
      this.measuringTool);

  factory PqcTestOrder.fromJson(Map<String, dynamic> srcJson) =>
      _$PqcTestOrderFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PqcTestOrderToJson(this);
}
