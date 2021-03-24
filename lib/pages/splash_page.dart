import 'package:flutter/material.dart';
import 'dart:async';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  final Tween<double> _turnsTween = Tween<double>(begin: 1, end: 10);
  AnimationController _controller;

  void navegaTelaLogin() {
    Navigator.pushReplacementNamed(context, '/LoginPage');
  }

  // o método retorna Timer na verdade
  iniciarSplash() async {
    var _duration = Duration(seconds: 5);
    return Timer(_duration, navegaTelaLogin);
  }

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _controller.forward();
    iniciarSplash();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RotationTransition(
              turns: _turnsTween.animate(_controller),
              child: Image.asset('assets/images/splash.png')),
          Text(
            'CARREGANDO ...',
            style: TextStyle(fontSize: 30),
          ),
          // utilizaremos o Navigator para navegar para outro Widget
          RaisedButton(
              child: Text('Login'),
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, '/LoginPage'))
        ],
      ),
    );
  }
}
