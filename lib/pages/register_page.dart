import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sicovid/helpers/database_helper.dart';
import 'package:sicovid/models/user.dart';
import 'dart:io';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var db = DatabaseHelper();
  String _name = "";
  String _email = "";
  String _phone = "";
  String _password = "";
  PickedFile _photo;
  final frmRegister = new GlobalKey<FormState>();

  void _register() async {
    final form = frmRegister.currentState;

    if (form.validate()) {
      form.save();

      var bytes = null;
      var photo = null;
      if (_photo != null) {
        bytes = await _photo.readAsBytes();
        photo = base64.encode(bytes);
      }

      User user = User(null, _name, _email, _phone, _password, photo);
      user.id = await db.saveUser(user);

      if (user.id != null && user.id > 0) {
        // fechar a janela de registro
        Navigator.pop(context, true);
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                  title: Text('Erro de Registro!'),
                  content: Text('Erro ao tentar registrar o usuário!'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))));
            });
      }
    }
  }

  void _pickImage() async {
    final imageSource = await showDialog<ImageSource>(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Origem da Foto'),
              actions: [
                MaterialButton(
                    child: Text('Câmera'),
                    onPressed: () =>
                        Navigator.pop(context, ImageSource.camera)),
                MaterialButton(
                    child: Text('Galeria'),
                    onPressed: () =>
                        Navigator.pop(context, ImageSource.gallery))
              ],
            ));

    if (imageSource != null) {
      final image = await ImagePicker()
          .getImage(source: imageSource, maxHeight: 200, maxWidth: 200);
      if (image != null) {
        setState(() {
          _photo = image;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
            child: Form(
                key: frmRegister,
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    color: Colors.white,
                    child: Card(
                        color: Colors.greenAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 10,
                        child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Align(
                                    alignment: Alignment.center,
                                    child: Text('Registrar Paciente',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600))),
                                IconButton(
                                  icon: Icon(
                                    Icons.photo,
                                    color: Colors.white,
                                  ),
                                  iconSize: 60,
                                  padding: EdgeInsets.only(
                                      left: 38, right: 38, top: 15, bottom: 15),
                                  onPressed: _pickImage,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                _photo == null
                                    ? Text('Sem Foto!')
                                    : Image.file(
                                        File(_photo.path),
                                        height: 25,
                                        width: 25,
                                      ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                    decoration: InputDecoration(
                                        labelText: "Nome", hintText: "Nome"),
                                    onSaved: (value) => _name = value),
                                SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                    decoration: InputDecoration(
                                        labelText: "E-mail",
                                        hintText: "E-mail"),
                                    onSaved: (value) => _email = value),
                                SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                    decoration: InputDecoration(
                                        labelText: "Telefone",
                                        hintText: "Telefone"),
                                    onSaved: (value) => _phone = value),
                                SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        labelText: "Senha", hintText: "Senha"),
                                    onSaved: (value) => _password = value),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(child: Container()),
                                    FlatButton(
                                      child: Text('Registrar'),
                                      color: Colors.blue,
                                      textColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      onPressed: _register,
                                    )
                                  ],
                                )
                              ],
                            )))))));
  }
}
