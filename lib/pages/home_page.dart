import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences_settings/shared_preferences_settings.dart';
import 'package:sicovid/models/user.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  final User user;

  HomePage({Key key, this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;
  var _bytes = null;
  int _backgroundColor;

  void loadSetting() async {
    var color = int.parse(
        await Settings().getString("pref_background_color", "0xff2196f3"));
    setState(() {
      _backgroundColor = color;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadSetting();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.user.photo != null) _bytes = base64.decode(widget.user.photo);

    return Scaffold(
      appBar: AppBar(
        title: Text('SICovid'),
        centerTitle: true,
        backgroundColor:
            _backgroundColor != null ? Color(_backgroundColor) : Colors.amber,
      ),
      drawer: Drawer(
          child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(widget.user.name),
            accountEmail: Text(widget.user.email),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: _bytes != null ? MemoryImage(_bytes) : null,
            ),
          ),
          ListTile(
            title: Text('Preferências'),
            leading: Icon(Icons.settings),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.of(context).pushNamed('/SettingPage'),
          ),
          ListTile(
              title: Text('Sair'),
              leading: Icon(Icons.close),
              onTap: () => SystemNavigator.pop()),
        ],
      )),
      body: Container(
        child: Text('Home Page - $_index'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.lime,
        onTap: (int index) => setState(() {
          _index = index;
        }),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.accessibility), label: 'Sintomas'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Sobre'),
        ],
      ),
    );
  }
}
