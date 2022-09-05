import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

class LoginResponse {
  LoginResponse({
    required this.code,
    required this.message,
    required this.data,
  });
  late final int code;
  late final String message;
  late final Data? data;

  LoginResponse.fromJson(Map<String, dynamic> json){
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['message'] = message;
    _data['data'] = data!.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.Id,
    required this.Name,
    required this.Email,
    required this.Token,
  });
  late final int Id;
  late final String Name;
  late final String Email;
  late final String Token;

  Data.fromJson(Map<String, dynamic> json){
    Id = json['Id'];
    Name = json['Name'];
    Email = json['Email'];
    Token = json['Token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Id'] = Id;
    _data['Name'] = Name;
    _data['Email'] = Email;
    _data['Token'] = Token;
    return _data;
  }
}