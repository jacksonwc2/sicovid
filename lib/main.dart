import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sicovid/pages/splash_page.dart';
import 'package:sicovid/routes.dart';

void main() {
  // define a direção aceita para a tela
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(SICovid());
}

class SICovid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SICovid - Monitoramento de Sintomas',
        routes: routes,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashPage());
  }
}
