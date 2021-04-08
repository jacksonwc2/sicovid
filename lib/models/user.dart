class User {
  int _id;
  String _name;
  String _email;
  String _phone;
  String _password;
  String _photo;

  //constructor
  User(this._id, this._name, this._email, this._phone, this._password,
      this._photo);

  //getters and setters
  int get id => _id;
  String get name => _name;
  String get email => _email;
  String get phone => _phone;
  String get password => _password;
  String get photo => _photo;

  set id(int id) => _id = id;

  //toMap
  Map<String, dynamic> toMap() {
    return {
      "id": _id,
      "name": _name,
      "email": _email,
      "phone": _phone,
      "password": _password,
      "photo": _photo
    };
  }
}
