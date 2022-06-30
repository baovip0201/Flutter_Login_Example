import 'dart:convert';

RegisterResponseModel registerResponseModel(String str) => RegisterResponseModel.fromJson(json.decode(str));

class RegisterResponseModel {
  RegisterResponseModel({
    required this.message,
    required this.data,
  });
  late final String message;
  late final Data? data;

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['data'] = data!.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.username,
    required this.email,
    required this.data,
    required this.id,
  });
  late final String username;
  late final String email;
  late final String data;
  late final String id;

  Data.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    data = json['data'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['username'] = username;
    _data['email'] = email;
    _data['data'] = data;
    _data['id'] = id;
    return _data;
  }
}
