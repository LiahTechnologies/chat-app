import 'dart:io';

import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String dob;
  final String tel;
  final File selfie;
  final File docs;

  UserEntity(
      {
     required this.firstName,
     required this.lastName,
     required this.email,
     required this.password,
     required this.dob,
     required this.tel,
     required this.selfie,
     required this.docs});
     
       @override
       // TODO: implement props
       List<Object?> get props => [
        firstName,
        lastName,
        email,
        password,
        dob,
        tel,
        selfie,
        docs
       ];
}
