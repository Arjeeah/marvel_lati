import 'dart:convert';
import 'package:marvel_lati/models/movie_model.dart';
import 'package:marvel_lati/providers/baise_provider.dart';

class MovieProvider extends BaiseProvider {
  List<MovieModel> movies = [];
  getmoive() async {
    setLoading(true);
    movies.clear();
    var response = await api.get("https://mcuapi.herokuapp.com/api/v1/movies");
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      for (var item in data) {
        movies.add(MovieModel.fromJson(item));
      }
      setLoading(false);
    }
  }
}
