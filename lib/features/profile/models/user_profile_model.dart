import 'package:agri_scan/core/base/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile_model.g.dart';

@JsonSerializable()
class UserProfile extends BaseModel {
  String? name;
  String? email;

  @JsonKey(name: 'phone_number')
  int? phoneNumber;
  String? avatar;

  UserProfile();

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}
