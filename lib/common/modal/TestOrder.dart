import 'package:json_annotation/json_annotation.dart';
import 'package:qms/common/modal/AttachmentVo.dart';
import 'package:qms/common/modal/BaseEntity.dart';
import 'package:qms/common/modal/Enclosure.dart';
import 'package:qms/common/modal/TestOrderBadInfo.dart';
import 'package:qms/common/modal/TestOrderDetail.dart';

import 'TestOrderSampleDetail.dart';

part 'TestOrder.g.dart';

@JsonSerializable()
class TestOrder extends BaseEntity {
  @JsonKey(name: 'id')
  String id;

  ///检验单号
  @JsonKey(name: 'docNo')
  String docNo;

  ///检验日期
  @JsonKey(name: 'docDate')
  int docDate;

  ///检验员
  @JsonKey(name: 'operator')
  String operator;

  ///检验员
  @JsonKey(name: 'operatorName')
  String operatorName;

  ///检验员id
  @JsonKey(name: 'operatorId')
  String operatorId;

  ///检验类型
  @JsonKey(name: 'testCat')
  String testCat;

  ///检验模板编码
  @JsonKey(name: 'testTemplateCode')
  String testTemplateCode;

  ///检验模板名称
  @JsonKey(name: 'testTemplateName')
  String testTemplateName;

  ///来源单据类型
  @JsonKey(name: 'srcDocType')
  String srcDocType;

  ///来源单据号
  @JsonKey(name: 'srcDocNo')
  String srcDocNo;

  ///行号
  @JsonKey(name: 'srcDocRowNum')
  String srcDocRowNum;

  ///来源单据id
  @JsonKey(name: 'srcDocId')
  String srcDocId;

  ///来源单据表体id
  @JsonKey(name: 'srcDocDetailId')
  String srcDocDetailId;

  ///报检数量
  @JsonKey(name: 'quantity')
  double quantity;

  ///样本数量
  @JsonKey(name: 'sampleQty')
  double sampleQty;

  ///报检数量
  @JsonKey(name: 'oldCheckQty')
  double oldCheckQty;

  ///合格数量
  @JsonKey(name: 'qualifiedQty')
  double qualifiedQty;

  ///不合格数量
  @JsonKey(name: 'unQualifiedQty')
  double unQualifiedQty;

  ///返工数量
  @JsonKey(name: 'reworkQty')
  double reworkQty;

  ///报废数量
  @JsonKey(name: 'scrapQty')
  double scrapQty;

  ///让步接收数
  @JsonKey(name: 'concessionReceivedQuantity')
  double concessionReceivedQuantity;

  ///附件
  @JsonKey(name: 'enclosure')
  String enclosure;

  ///检验详情
  @JsonKey(name: 'testOrderDetail')
  List<TestOrderDetail> testOrderDetail;

  ///检验按样本检详情
  @JsonKey(name: 'testOrderSampleDetail')
  List<TestOrderSampleDetail> testOrderSampleDetail;

  ///报检日期
  @JsonKey(name: 'inspectionDate')
  String inspectionDate;

  ///生产订单号
  @JsonKey(name: 'moDocNo')
  String moDocNo;

  ///生产订单详情ID
  @JsonKey(name: 'moDetailId')
  String moDetailId;

  ///供应商名称
  @JsonKey(name: 'supplierName')
  String supplierName;

  ///供应商编码
  @JsonKey(name: 'supplierCode')
  String supplierCode;

  ///工序编码
  @JsonKey(name: 'workStepCode')
  String workStepCode;

  ///工序名称
  @JsonKey(name: 'workStepName')
  String workStepName;

  ///物料编码
  @JsonKey(name: 'invCode')
  String invCode;

  ///物料分类编码
  @JsonKey(name: 'invCatCode')
  String invCatCode;

  ///物料分类名称
  @JsonKey(name: 'invCatName')
  String invCatName;

  ///单据类型
  @JsonKey(name: 'docCat')
  String docCat;

  ///物料名称
  @JsonKey(name: 'invName')
  String invName;

  ///规格型号
  @JsonKey(name: 'invSpec')
  String invSpec;

  ///可检数量
  @JsonKey(name: 'detectableQuantity')
  double detectableQuantity;

  ///附件列表
  @JsonKey(name: 'enclosureList')
  List<AttachmentVo> enclosureList;

  ///缓存附件列表
  List<Enclosure> badEnclosureList;

  ///审核状态
  @JsonKey(name: 'auditStatus')
  bool auditStatus;

  ///不良说明
  @JsonKey(name: 'badReasonInfo')
  String badReasonInfo;

  ///不良原因ID
  @JsonKey(name: 'badReasonId')
  String badReasonId;

  ///不良原因编码
  @JsonKey(name: 'badReasonCode')
  String badReasonCode;

  ///不良原因名称
  @JsonKey(name: 'badReasonName')
  String badReasonName;

  ///检验结果
  @JsonKey(name: 'testResult')
  String testResult;

  ///特采数量
  @JsonKey(name: 'spQty')
  double spQty;

  ///来源单据数量
  @JsonKey(name: 'srcCheckQty')
  double srcCheckQty;

  ///部门名称
  @JsonKey(name: 'depName')
  String depName;

  ///cusName
  @JsonKey(name: 'cusName')
  String cusName;

  ///批号
  @JsonKey(name: 'batchNumber')
  String batchNumber;

  ///操作者
  @JsonKey(name: 'producer')
  String producer;

  ///来源单据时间戳
  @JsonKey(name: 'srcTimestamp')
  String srcTimestamp;

  ///时间戳
  @JsonKey(name: 'timestamp')
  String timestamp;

  ///产品类型
  @JsonKey(name: 'protype')
  String protype;

  ///需求跟踪号
  @JsonKey(name: 'socode')
  String socode;

  ///签名
  @JsonKey(name: 'signPic')
  String signPic;

  ///签名
  Enclosure signImage;

  ///版本
  @JsonKey(name: 'version')
  int version;

  ///一般缺陷数
  @JsonKey(name: 'generalDefectsQty')
  int generalDefectsQty;

  ///主要缺陷数
  @JsonKey(name: 'majorDefectsQty')
  int majorDefectsQty;

  ///严重缺陷数
  @JsonKey(name: 'seriousDefectsQty')
  int seriousDefectsQty;

  ///备注
  @JsonKey(name: 'remark')
  String remark;

  ///不良信息
  @JsonKey(name: 'badInfoList')
  List<TestOrderBadInfo> badInfoList;

  ///已修好
  @JsonKey(name: 'mendedQty')
  double mendedQty;

  ///在修数量
  @JsonKey(name: 'mendingQty')
  double mendingQty;

  ///已检数量
  @JsonKey(name: 'checkoutQty')
  double checkoutQty;

  ///未检数量
  @JsonKey(name: 'uncheckedQty')
  double uncheckedQty;

  /*quantity	单据数量
  qualifiedQty	合格数量
  reworkQty	未修好
  scrapQty	报废数量
  mendedQty	已修好
  mendingQty	在修数量
  checkoutQty	已检数量
  uncheckedQty	未检数量
  unQualifiedQty	累计不良数量*/

  TestOrder(
      this.id,
      this.docNo,
      this.docDate,
      this.operator,
      this.operatorName,
      this.operatorId,
      this.testCat,
      this.testTemplateCode,
      this.testTemplateName,
      this.srcDocType,
      this.srcDocNo,
      this.srcDocRowNum,
      this.srcDocId,
      this.srcDocDetailId,
      this.quantity,
      this.sampleQty,
      this.oldCheckQty,
      this.qualifiedQty,
      this.unQualifiedQty,
      this.reworkQty,
      this.scrapQty,
      this.concessionReceivedQuantity,
      this.enclosure,
      this.inspectionDate,
      this.moDocNo,
      this.moDetailId,
      this.supplierName,
      this.supplierCode,
      this.workStepCode,
      this.workStepName,
      this.invCode,
      this.invCatCode,
      this.invCatName,
      this.docCat,
      this.invName,
      this.invSpec,
      this.detectableQuantity,
      this.auditStatus,
      this.badReasonInfo,
      this.badReasonId,
      this.badReasonCode,
      this.badReasonName,
      this.testResult,
      this.spQty,
      this.srcCheckQty,
      this.depName,
      this.cusName,
      this.batchNumber,
      this.producer,
      this.srcTimestamp,
      this.timestamp,
      this.protype,
      this.socode,
      this.signPic,
      this.version,
      this.testOrderDetail,
      this.testOrderSampleDetail,
      this.enclosureList,
      this.generalDefectsQty,
      this.majorDefectsQty,
      this.seriousDefectsQty,
      this.remark,
      this.badInfoList,
      this.mendedQty,
      this.mendingQty,
      this.checkoutQty,
      this.uncheckedQty);

  factory TestOrder.fromJson(Map<String, dynamic> srcJson) =>
      _$TestOrderFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TestOrderToJson(this);
}
