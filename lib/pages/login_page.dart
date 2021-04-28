import 'package:flutter/material.dart';
import 'package:sicovid/helpers/database_helper.dart';
import 'package:sicovid/models/user.dart';
import 'package:internationalization/internationalization.dart';
import 'package:sicovid/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextStyle formFieldStyle =
      TextStyle(fontSize: 15, fontWeight: FontWeight.bold);
  String _email = "";
  String _password = "";
  final frmLogin = new GlobalKey<FormState>();
  var db = DatabaseHelper(); // importa o database helper(singleton)

  // validar login
  void _validateLogin() async {
    var form = frmLogin.currentState; // estado atual/corrente do formulário
    if (form.validate()) {
      form.save(); // força salvar os dados

      User u = await db.validateLogin(_email, _password);

      if (u != null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => HomePage(user: u)));
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
      style: formFieldStyle,
      validator: (value) {
        return value.length < 10
            ? "E-mail deve ter no mínimo 10 caracteres!"
            : null;
      },
      onSaved: (value) =>
          _email = value, // utilizo o onsaved para capturar o valor
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'E-mail',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
    );
    final passwordField = TextFormField(
      style: formFieldStyle,
      validator: (value) {
        return value.length < 6
            ? Strings.of(context).valueOf("msg_password")
            : null;
      },
      onSaved: (value) =>
          _password = value, // utilizo o onsaved para capturar o valor
      obscureText: true, // ocultar o que é digitado
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Senha',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
    );

    return Scaffold(
        body: SingleChildScrollView(
      // rolagem
      child: Center(
        child: Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.greenAccent,
            child: Padding(
                padding: const EdgeInsets.all(36), // defini a distância padrão
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
                      ElevatedButton(
                          onPressed: _validateLogin,
                          child: Text(Strings.of(context).valueOf("wg_login"))),
                      SizedBox(
                        height: 10,
                      ),
                      FlatButton(
                        child: Text('Registrar-se'),
                        onPressed: () =>
                            Navigator.pushNamed(context, '/RegisterPage'),
                      )
                    ],
                  ),
                ))),
      ),
    ));
  }
}
