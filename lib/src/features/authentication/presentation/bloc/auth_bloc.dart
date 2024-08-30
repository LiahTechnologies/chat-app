import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:njadia/src/features/authentication/domain/usecases/user-usecase.dart';
import 'package:njadia/src/features/authentication/presentation/bloc/auth_event.dart';
import 'package:njadia/src/features/authentication/presentation/bloc/auth_state.dart';

import 'package:bloc/bloc.dart';

import '../../../../utils/bloc_image_picker.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserUsecase userUsecase;

  ImagePickerUtils imagePickerUtils = ImagePickerUtils();

  AuthBloc({required this.userUsecase}) : super(NotLogin()) {
    on<OnLogin>((event, emit) async {
      final response =
          await userUsecase.login(email: event.email, password: event.password);

      print(" LOGGED IN RESPONSE DATA IS $response");
      response.fold((failure) {
        print("STATE MANAGEMENT ERROR");
        emit(AuthFailure(message: failure.message));
      }, (data) {
        print("THIS IS THE LOGIN RESPONSE DATA  Token${data.token}");
        emit(LoggedIn(token: data.token));
      });
    });

    on<OnSignUp>((event, emit) async {
      final response = await userUsecase.create(user:event.userEntity,selfie: event.selfie!,docs: event.docs!);

      response.fold((failure) => emit(AuthFailure(message: failure.message)),
          (data) => emit(SignUpSuccessful(signupRespons: data)));
    });

    on<OnOTPGeneration>((event, emit) async {
      final response = await userUsecase.generateOTP(number: event.number);

      response.fold((failure) => emit(AuthFailure(message: failure.message)),
          (data) => emit(OTPCodeGenerated(isCodeGenerated: data)));
    });

    on<OnOTPVerification>((event, emit) async {
      final response = await userUsecase.verifyOTP(
          number: event.number, OTPCode: event.OTPCode);

      response.fold((failure) => emit(AuthFailure(message: failure.message)),
          (data) {
        print("VERIFICATION COMPLETE");
       
        emit(OTPCodeVerified(isCodeVerified: data));
        // emit(const OTPVerificonComplete());
      });
    });

    on<OnLoggedOut>((event, emit) {});
  }
}
