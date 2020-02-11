import 'package:json_annotation/json_annotation.dart';
import 'package:qms/common/modal/BaseEntity.dart';

part 'InvEnclosure.g.dart';

@JsonSerializable()
class InvEnclosure extends BaseEntity {
  String code;
  String name;
  String size;
  String effectiveDate;
  String deactivationDate;
  String docVer;
  String docFullName;
  String docFullNameBak;
  String docFileType;

  InvEnclosure(
    this.code,
    this.name,
    this.size,
    this.effectiveDate,
    this.deactivationDate,
    this.docVer,
    this.docFullName,
    this.docFullNameBak,
    this.docFileType,
  );

  factory InvEnclosure.fromJson(Map<String, dynamic> srcJson) =>
      _$InvEnclosureFromJson(srcJson);

  Map<String, dynamic> toJson() => _$InvEnclosureToJson(this);
}
