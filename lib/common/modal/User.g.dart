// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
      json['account'] as String,
      json['closed'] as bool,
      json['email'] as String,
      json['inner'] as bool,
      json['lastLoginTime'] as int,
      json['lastUpdateTime'] as int,
      json['name'] as String,
      json['portrait'] as String,
      json['registrationTime'] as int,
      json['type'] as String);
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'account': instance.account,
      'closed': instance.closed,
      'email': instance.email,
      'inner': instance.inner,
      'lastLoginTime': instance.lastLoginTime,
      'lastUpdateTime': instance.lastUpdateTime,
      'name': instance.name,
      'portrait': instance.portrait,
      'registrationTime': instance.registrationTime,
      'type': instance.type
    };
