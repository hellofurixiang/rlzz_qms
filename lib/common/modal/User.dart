import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

@JsonSerializable()
class User extends Object {
  @JsonKey(name: 'account')
  String account;

  @JsonKey(name: 'closed')
  bool closed;

  @JsonKey(name: 'email')
  String email;

  @JsonKey(name: 'inner')
  bool inner;

  @JsonKey(name: 'lastLoginTime')
  int lastLoginTime;

  @JsonKey(name: 'lastUpdateTime')
  int lastUpdateTime;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'portrait')
  String portrait;

  @JsonKey(name: 'registrationTime')
  int registrationTime;

  @JsonKey(name: 'type')
  String type;

  User(
    this.account,
    this.closed,
    this.email,
    this.inner,
    this.lastLoginTime,
    this.lastUpdateTime,
    this.name,
    this.portrait,
    this.registrationTime,
    this.type,
  );

  factory User.fromJson(Map<String, dynamic> srcJson) =>
      _$UserFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
