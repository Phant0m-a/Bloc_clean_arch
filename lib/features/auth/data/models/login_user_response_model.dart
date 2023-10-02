class LoginUserResponseModel {
  LoginUserResponseModel({
    required this.code,
    required this.message,
    required this.data,
  });
  late final int code;
  late final String message;
  late final LoginUserResponseBody data;

  LoginUserResponseModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = LoginUserResponseBody.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    // ignore: no_leading_underscores_for_local_identifiers
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['message'] = message;
    _data['data'] = data.toJson();
    return _data;
  }
}

class LoginUserResponseBody {
  LoginUserResponseBody({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
  });
  late final int id;
  late final String name;
  late final String email;
  late final String token;

  LoginUserResponseBody.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    email = json['Email'];
    token = json['Token'];
  }

  Map<String, dynamic> toJson() {
    // ignore: no_leading_underscores_for_local_identifiers
    final _data = <String, dynamic>{};
    _data['Id'] = id;
    _data['Name'] = name;
    _data['Email'] = email;
    _data['Token'] = token;
    return _data;
  }
}
