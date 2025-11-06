import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../core/models/auth_model/login_model.dart';

class AuthDataSource {
  FirebaseAuth auth = FirebaseAuth.instance;

  /// todo user login With Email
  Future<void> loginWithEmail({
    required String email,
    required String password,
  }) async {
    auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// todo user Register
  Future<void> userRegister({
    required String email,
    required String username,
    required String phone,
    required String password,
    required String fullName,
    required String birthdate,
  }) async {
    auth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then(
      (value) {
        userCreate(
          email: email,
          uid: value.user!.uid,
          username: username,
          phone: phone,
          password: password,
          birthdate: birthdate,
          fullName: fullName,
        );
      },
    );
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  /// todo user Create
  Future<void> userCreate({
    required String email,
    required String uid,
    required String username,
    required String phone,
    required String password,
    required String fullName,
    required String birthdate,
  }) async {
    UserDataModel model = UserDataModel(
      fullName: fullName,
      birthdate: birthdate,
      email: email,
      phone: phone,
      uId: uid,
      userName: username,
      image: 'https://img.freepik.com/free-photo/blue-user-icon-symbol-website-admin-social-login-element-concept-white-background-3d-rendering_56104-1217.jpg?size=626&ext=jpg&uid=R78903714&ga=GA1.2.798062041.1678310296&semt=sph',
    );

    await firestore.collection('users').doc(uid).set(model.toMap());
  }

  /// todo login With Facebook
  Future<UserCredential?> signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if(result.status == LoginStatus.success){
      // Create a credential from the access token
      final OAuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.token);
      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
    return null;
  }
  /// todo login With Google

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  /// todo login With verify Phone Number
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
  }) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Automatically sign in the user if verification is done automatically.
        // You might not need to implement this callback if Firebase can automatically handle it.
        UserCredential userCredential =
            await auth.signInWithCredential(credential);
        print(
            "Automatic verification completed: ${userCredential.user!.displayName}");
      },
      verificationFailed: (FirebaseAuthException e) {
        print("Phone number verification failed: $e");
      },
      codeSent: (String verificationId, int? resendToken) {
        // You'll need to store the verificationId and resendToken for later use
        // when the user enters the SMS code.
        print("SMS code has been sent to the provided phone number.");
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-retrieval timeout for the SMS code.
        // You might want to implement UI to manually enter the SMS code.
        print("Auto-retrieval timeout for SMS code: $verificationId");
      },
    );
  }

  /// todo login With verify email
  Future<void> verifyEmail() async {
    await auth.currentUser!.sendEmailVerification();
  }

  /// todo confirm email
  Future<void> confirmEmail({
    required String code,
  }) async {
    await auth.checkActionCode(code);
    await auth.applyActionCode(code);
  }
}
