import 'dart:async';

import 'package:flutter/material.dart';
import 'package:marvel_lati/helper/const.dart';
import 'package:marvel_lati/pages/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
        Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: red,
        body: Center(
          child: Image.asset(
            "assets/InvertedLogo.png",
            width: size.width * 0.60,
          ),
        ),
      ),
    );
  }
}
