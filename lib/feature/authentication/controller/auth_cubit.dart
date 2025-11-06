import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mostakbal/feature/authentication/data_source/auth_data_source.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);

  FirebaseAuth auth = FirebaseAuth.instance;
  AuthDataSource dataSource = AuthDataSource();

  /// todo create user Using Google
  Future<void> signInWithGoogle() async {
    emit(CreateUserUsingGoogleLoadingState());
    try {
      dataSource.signInWithGoogle();
      emit(CreateUserUsingGoogleSuccessState(auth.currentUser!.uid));
    } catch (e, s) {
      emit(CreateUserUsingGoogleErrorState());
      print(s);
    }
  }

  /// todo user Create
  Future<void> userRegister({
    required String email,
    required String username,
    required String phone,
    required String password,
    required String fullName,
    required String birthdate,
  }) async {
    emit(CreateUserLoadingState());
    try {
      dataSource
          .userRegister(
        email: email,
        username: username,
        phone: phone,
        password: password,
        fullName: fullName,
        birthdate: birthdate,
      )
          .then((value) {
        emit(CreateUserSuccessState(auth.currentUser!.uid));
      });
    } catch (e, s) {
      emit(CreateUserErrorState());
      print(s);
    }
  }

  /// todo login With Facebook
  Future<void> loginWithFacebook() async {
    emit(CreateUserUsingFacebookLoadingState());
    try {
      dataSource.signInWithGoogle();
      emit(CreateUserUsingFacebookSuccessState(auth.currentUser!.uid));
    } catch (e, s) {
      emit(CreateUserUsingFacebookErrorState());
      print(s);
    }
  }

  /// todo login With verify Phone Number
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
  }) async {
    emit(CreateUserUsingPhoneLoadingState());
    try {
      dataSource.verifyPhoneNumber(phoneNumber: phoneNumber);
      emit(CreateUserUsingPhoneSuccessState(auth.currentUser!.uid));
    } catch (e, s) {
      emit(CreateUserUsingPhoneErrorState());
      print(s);
    }
  }

  /// todo login With verify email
  Future<void> verifyEmail() async {
    emit(VerifyEmailLoadingState());
    try {
      dataSource.verifyEmail();
      emit(VerifyEmailSuccessState());
    } catch (e, s) {
      emit(VerifyEmailErrorState());
      print(s);
    }
  }

  /// todo confirm email
  Future<void> confirmEmail({
    required String code,
  }) async {
    emit(ConfirmEmailLoadingState());
    try {
      dataSource.confirmEmail(code: code);
      emit(ConfirmEmailSuccessState());
    } catch (e, s) {
      emit(ConfirmEmailErrorState());
      print(s);
    }
  }

  Future<void> loginWithEmail({
    required String email,
    required String password,
  }) async {
    emit(CreateUserUsingEmailLoadingState());
    try {
      dataSource.loginWithEmail(email: email, password: password);
      emit(CreateUserUsingEmailSuccessState(auth.currentUser!.uid));
    } catch (e, s) {
      emit(CreateUserUsingEmailErrorState());
      print(s);
    }
  }
}
