import 'dart:convert';
import 'package:agri_scan/features/login/models/login_response.dart';
import 'package:agri_scan/features/profile/models/user_profile_model.dart'
    as profile;
import 'package:agri_scan/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils {
  PrefUtils() {
    SharedPreferences.getInstance().then((value) {
      sharedPreferences = value;
    });
  }

  static SharedPreferences? sharedPreferences;
  static const String isCheckedIn = 'is_checked_in';

  Future<void> init() async {
    sharedPreferences ??= await SharedPreferences.getInstance();
    debugPrint('SharedPreference Initialized');
  }

  void clearPreferencesData() async {
    sharedPreferences!.clear();
  }

  Future<void> setToken(String value) {
    return sharedPreferences!.setString('token', value);
  }

  String getToken() {
    try {
      String status = checkToken();
      if (status == 'login') {
        Get.offNamed(MyRoutes.loginRoute);
      } else if (status == 'token') {
        LoginResponse user = LoginResponse.fromJson(json.decode(getUser()));
        return user.access ?? '';
      }
      return status;
    } catch (e) {
      return '';
    }
  }

  String getRefreshToken() {
    try {
      LoginResponse user = LoginResponse.fromJson(json.decode(getUser()));
      return user.refresh ?? '';
    } catch (e) {
      return '';
    }
  }

  String checkToken() {
    if (getUser().isEmpty) return 'login';
    LoginResponse user = LoginResponse.fromJson(json.decode(getUser()));
    DateTime currentTime = DateTime.now();
    DateTime? loginTime = user.loginTime;
    int? accessTokenExpire = user.accessTokenExpire;
    int? refreshTokenExpire = user.refreshTokenExpire;

    if (loginTime != null && refreshTokenExpire != null) {
      DateTime refreshExpirationTime = loginTime.add(
        Duration(seconds: refreshTokenExpire),
      );
      bool refreshCurrentTime = currentTime.isAfter(refreshExpirationTime);
      if (accessTokenExpire != null && refreshCurrentTime == false) {
        DateTime accessExpirationTime = loginTime.add(
          Duration(seconds: accessTokenExpire),
        );
        if (currentTime.isAfter(accessExpirationTime)) {
          return 'refresh_token';
        }
        return 'token';
      }
    }
    return 'login';
  }

  Future<void> deleteToken() {
    return sharedPreferences!.setString('token', "");
  }

  Future<void> setUser(LoginResponse value) {
    return sharedPreferences!.setString('user', json.encode(value.toJson()));
  }

  String getUser() {
    try {
      return sharedPreferences?.getString('user') ?? '{}';
    } catch (e) {
      return '';
    }
  }

  Future<void> updateUser(profile.UserProfile profileResponse) async {
    final storedUserJson = sharedPreferences!.getString('user');
    if (storedUserJson != null) {
      final Map<String, dynamic> userMap = json.decode(storedUserJson);
      LoginResponse loginResponse = LoginResponse.fromJson(userMap);

      loginResponse.name = profileResponse.name;
      loginResponse.email = profileResponse.email;
      loginResponse.avatar = profileResponse.avatar;

      await sharedPreferences!.setString(
        'user',
        json.encode(loginResponse.toJson()),
      );
    }
  }

  Future<void> deleteUser() {
    return sharedPreferences!.setString('user', '');
  }

  Future<void> setIsLogin(bool value) {
    return sharedPreferences!.setBool('isLogin', value);
  }

  bool getIsLogin() {
    return sharedPreferences!.getBool('isLogin') ?? false;
  }

  Future<void> deleteLogin() {
    return sharedPreferences!.setBool('isLogin', false);
  }

  Future<void> setIsFirst(bool value) {
    return sharedPreferences!.setBool('isFirst', value);
  }

  bool getIsFirst() {
    return sharedPreferences!.getBool('isFirst') ?? true;
  }

  Future<void> setId(String value) {
    return sharedPreferences!.setString('id', value);
  }

  String getId() {
    try {
      return sharedPreferences!.getString('id') ?? '';
    } catch (e) {
      return '';
    }
  }

  LoginResponse getUserData() {
    LoginResponse user = LoginResponse.fromJson(json.decode(getUser()));
    return user;
  }

  Future<void> setRememberedEmail(String email) {
    return sharedPreferences!.setString('remembered_email', email);
  }

  String getRememberedEmail() {
    return sharedPreferences!.getString('remembered_email') ?? '';
  }

  Future<void> clearRememberedEmail() {
    return sharedPreferences!.remove('remembered_email');
  }

  Future<bool> setIsCheckedIn(bool value) async {
    return await sharedPreferences!.setBool(isCheckedIn, value);
  }

  bool getIsCheckedIn() {
    return sharedPreferences!.getBool(isCheckedIn) ?? false;
  }

  Future<bool> clearIsCheckedIn() async {
    return await sharedPreferences!.remove(isCheckedIn);
  }
}
