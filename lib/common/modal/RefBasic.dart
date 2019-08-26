import 'package:json_annotation/json_annotation.dart';
import 'package:qms/common/modal/BaseEntity.dart';
part 'RefBasic.g.dart';

@JsonSerializable()
class RefBasic extends BaseEntity {
  @JsonKey(name: 'arcCode')
  String arcCode;

  @JsonKey(name: 'arcName')
  String arcName;

  @JsonKey(name: 'isInDosage')
  bool isInDosage;

  @JsonKey(name: 'isStoSpaceMgmtWms')
  bool isStoSpaceMgmtWms;

  @JsonKey(name: 'isStoSpaceMgmtErp')
  bool isStoSpaceMgmtErp;

  bool isSelect = false;
  RefBasic.empty();
  RefBasic.init(this.arcCode, this.arcName);

  RefBasic(
    this.arcCode,
    this.arcName,
    this.isInDosage,
    this.isStoSpaceMgmtWms,
    this.isStoSpaceMgmtErp,
  );

  factory RefBasic.fromJson(Map<String, dynamic> srcJson) =>
      _$RefBasicFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RefBasicToJson(this);
}
