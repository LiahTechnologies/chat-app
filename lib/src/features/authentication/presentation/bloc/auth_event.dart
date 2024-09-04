import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:njadia/src/features/authentication/domain/entities/user-entity.dart';
import 'package:njadia/src/features/authentication/presentation/bloc/auth_state.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class OnLogin extends AuthEvent {
  final String email;
  final String password;

  const OnLogin({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class OnSignUp extends AuthEvent {
  final UserEntity userEntity;

  final File? selfie;
  final File? docs;
  final File? profilePic;
  const OnSignUp({required this.userEntity, required this.selfie, required this.docs, required this.profilePic});

  @override
  List<Object?> get props => [userEntity];
}

class OnOTPGeneration extends AuthEvent {
  final String number;
  const OnOTPGeneration({required this.number});
}

class OnOTPVerification extends AuthEvent {
  final String number;
  final String OTPCode;
  const OnOTPVerification({required this.number,required this.OTPCode});
}

class OnLoggedOut extends AuthEvent {
  final bool isLoggedOut;

  const OnLoggedOut({required this.isLoggedOut});

  @override
  List<Object?> get props => [isLoggedOut];
}

// Sign up states

class OnOTPCodeChange extends AuthEvent {
  final String OTPCode;
  const OnOTPCodeChange({required this.OTPCode});

  @override
  List<Object?> get props => [OTPCode];
}

class OnPickFile extends AuthEvent {}
