class User {
  static User? _instance;
  String? _username;
  String? _password;
  String? _token;
  int? _userId;
  bool? _admin;

  User._();

  factory User.fromJson(Map<String, dynamic> json) {
    _instance ??= User._();
    _instance!.username = json["username"];
    _instance!.password = json["password"];
    _instance!.token = json["token"];
    _instance!.userId = json["userId"];
    _instance!.admin = json["admin"];
    return _instance!;
  }

  static User get instance {
    _instance ??= User._();
    return _instance!;
  }

  String? get token => _token;

  String? get password => _password;

  String? get username => _username;

  int? get userId => _userId;

  bool? get admin => _admin;

  set token(String? value) {
    _token = value;
  }

  set password(String? value) {
    _password = value;
  }

  set username(String? value) {
    _username = value;
  }

  set admin(bool? value) {
    _admin = value;
  }

  set userId(int? value) {
    _userId = value;
  }

  @override
  String toString() {
    return 'User(username: $_username, token: $_token, admin: $_admin)';
  }
}
