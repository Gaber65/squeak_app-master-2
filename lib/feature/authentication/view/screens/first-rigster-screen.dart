import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mostakbal/feature/authentication/controller/auth_cubit.dart';
import 'package:mostakbal/feature/authentication/data_source/auth_data_source.dart';
import 'package:mostakbal/feature/authentication/view/component/first-rigister-body.dart';
import 'package:mostakbal/feature/authentication/view/screens/register-screen1.dart';
import 'package:mostakbal/feature/authentication/view/screens/second-sign%20in-screen.dart';

class FirstRegisterScreen extends StatelessWidget {
  const FirstRegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, index) {},
        builder: (context, index) {
          var cubit = AuthCubit.get(context);
          return Scaffold(
              backgroundColor: Colors.white,
              body: Padding(
                padding: EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50, bottom: 50),
                        child: Image.asset('assets/images/image.png'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color(0xFFE9F4FF),
                            borderRadius: BorderRadius.circular(20)),
                        child: MaterialButton(
                          onPressed: () async{
                            UserCredential? userCredential = await AuthDataSource().signInWithGoogle();
                            if (userCredential != null) {
                              print("Google sign-in successful: ${userCredential.user!.displayName}");
                              // Do further actions after successful sign-in
                            }                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Logo(Logos.google, size: 20),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'اكمل باستخدام جوجل',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color(0xFF1977F3),
                            borderRadius: BorderRadius.circular(20)),
                        child: MaterialButton(
                          onPressed: () async{
                           await cubit.dataSource.signInWithFacebook();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Logo(Logos.facebook_logo, size: 20),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'اكمل باستخدام فيسبوك',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(20)),
                        child: MaterialButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Logo(
                                    Logos.apple,
                                    size: 25,
                                  )),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'اكمل باستخدام ابل',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(children: <Widget>[
                        Expanded(
                          child: Container(
                              margin: const EdgeInsets.only(
                                  left: 10.0, right: 15.0),
                              child: const Divider(
                                color: Colors.black,
                                height: 50,
                              )),
                        ),
                        const Text("او"),
                        Expanded(
                          child: Container(
                              margin: const EdgeInsets.only(
                                  left: 15.0, right: 10.0),
                              child: const Divider(
                                color: Colors.black,
                                height: 50,
                              )),
                        ),
                      ]),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color(0xFF1977F3),
                            borderRadius: BorderRadius.circular(20)),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return SecondSigninScreen();
                            }));
                          },
                          child: Text(
                            'الدخول باستخدام كلمه المرور',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'لاتمتلك حساب ؟',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Colors.grey),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return RegisterScreen();
                                }));
                              },
                              child: Text(
                                'انشاء حساب',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Colors.blue),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
