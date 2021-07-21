import 'dart:convert';

LoginResponseModel loginResponseFromJson(String str){
  return LoginResponseModel.fromJson(json.decode(str));
}

class LoginResponseModel{
  late bool success;
  late int statusCode;
  late String code;
  late String message;
  late Data data;
  LoginResponseModel({
    required this.success,
    required this.statusCode,
    required this.code,
    required this.message,
    required this.data,
  });

  LoginResponseModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    statusCode = json['statusCode'];
    code = json['code'];
    message = json['message'];
    data = (json['data'].length > 0 ? new Data.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['statusCode'] = this.statusCode;
    data['code'] = this.code;
    data['message'] = this.message;
    if(this.data != null){ // ignore: unnecessary_null_comparison
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data{
  late String token;
  late int id;
  late String email;
  late String niceName;
  late String firstName;
  late String lastName;
  late String displayName;

  Data({
    required this.token,
    required this.id,
    required this.email,
    required this.niceName,
    required this.firstName,
    required this.lastName,
    required this.displayName,
  });

  Data.fromJson(Map<String, dynamic> json){
    token = json['token'];
    id = json['id'];
    email = json['email'];
    niceName = json['niceName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    displayName = json['displayName'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['id'] = this.id;
    data['email'] = this.email;
    data['niceName'] = this.niceName;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['displayName'] = this.displayName;
    return data;
  }
}