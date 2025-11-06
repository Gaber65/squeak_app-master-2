import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mostakbal/core/const/const.dart';
import 'package:mostakbal/feature/authentication/controller/auth_cubit.dart';
import 'package:mostakbal/feature/authentication/view/screens/register-screen1.dart';
import 'package:mostakbal/feature/authentication/view/screens/set-password-screen.dart';

import '../../../../core/const/components/elevated_button.dart';
import '../../../../core/local/cache_helper.dart';
import '../../../../main.dart';
import '../../../home_page/home_feeds/layout_screen.dart';

class SecondSigninScreen extends StatelessWidget {
  SecondSigninScreen({Key? key}) : super(key: key);
  var passwordController = TextEditingController();
  var emailController = TextEditingController();

  get selectedOption => null;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is CreateUserUsingEmailSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uid);
            uId = state.uid;
            print(uId);
            print(state.uid);
            RoutePage().navigateAndRemove(
              context,
              HomeLayoutScreen(),
            );
          }
        },
        builder: (context, state) {
          var cubit = AuthCubit.get(context);
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'تسجيل الدخول',
                      style: GoogleFonts.tajawal(
                          fontWeight: FontWeight.bold, fontSize: 28),
                    ),
                  ),
                  Center(
                    child: Text(
                      'الي حسابك',
                      style: GoogleFonts.tajawal(
                          fontWeight: FontWeight.bold, fontSize: 28),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextFormWidget(
                    icon: false,
                    emailController: emailController,
                    hintText: 'البريد الاكتروني',
                    prefixIcon: const Icon(
                      IconlyLight.message,
                    ),
                    validator: 'من فضلك ادخل البريد الاكتروني',
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormWidget(
                    icon: true,
                    emailController: passwordController,
                    hintText: 'كلمه المرور',
                    prefixIcon: const Icon(
                      IconlyLight.lock,
                    ),
                    validator: 'من فضلك ادخل الباسورد',
                    obscureText: true,
                    suffixIcon: const Icon(
                      IconlyLight.show,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    title: Text(
                      'تذكرني',
                      style: FontStyle().textStyle(fontSize: 14),
                    ),
                    leading: Radio(
                      value: 1,
                      groupValue: selectedOption,
                      onChanged: (value) {
                        print("Button value: $value");
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  (state! is CreateUserUsingEmailLoadingState)
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : MyElevatedButton(
                          onPressed: () {
                            if (emailController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('من فضلك ادخل داتا صحيحة'),
                                ),
                              );
                            }
                            cubit.loginWithEmail(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                            print('sdsdsd');
                          },
                          text: 'تـاكيد',
                        ),
                  TextButton(
                      onPressed: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) {
                        //   return SetPasswordScreen();
                        // }));
                      },
                      child: Text(
                        'هل نسيت كلمه المرور؟',
                        style: FontStyle().textStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          fontColor: ColorStyle().primaryColor,
                        ),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(children: <Widget>[
                    Expanded(
                      child: Container(
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 15.0),
                          child: const Divider(
                            color: Colors.grey,
                            height: 50,
                          )),
                    ),
                    const Text(
                      "او اكمل باستخدام",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Expanded(
                      child: Container(
                          margin:
                              const EdgeInsets.only(left: 15.0, right: 10.0),
                          child: const Divider(
                            color: Colors.grey,
                            height: 50,
                          )),
                    ),
                  ]),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {},
                          child: Logo(Logos.facebook_logo, size: 40)),
                      const SizedBox(
                        width: 30,
                      ),
                      InkWell(
                          onTap: () {},
                          child: Logo(
                            Logos.google,
                            size: 40,
                          )),
                      const SizedBox(
                        width: 30,
                      ),
                      InkWell(onTap: () {}, child: Logo(Logos.apple, size: 40)),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
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
                        child: const Text(
                          'انشاء حساب',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.blue),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
