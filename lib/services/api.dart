import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Api {
  Future<http.Response> get(String url) async {
    var response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print("GET: $url");
      print("Response: ${response.body}");
    }
    return response;
  }
}
