import 'package:json_annotation/json_annotation.dart';

part 'ProductionOrder.g.dart';

@JsonSerializable()
class ProductionOrder extends Object {
  ///单据号
  @JsonKey(name: 'docNo')
  String docNo;

  ///单据日期
  @JsonKey(name: 'docDate')
  String docDate;

  ///客户
  @JsonKey(name: 'customerName')
  String customerName;

  ///备注
  @JsonKey(name: 'remark')
  String remark;

  ///附件
  @JsonKey(name: 'enclosure')
  String enclosure;

  ///行号
  @JsonKey(name: 'rowNo')
  String rowNo;

  ///附件
  @JsonKey(name: 'bodyEnclosure')
  String bodyEnclosure;

  ///物料编码
  @JsonKey(name: 'invCode')
  String invCode;

  ///物料名称
  @JsonKey(name: 'invName')
  String invName;

  ///规格型号
  @JsonKey(name: 'invSpec')
  String invSpec;

  ///数量
  @JsonKey(name: 'qty')
  String qty;

  ///主单位
  @JsonKey(name: 'mainUnit')
  String mainUnit;

  ///生产批号
  @JsonKey(name: 'batchNumber')
  String batchNumber;

  ///开工日期
  @JsonKey(name: 'startDate')
  String startDate;

  ///完工日期
  @JsonKey(name: 'completionDate')
  String completionDate;

  ///需求跟踪号
  @JsonKey(name: 'followNumber')
  String followNumber;

  ProductionOrder.empty();

  ProductionOrder(
    this.docNo,
    this.docDate,
    this.customerName,
    this.remark,
    this.enclosure,
    this.rowNo,
    this.bodyEnclosure,
    this.invCode,
    this.invName,
    this.invSpec,
    this.qty,
    this.mainUnit,
    this.batchNumber,
    this.startDate,
    this.completionDate,
    this.followNumber,
  );

  factory ProductionOrder.fromJson(Map<String, dynamic> srcJson) =>
      _$ProductionOrderFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProductionOrderToJson(this);
}
