import 'package:json_annotation/json_annotation.dart';
import 'package:qms/common/modal/BaseEntity.dart';

part 'GeneralVo.g.dart';

///通用实体类
@JsonSerializable()
class GeneralVo extends BaseEntity {
  int id;

  String arcCode;

  String arcName;

  bool isSelect;

  ///检验规则
  String testRule;

  String docCat;

  ///开始、结束日期
  String beginDate;
  String endDate;

  ///检验单号
  String docNo;

  ///物料编码
  String invCode;

  ///物料名称
  String invName;

  ///审核状态
  String auditStatus;

  ///检验员ID
  String checkerId;
  String checkerName;

  ///检验类型
  String testCat;

  ///物料分类
  String invCatCode;
  String invCatName;

  ///工序
  String opCode;
  String opName;

  String srcDocDetailId;
  String testTemplateId;
  String qty;

  int pageIndex;
  int pageSize;

  String checkStatus;
  String arrivalDocNo;

  ///生产订单号
  String moDocNo;

  ///来源单据号
  String srcDocNo;

  ///客户名称
  String cusCode;
  String cusName;

  ///批号
  String batchNumber;

  ///需求跟踪号
  String socode;

  ///产品类型
  String protype;

  ///报工单号
  String opDocNo;

  ///工作中心
  String wcCode;
  String wcName;

  ///供应商
  String supplierCode;
  String supplierName;

  GeneralVo.empty();

  GeneralVo(
    this.id,
    this.arcCode,
    this.arcName,
    this.isSelect,
    this.testRule,
    this.docCat,
    this.beginDate,
    this.endDate,
    this.docNo,
    this.invCode,
    this.invName,
    this.auditStatus,
    this.checkerId,
    this.checkerName,
    this.testCat,
    this.invCatCode,
    this.invCatName,
    this.opCode,
    this.opName,
    this.srcDocDetailId,
    this.testTemplateId,
    this.qty,
    this.pageIndex,
    this.pageSize,
    this.checkStatus,
    this.arrivalDocNo,
    this.moDocNo,
    this.srcDocNo,
    this.cusCode,
    this.cusName,
    this.batchNumber,
    this.socode,
    this.protype,
    this.opDocNo,
    this.wcCode,
    this.wcName,
    this.supplierCode,
    this.supplierName
  );

  factory GeneralVo.fromJson(Map<String, dynamic> srcJson) =>
      _$GeneralVoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$GeneralVoToJson(this);
}
