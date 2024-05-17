import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ModakApi {
  static const String baseUrl = 'https://api.themodak.com';
  static const Map<String, String> headers = {"Content-Type": "application/json"};

  static Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final response = await http.post(
      url,
      headers: headers,
      body: json.encode(body),
    );
    return response;
  }

  static Future<bool> postEmail(Map<String, String> jsonToPost) async {
    final response = await post('/auth/regist-email', jsonToPost);
    if (response.statusCode == 200) {
      print('Response data: ${response.body}');
      return true;
    } else {
      print('Error: ${response.statusCode}');
      return false;
    }
  }

  static Future<bool> postLogin(Map<String, String> jsonToPost) async {
    final response = await post('/auth/login', jsonToPost);
    if (response.statusCode == 200) {
      print('Response data: ${response.body}');
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('loginToken', response.body);
      return true;
    } else {
      print('Error: ${response.statusCode}');
      return false;
    }
  }
}