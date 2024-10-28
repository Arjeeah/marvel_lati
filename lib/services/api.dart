import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:marvel_lati/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  Future<http.Response> get(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    var response = await http
        .get(Uri.parse(url), headers: {"Authorization": "Bearer $token"});
    if (kDebugMode) {
      print("GET: $url");
      print("Response: ${response.body}");
    }
    if (response.statusCode == 401) {
      refreshToken().then((onValue) {
        if (onValue) {
          get(url);
        }
      });
    }
    return response;
  }

  Future<http.Response> post(String url, {Map? body = null}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("token");
    print("feom api ${prefs.getString("token")}");
    final response = await http.post(
        Uri.parse(
          url,
        ),
        body: json.encode(body),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
          "Accept": "application/json"
        });
    if (kDebugMode) {
      print("POST URL : $url");
      print("POST BODY : ${body}");
      print("POST STATUS CODE : ${response.statusCode}");
      print("POST RESPONSE : ${response.body}");
    }

    print("TOKEN DOWN");
    print(response.headers);
    if (response.statusCode == 401) {
      refreshToken().then((onValue) {
        if (onValue) {
          post(url, body: body);
        }
      });
    }
    return response;
  }

  Future<http.Response> put(String url, {UserModel? body = null}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    final response = await http.put(
        Uri.parse(
          url,
        ),
        body: json.encode(body),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
          "Accept": "application/json"
        });
    if (kDebugMode) {
      print("PUT URL : $url");
      print("PUT BODY : ${body}");
      print("PUT STATUS CODE : ${response.statusCode}");
      print("PUT RESPONSE : ${response.body}");
    }
    if (response.statusCode == 401) {
      refreshToken().then((onValue) {
        if (onValue) {
          put(url, body: body);
        }
      });
    }
    return response;
  }

  Future<http.Response> delete(String url) async {
    var response = await http.delete(Uri.parse(url));
    if (kDebugMode) {
      print("DELETE: $url");
      print("Response: ${response.body}");
    }
    return response;
  }

  Future<bool> refreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print("old token  $token");

    var response = await http.post(
      Uri.parse("https://lati.kudo.ly/api/refresh"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
    );

    if (response.statusCode == 200) {
      prefs.setString('token', jsonDecode(response.body)['access_token']);
      print("new token  ${prefs.getString('token')}");
      return true;
    } else {
      return false;
    }
  }

  Future <Response> upload(File file, String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers['Authorization'] = "Bearer $token";
    request.files.add(await http.MultipartFile.fromPath('img', file.path));
    http.StreamedResponse response = await request.send();
    return http.Response.fromStream(response);
  }
  

  

}
