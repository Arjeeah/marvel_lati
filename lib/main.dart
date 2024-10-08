import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:marvel_lati/pages/splash_page.dart';
import 'package:marvel_lati/providers/auth_provider.dart';
import 'package:marvel_lati/providers/baise_provider.dart';
import 'package:marvel_lati/providers/movie_provider.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BaiseProvider()),
        ChangeNotifierProvider(create: (_) => MovieProvider()..getmoive()),
        ChangeNotifierProvider(
            create: (_) => AuthentProvider()..initilazAuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: false,
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              iconTheme: IconThemeData(color: Colors.black)),
        ),
        home: const SplashPage(),
      ),
    );
  }
}
