class LoginResponse {
  LoginResponse.fromJson(dynamic json) {
    _refresh = json['refresh'];
    _access = json['access'];
    _email = json['email'];
    _username = json['username'];
    _isPremium = json['is_premium'];
    _days = json['days'];
  }
  String? _refresh;
  String? _access;
  String? _email;
  String? _username;
  int? _days;
  bool? _isPremium;

  String? get refresh => _refresh;
  String? get access => _access;
  String? get email => _email;
  String? get username => _username;
  int? get days => _days;
  bool? get isPremium => _isPremium;
}