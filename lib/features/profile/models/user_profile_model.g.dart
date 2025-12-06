// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile()
  ..id = (json['id'] as num?)?.toInt()
  ..name = json['name'] as String?
  ..email = json['email'] as String?
  ..phoneNumber = (json['phone_number'] as num?)?.toInt()
  ..avatar = json['avatar'] as String?;

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'avatar': instance.avatar,
    };
