import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:marvel_lati/models/movie_model.dart';
import 'package:marvel_lati/services/api.dart';

class MovieProvider with ChangeNotifier {
  List<MovieModel> movies = [];
  final Api _api = Api();
  bool loading = false;

  getmoive() async {
    loading = true;
    movies.clear();
    var response = await _api.get("https://mcuapi.herokuapp.com/api/v1/movies");
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      for (var item in data) {
        movies.add(MovieModel.fromJson(item));
      }
      loading = false;
      notifyListeners();
    }
  }
}
