import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';
import 'package:qms/common/modal/AttachmentVo.dart';
import 'package:qms/common/modal/BaseEntity.dart';
import 'package:qms/common/modal/Enclosure.dart';

part 'TestOrderDetail.g.dart';

@JsonSerializable()
class TestOrderDetail extends BaseEntity {
  @JsonKey(name: 'id')
  String id;

  ///不良图片
  @JsonKey(name: 'badPictures')
  String badPictures;

  ///检验项目编码
  @JsonKey(name: 'testItemCode')
  String testItemCode;

  ///检验项目名称
  @JsonKey(name: 'testItemName')
  String testItemName;

  ///AQL
  @JsonKey(name: 'aqlData')
  String aqlData;

  ///检验指标编码
  @JsonKey(name: 'testQuotaCode')
  String testQuotaCode;

  ///检验指标名称
  @JsonKey(name: 'testQuotaName')
  String testQuotaName;

  ///检验指标类型
  @JsonKey(name: 'quotaCat')
  String quotaCat;

  ///检验描述
  @JsonKey(name: 'testDecription')
  String testDecription;

  ///检验方法编码
  @JsonKey(name: 'testMethodCode')
  String testMethodCode;

  ///检验方法名称
  @JsonKey(name: 'testMethodName')
  String testMethodName;

  ///检验方式
  @JsonKey(name: 'testWay')
  String testWay;

  ///检验严格度
  @JsonKey(name: 'testStringency')
  String testStringency;

  ///检验水平
  @JsonKey(name: 'testLevel')
  String testLevel;

  ///AQL
  @JsonKey(name: 'aql')
  String aql;

  ///标准值
  @JsonKey(name: 'standardValue')
  String standardValue;

  ///上限值
  @JsonKey(name: 'upperLimitValue')
  String upperLimitValue;

  ///下限值
  @JsonKey(name: 'lowerLimitValue')
  String lowerLimitValue;

  ///检测值
  @JsonKey(name: 'testQtyInfo')
  String testQtyInfo;

  ///检验值详情
  @JsonKey(name: 'testQtyInfoDetail')
  String testQtyInfoDetail;

  ///检验设备仪器
  @JsonKey(name: 'inspectionEquipment')
  String inspectionEquipment;

  ///报检数量
  @JsonKey(name: 'quantity')
  double quantity;

  ///合格数量
  @JsonKey(name: 'qualifiedQty')
  double qualifiedQty;

  ///不良数量
  @JsonKey(name: 'unQualifiedQty')
  double unQualifiedQty;

  ///不良原因编码
  @JsonKey(name: 'badReasonCode')
  String badReasonCode;

  ///不良原因名称
  @JsonKey(name: 'badReasonName')
  String badReasonName;

  ///不良说明
  @JsonKey(name: 'badReasonInfo')
  String badReasonInfo;

  ///不良图片集合
  @JsonKey(name: 'enclosureList')
  List<AttachmentVo> enclosureList;

  ///缓存不良图片集合
  List<Enclosure> badEnclosureList;

  ///检验指标附件列表
  @JsonKey(name: 'enclosure')
  String enclosure;

  ///检验指标附件列表
  @JsonKey(name: 'testQuotaEnclosureList')
  List<Enclosure> testQuotaEnclosureList;

  ///抽检方式
  @JsonKey(name: 'samplingWay')
  String samplingWay;

  ///抽检比例%
  @JsonKey(name: 'samplingProportion')
  String samplingProportion;

  ///检验状态
  @JsonKey(name: 'testState')
  String testState;

  ///操作者
  @JsonKey(name: 'producer')
  String producer;

  ///选中颜色
  Color color;

  ///是否编辑过
  bool edited;

  ///检测值列表
  List testQtyInfoDetailList;

  ///修改时是否修改了检测值
  @JsonKey(name: 'operTestQtyInfo')
  bool operTestQtyInfo;

  ///测量工具编码
  @JsonKey(name: 'measuringToolCode')
  String measuringToolCode;

  ///测量工具名称
  @JsonKey(name: 'measuringToolName')
  String measuringToolName;

  TestOrderDetail.empty();

  TestOrderDetail(
      this.id,
      this.badPictures,
      this.testItemCode,
      this.testItemName,
      this.aqlData,
      this.testQuotaCode,
      this.testQuotaName,
      this.quotaCat,
      this.testDecription,
      this.testMethodCode,
      this.testMethodName,
      this.testWay,
      this.testStringency,
      this.testLevel,
      this.aql,
      this.standardValue,
      this.upperLimitValue,
      this.lowerLimitValue,
      this.testQtyInfo,
      this.testQtyInfoDetail,
      this.inspectionEquipment,
      this.quantity,
      this.qualifiedQty,
      this.unQualifiedQty,
      this.badReasonCode,
      this.badReasonName,
      this.badReasonInfo,
      this.enclosureList,
      this.enclosure,
      this.testQuotaEnclosureList,
      this.samplingWay,
      this.samplingProportion,
      this.testState,
      this.producer,
      this.measuringToolCode,
      this.measuringToolName);

  factory TestOrderDetail.fromJson(Map<String, dynamic> srcJson) =>
      _$TestOrderDetailFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TestOrderDetailToJson(this);
}
