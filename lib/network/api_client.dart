import 'package:dio/dio.dart';
import 'package:my_parking/models/login_info.dart';
import 'package:my_parking/models/parking_info.dart';
import 'package:my_parking/models/user_info.dart';
import 'package:my_parking/utils/shared_preferences.dart';

class ApiClient {
  final Dio _dio = Dio();

  Future<dynamic> registerUser(Map<String, dynamic>? data) async {
    try {
      Response response =
          await _dio.post('https://e9fd-62-8-64-205.eu.ngrok.io/registration',
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
        data: userInfo.toJson(),
      );
      retrievedUser = UserInfo.fromJson(response.data);
    } on DioError catch (e) {
      print('Error creating user: $e');
    }
    return retrievedUser;
  }

  Future<LoginInfo?> login({required LoginInfo loginInfo}) async {
    LoginInfo? retrievedLogin;
    try {
      Response response = await _dio.post(
        '${APIConstants.baseurl}/login',
        data: loginInfo.toJson(),
      );

      retrievedLogin = LoginInfo.fromJson(response.data);
    } on DioError catch (e) {
      print('Error creating user: $e');
    }
    return retrievedLogin;
  }

  Future<dynamic> getUserProfileData(String accessToken) async {
    try {
      Response response = await _dio.get(
        'https://e9fd-62-8-64-205.eu.ngrok.io/profile',
      );
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  Future<dynamic> getParkingData(String accessToken) async {
    try {
      Response response = await _dio.get(
        'https://e9fd-62-8-64-205.eu.ngrok.io/parking',
        options: Options(headers: {
          'Authorization': accessToken,
        }),
      );
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<ParkingInfo?> getParking({required ParkingInfo parkingInfo}) async {
    ParkingInfo? retrievedUser;

    try {
      Response response = await _dio.post(
        'https://e9fd-62-8-64-205.eu.ngrok.io/parking',
        data: parkingInfo.toJson(),
      );
      retrievedUser = ParkingInfo.fromJson(response.data);
    } on DioError catch (e) {
      print('Error creating user: $e');
    }
    return retrievedUser;
  }

  Future<dynamic> updateUserProfile({
    required String accessToken,
    required Map<String, dynamic> data,
  }) async {
    try {
      Response response = await _dio.put(
        'https://api.loginradius.com/identity/v2/auth/account',
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

  Future<dynamic> logout(String accessToken) async {
    try {
      Response response = await _dio.get(
        'https://api.loginradius.com/identity/v2/auth/access_token/InValidate',
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
