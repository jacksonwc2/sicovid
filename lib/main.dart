import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sicovid/pages/splash_page.dart';
import 'package:sicovid/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:internationalization/internationalization.dart';

void main() async {
  // é para garantir que os componentes nativos tenham sido inicializados
  WidgetsFlutterBinding.ensureInitialized();
  // carrega as configurações de internacionalização
  await Internationalization.loadConfigurations();
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
      home: SplashPage(),
      supportedLocales: suportedLocales,
      localizationsDelegates: [
        Internationalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
    );
  }
}
