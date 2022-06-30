import 'dart:convert';

LoginResponseModel loginResponseJson(String str) => LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  LoginResponseModel.dart({
    required this.message,
    required this.data,
  });
  late final String message;
  late final Data data;

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.username,
    required this.email,
    required this.data,
    required this.id,
    required this.token,
  });
  late final String username;
  late final String email;
  late final String data;
  late final String id;
  late final String token;

  Data.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    data = json['data'];
    id = json['id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['username'] = username;
    _data['email'] = email;
    _data['data'] = data;
    _data['id'] = id;
    _data['token'] = token;
    return _data;
  }
}
