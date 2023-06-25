import 'dart:convert';

import 'package:arduino_security_system/model/ApiResponse.dart';
import 'package:arduino_security_system/model/User.dart';
import 'package:arduino_security_system/model/UserApiResponse.dart';
import 'package:http/http.dart' as http;

class UserController {

  static const String createUserUrl = "http://localhost:3001/api/user/create_user";
  static const String loginUrl = "http://localhost:3001/api/user/authenticate";
  static const String getAllUrl = "http://localhost:3001/api/user/";
  static const String updatePasswordUrl = "http://localhost:3001/api/user/update";

  static Future<String> createUser(String username, String password) async {
    final response = await http.post(
      Uri.parse(createUserUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "username": username,
        "password": password,
        "nif": "274069997",
      }),
    );
    if (response.statusCode == 200) {
      return "done";
    }
    return ApiResponse.fromJson(jsonDecode(response.body)).message;
  }

  static Future<String> login(String username, String password) async {
    final response = await http.post(
      Uri.parse(loginUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "username": username,
        "password": password
      }),
    );
    if (response.statusCode == 200) {
      User.fromJson(jsonDecode(response.body));
      return "done";
    }
    return ApiResponse.fromJson(jsonDecode(response.body)).message;
  }

  static Future<List<UserApiResponse>?> getAllUsers(String? token) async {
    final response = await http.get(
      Uri.parse(getAllUrl),
      headers: <String, String>{
        'authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> usersJson = jsonDecode(response.body);
      final List<UserApiResponse> users =
      usersJson.map((json) => UserApiResponse.fromJson(json)).toList();
      return users;
    }
    return null;
  }

  static Future<String> updateUserPassword(String? username, String password, String? token) async {
    final response = await http.post(
      Uri.parse(updatePasswordUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, String>{
        "username": username!,
        "password": password
      }),
    );
    if (response.statusCode == 200) {
      return "done";
    }
    return ApiResponse.fromJson(jsonDecode(response.body)).message;
  }


}
