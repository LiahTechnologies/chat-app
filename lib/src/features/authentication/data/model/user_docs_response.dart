import 'dart:io';

import '../../domain/entities/user-entity.dart';

class UserModel extends UserEntity {
  final File selfie;
  final File docs;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String dob;
  final String tel;

  UserModel({
    required this.selfie,
    required this.docs,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.dob,
    required this.tel,
  }) : super(
            firstName: '',
            lastName: '',
            email: '',
            password: '',
            dob: '',
            tel: '',
            selfie: selfie,
            docs: docs);

  factory UserModel.fromjson(Map<String, dynamic> json) => UserModel(
      docs: json["docs"],
      selfie: json["selfie"],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      password: json['password'],
      dob: json['dob'],
      tel: json['tel']);

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "dob": dob,
        "tel": tel,
        "selfie": selfie,
        "docs": docs
      };
}

class LoginResponse extends Login {
  final String token;
  final String uid;
  final String userEmail;
  final String lastName;
  final String firstName;
  final String tel;
  LoginResponse(
      {required this.token,
      required this.uid,
      required this.userEmail,
      required this.lastName,
      required this.tel,
      required this.firstName})
      : super(token: token);

  factory LoginResponse.fromjson(Map<String, dynamic> json) => LoginResponse(
      token: json["token"],
      uid: json['userId'],
      userEmail: json['email'],
      tel:json['tel'],
      lastName: json['lastName'],
      firstName: json['firstName']);
      
}
