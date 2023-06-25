class UserApiResponse {
  String? _username;
  String? _password;
  String? _token;
  int? _userId;
  bool? _admin;

  UserApiResponse.fromJson(Map<String, dynamic> json) {
    _username = json["username"];
    _password = json["password"];
    _token = json["token"];
    _userId = json["userId"];
    _admin = json["admin"];
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
