import 'dart:async';

import 'package:flutter/material.dart';
import 'package:marvel_lati/services/api.dart';

class BaiseProvider with ChangeNotifier {
  final Api api = Api();
  bool loading = false;
  bool isFailed = false;

  void setLoading(bool value) {
    Timer(Duration(milliseconds: 50), () {
      loading = value;
      notifyListeners();
    });
  }

  setFailed(bool status) {
    Timer(Duration(milliseconds: 50), () {
      isFailed = status;
      notifyListeners();
    });
  }
}
