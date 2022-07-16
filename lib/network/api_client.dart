import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:my_parking/models/login_info.dart';
import 'package:my_parking/models/user_info.dart';
import 'package:my_parking/utils/shared_preferences.dart';
import 'package:my_parking/utils/constants.dart';

class ApiClient {
  final Dio _dio = Dio();

  Future<dynamic> registerUser(Map<String, dynamic>? data) async {
    try {
      Response response =
          await _dio.post('${APIConstants.baseurl}/registration',
              data: data,
              options: Options(headers: {
                'Content-Type': 'application/json',
              }));
      print(data);
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  Future<UserInfo?> createUser({required UserInfo userInfo}) async {
    UserInfo? retrievedUser;

    try {
      Response response = await _dio.post(
        '${APIConstants.baseurl}/registration',
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
        data: userInfo.toJson(),
      );
      retrievedUser = UserInfo.fromJson(response.data);
    } on DioError catch (e) {
      debugPrint('Error creating user: $e');
    }
    return retrievedUser;
  }

  Future<LoginInfo?> login({required LoginInfo loginInfo}) async {
    LoginInfo? retrievedLogin;
    try {
      Response response = await _dio.post(
        '${APIConstants.baseurl}/login',
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
        data: loginInfo.toJson(),
      );

      retrievedLogin = LoginInfo.fromJson(response.data);
    } on DioError catch (e) {
      debugPrint('Error creating user: $e');
    }
    return retrievedLogin;
  }

  Future<dynamic> updateUserProfile({
    required String accessToken,
    required Map<String, dynamic> data,
  }) async {
    try {
      Response response = await _dio.put(
        '${APIConstants.baseurl}/account',
        data: data,
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  Future<Response> getParkingData(String accessToken) async {
    Response responseData;
    try {
      responseData = await _dio.get(
        '${APIConstants.baseurl}/parking',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': accessToken,
        }),
      );
    } on DioError catch (e) {
      debugPrint('Error getting parking list: $e');
      throw Exception(e.message);
    }
    return responseData;
  }

  Future<Response> getVehicleData(String accessToken) async {
    Response responseData;
    try {
      responseData = await _dio.get(
        '${APIConstants.baseurl}/vehicles',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': accessToken,
        }),
      );
    } on DioError catch (e) {
      debugPrint('Error getting vehicle list: $e');
      throw Exception(e.message);
    }
    return responseData;
  }

  Future<dynamic> logout(String accessToken) async {
    try {
      Response response = await _dio.get(
        '${APIConstants.baseurl}/logout',
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }
}
