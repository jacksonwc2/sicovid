import 'package:sicovid/pages/home_page.dart';
import 'package:sicovid/pages/login_page.dart';
import 'package:sicovid/pages/splash_page.dart';
import 'package:flutter/material.dart';

// mapa das rotas
final routes = {
  '/SplashPage': (BuildContext context) => SplashPage(),
  '/LoginPage': (BuildContext context) => LoginPage(),
  '/HomePage': (BuildContext context) => HomePage()
};
