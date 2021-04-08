import 'package:flutter/material.dart';
import 'package:sicovid/helpers/database_helper.dart';
import 'package:sicovid/models/user.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = "";
  String _password = "";
  final frmLogin = new GlobalKey<FormState>();
  var db = DatabaseHelper();

  void _validateLogin() async {
    final form = frmLogin.currentState;

    if (form.validate()) {
      form.save();
      User u = await db.validateLogin(_email, _password);
      if (u != null) {
        Navigator.popAndPushNamed(context, '/HomePage');
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Erro no Login'),
                content: Text('E-mail e/ou senha inválidos!'),
              );
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // o campo de email
    final emailField = TextFormField(
      validator: (value) {
        return value.length < 10 ? "Email deve ter 10 caracteres" : null;
      },
      onSaved: (value) =>
          _email = value, // utilizo o oonsaved para capturar o valor
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'E-mail',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          )),
    );
    // o campo de senha
    final passwordField = TextFormField(
      validator: (value) {
        return value.length < 6 ? "Senha deve ter 6 caracteres" : null;
      },
      onSaved: (value) =>
          _password = value, // utilizo o oonsaved para capturar o valor
      obscureText: true,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Senha',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          )),
    );
    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
          child: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.greenAccent,
        child: Padding(
          padding: const EdgeInsets.all(36),
          child: Form(
              key: frmLogin,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 150,
                    child: Image.asset("assets/images/splash.png"),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  emailField,
                  SizedBox(
                    height: 20,
                  ),
                  passwordField,
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    color: Colors.blue,
                    elevation: 5,
                    onPressed: _validateLogin,
                    child: Text('Login'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FlatButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, "/RegisterPage"),
                      child: Text("Registre-se"))
                ],
              )),
        ),
      )),
    ));
  }
}
