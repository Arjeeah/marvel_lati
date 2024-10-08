import 'dart:convert';

import 'package:marvel_lati/providers/baise_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthentProvider extends BaiseProvider {
  bool auth = false;
  initilazAuthProvider() async {
    setLoading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      auth = true;
    }
    setLoading(false);
  }

  Future<List> login(Map body) async {
    setLoading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await api.post("https://lati.kudo.ly/api/login", body: body);
    if (response.statusCode == 200) {
      prefs.setString('token', jsonDecode(response.body)['access_token']);
      auth = true;
      setLoading(false);
      setFailed(false);
      return [true, jsonDecode(response.body)['access_token']];
    } else {
      setFailed(true);
      setLoading(false);
      return [false, jsonDecode(response.body)];
    }
  }

  Future<List> register(Map body) async {
    setLoading(true);
    var response =
        await api.post("https://lati.kudo.ly/api/register", body: body);
    if (response.statusCode == 200) {
      setLoading(false);
      setFailed(false);
      return [true, jsonDecode(response.body)];
    } else {
      setFailed(true);
      setLoading(false);
      return [false, jsonDecode(response.body)];
    }
  }

  Future<bool> logout() async {
    setLoading(true);
    final response = await api.post("https://lati.kudo.ly/api/logout");
    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.clear();

      auth = false;
      setLoading(false);
      return true;
    } else {
      setFailed(true);
      setLoading(false);
      return false;
    }
  }
}
