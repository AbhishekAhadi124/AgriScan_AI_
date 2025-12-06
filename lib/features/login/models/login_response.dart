import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  String? refresh;
  String? access;
  String? email;
  String? avatar;
  String? name;
  @JsonKey(name: 'access_token_expire')
  int? accessTokenExpire;

  @JsonKey(name: 'refresh_token_expire')
  int? refreshTokenExpire;

  @JsonKey(name: "login_time", fromJson: _fromJson, toJson: _toJson)
  DateTime? loginTime;

  LoginResponse({
    this.refresh,
    this.access,
    this.email,
    this.avatar,
    this.name,
    this.accessTokenExpire,
    this.refreshTokenExpire,
    DateTime? loginTime,
  }) : loginTime = loginTime ?? DateTime.now();

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

  static DateTime? _fromJson(int? timestamp) =>
      timestamp != null ? DateTime.fromMillisecondsSinceEpoch(timestamp) : null;

  static int? _toJson(DateTime? time) => time?.millisecondsSinceEpoch;
}
