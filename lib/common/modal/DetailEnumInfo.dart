import 'package:json_annotation/json_annotation.dart';
import 'package:qms/common/modal/BaseEntity.dart';

import 'EnumInfoVo.dart';

part 'DetailEnumInfo.g.dart';

@JsonSerializable()
class DetailEnumInfo extends BaseEntity {
  ///检验指标ID
  /*@JsonKey(name: 'testQuotaId')
  String testQuotaId;*/

  @JsonKey(name: 'testQuotaCode')
  String testQuotaCode;

  ///枚举值ID
  //@JsonKey(name: 'testQuotaEnumId')
  //int testQuotaEnumId;

  ///行号
  @JsonKey(name: 'rowNum')
  int rowNum;

  ///检验单详情ID
  @JsonKey(name: 'testOrderDetailId')
  String testOrderDetailId;

  ///指标类型（false 单选、 true 多选)
  @JsonKey(name: 'quotaType')
  bool quotaType;

  ///枚举详情列表
  @JsonKey(name: 'detailList')
  List<EnumInfoVo> detailList;

  DetailEnumInfo.empty();

  DetailEnumInfo(
    this.testQuotaCode,
    //this.testQuotaId,
    //this.testQuotaEnumId,
    this.rowNum,
    this.testOrderDetailId,
    this.quotaType,
    this.detailList,
  );

  factory DetailEnumInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$DetailEnumInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DetailEnumInfoToJson(this);
}
