import 'package:flutter/material.dart';
import 'package:sicovid/models/user.dart';

class HomePage extends StatefulWidget {
  final User user;
  HomePage({Key key, this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SICovid'), centerTitle: true,),
      //drawer: ,
      body: Container(child: Text('Home Page'),),
      bottomNavigationBar: BottomNavigationBar(backgroundColor: Colors.pink,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.healing), label: 'Sintomas'),
        BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Sobre')
      ],),
    );
  }
}