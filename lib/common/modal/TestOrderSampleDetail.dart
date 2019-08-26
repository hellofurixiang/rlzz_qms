import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';
import 'package:qms/common/modal/BaseEntity.dart';
import 'package:qms/common/modal/TestOrderDetailTestQuota.dart';

part 'TestOrderSampleDetail.g.dart';

///检验按样本检详情
@JsonSerializable()
class TestOrderSampleDetail extends BaseEntity {
  @JsonKey(name: 'id')
  String id;

  ///备注
  @JsonKey(name: 'remark')
  String remark;

  ///样本条码
  @JsonKey(name: 'sampleBarcode')
  String sampleBarcode;

  ///操作
  @JsonKey(name: 'oper')
  String oper;

  ///一般缺陷数
  @JsonKey(name: 'generalDefectsQty')
  int generalDefectsQty;

  ///主要缺陷数
  @JsonKey(name: 'majorDefectsQty')
  int majorDefectsQty;

  ///严重缺陷数
  @JsonKey(name: 'seriousDefectsQty')
  int seriousDefectsQty;

  ///检验单表体指标列表
  //@JsonKey(name: 'testOrderDetailTestQuota')
  List<TestOrderDetailTestQuota> testOrderDetailTestQuota;

  ///选中颜色
  Color color;

  ///是否编辑过
  @JsonKey(name: 'edited')
  bool edited;

  ///指标录入状态
  @JsonKey(name: 'quotaState')
  bool quotaState;

  TestOrderSampleDetail(
      this.id,
      this.remark,
      this.sampleBarcode,
      this.oper,
      this.generalDefectsQty,
      this.majorDefectsQty,
      this.seriousDefectsQty,
      this.quotaState);

  factory TestOrderSampleDetail.fromJson(Map<String, dynamic> srcJson) =>
      _$TestOrderSampleDetailFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TestOrderSampleDetailToJson(this);
}
