class LoginUserRequestModel {
  LoginUserRequestModel({
    required this.email,
    required this.password,
  });
  late final String email;
  late final String password;

  LoginUserRequestModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    // ignore: no_leading_underscores_for_local_identifiers
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['password'] = password;
    return _data;
  }
}
