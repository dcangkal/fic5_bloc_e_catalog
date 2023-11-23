// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// {
// 	"name": "Nicolas",
// 	"email": "nico@gmail.com",
// 	"password": "1234",
//     "avatar": "https://api.lorem.space/image/face?w=640&h=480"
// }

class RegisterRequestModel {
  final String name;
  final String email;
  final String password;
  final String avatar;

  RegisterRequestModel({
    required this.name,
    required this.email,
    required this.password,
    this.avatar ='https://api.lorem.space/image/face?w=640&h=480',
  });

  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
      'avatar': avatar,
    };
  }

  factory RegisterRequestModel.fromMap(Map<String, dynamic> map) {
    return RegisterRequestModel(
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      avatar: map['avatar'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterRequestModel.fromJson(String source) => RegisterRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);
}