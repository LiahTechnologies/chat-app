import 'package:equatable/equatable.dart';
import 'package:njadia/src/features/authentication/data/model/user_docs_response.dart';
import 'package:njadia/src/features/authentication/domain/entities/user-entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class NotLogin extends AuthState {}




class LoggedIn extends AuthState {
  final String token;

  const LoggedIn({required this.token});

  @override
  List<Object?> get props => [token];
}



class Signup extends AuthState {
  final UserEntity user;

  const Signup({required this.user});

  Signup copyWith({UserEntity? user}) {
    return Signup(user: user ?? this.user);
  }
}



class SignUpSuccessful extends AuthState {
  final LoginResponse signupRespons;

  const SignUpSuccessful({required this.signupRespons});

  @override
  List<Object?> get props => [signupRespons];
}




class OTPCodeGenerated extends AuthState {
  final bool isCodeGenerated;

  const OTPCodeGenerated({required this.isCodeGenerated});

  @override
  List<Object?> get props => [isCodeGenerated];
}



class OTPCodeVerified extends AuthState {
  final bool isCodeVerified;

  const OTPCodeVerified({required this.isCodeVerified});

  @override
  List<Object?> get props => [isCodeVerified];
}



class LoggedOut extends AuthState {
  final bool isLoggedOut;

  const LoggedOut({required this.isLoggedOut});

  @override
  List<Object?> get props => [isLoggedOut];
}




class AuthFailure extends AuthState {
  final String message;
  const AuthFailure({required this.message});

  @override
  List<Object?> get props => [message];
}



class OTPVerificonComplete extends AuthState {
  
  const OTPVerificonComplete();
}
