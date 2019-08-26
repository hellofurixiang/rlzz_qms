import 'package:json_annotation/json_annotation.dart';
import 'package:qms/common/modal/AttachmentVo.dart';
import 'package:qms/common/modal/BaseEntity.dart';
import 'package:qms/common/modal/Enclosure.dart';

part 'TestOrderDetailTestQuota.g.dart';

///检验按样本检详情指标
@JsonSerializable()
class TestOrderDetailTestQuota extends BaseEntity {
  @JsonKey(name: 'id')
  int id;

  ///不良图片
  @JsonKey(name: 'badPictures')
  String badPictures;

  ///检验项目编码
  @JsonKey(name: 'testItemCode')
  String testItemCode;

  ///检验项目名称
  @JsonKey(name: 'testItemName')
  String testItemName;

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
  @JsonKey(name: 'testVal')
  String testVal;

  ///检验设备仪器
  @JsonKey(name: 'inspectionEquipment')
  String inspectionEquipment;

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

  ///操作者
  @JsonKey(name: 'producer')
  String producer;

  ///缺陷等级
  @JsonKey(name: 'defectLevel')
  String defectLevel;

  ///检验单ID
  @JsonKey(name: 'orderId')
  String orderId;

  ///检验单表体ID
  @JsonKey(name: 'orderDetailId')
  String orderDetailId;

  ///检验状态
  @JsonKey(name: 'state')
  bool state;

  @JsonKey(name: '检验模板表体ID')
  String testTemplateDetailId;

  TestOrderDetailTestQuota.empty();

  TestOrderDetailTestQuota(
      this.id,
      this.badPictures,
      this.testItemCode,
      this.testItemName,
      this.testQuotaCode,
      this.testQuotaName,
      this.quotaCat,
      this.testDecription,
      this.testMethodCode,
      this.testMethodName,
      this.testWay,
      this.standardValue,
      this.upperLimitValue,
      this.lowerLimitValue,
      this.testVal,
      this.inspectionEquipment,
      this.badReasonCode,
      this.badReasonName,
      this.badReasonInfo,
      this.enclosureList,
      this.enclosure,
      this.testQuotaEnclosureList,
      this.samplingWay,
      this.producer,
      this.defectLevel,
      this.orderId,
      this.orderDetailId,
      this.state,
      this.testTemplateDetailId);

  factory TestOrderDetailTestQuota.fromJson(Map<String, dynamic> srcJson) =>
      _$TestOrderDetailTestQuotaFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TestOrderDetailTestQuotaToJson(this);
}
