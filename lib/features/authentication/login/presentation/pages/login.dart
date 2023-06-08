import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:squeak/components/styles.dart';
import 'package:squeak/core/resources/color_manager.dart';
import 'package:squeak/core/resources/strings_manager.dart';
import 'package:squeak/core/resources/values_manager.dart';
import 'package:squeak/core/service/service_locator.dart';
import 'package:squeak/core/widgets/elevated_button.dart';
import 'package:squeak/core/widgets/my_form_field.dart';
import 'package:squeak/core/widgets/text_btn.dart';
import 'package:squeak/core/widgets/toast_state.dart';
import 'package:squeak/features/layout/layout.dart';

import '../../../register/register_as_a_user/presentation/pages/register.dart';
import '../controller/cubit/login_cubit.dart';
import '../controller/cubit/login_state.dart';
import 'forgot_password.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<LoginCubit>(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is GetLoginUserSuccessState) {
            if (state.login.status!) {
              showToast(
                text: state.login.messages!,
                state: ToastState.success,
              );
              sl<SharedPreferences>()
                  .setString(
                'token',
                state.login.data!.token.toString(),
              )
                  .then((value) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LayoutScreen(),
                  ),
                );
              });
            } else {
              showToast(
                text: state.login.messages!,
                state: ToastState.error,
              );
            }
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            backgroundColor: ColorManager.sWhite,
            appBar: AppBar(
              backgroundColor: ColorManager.sWhite,
              iconTheme: const IconThemeData(
                color: ColorManager.black_54,
              ),
              elevation: 0,
            ),
            bottomNavigationBar: bottomNav(context),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p24,
                  vertical: AppPadding.p16,
                ),
                child: Form(
                  key: cubit.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      blackHeading(
                        AppStrings.login,
                      ),
                      const SizedBox(
                        height: AppSize.s50,
                      ),
                      MyFormField(
                        controller: cubit.emailController,
                        type: TextInputType.emailAddress,
                        label: AppStrings.email,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppStrings.enterUrEmail;
                          }
                          return null;
                        },
                        isUpperCase: false,
                      ),
                      const SizedBox(
                        height: AppSize.s50,
                      ),
                      MyFormField(
                        controller: cubit.passwordController,
                        type: TextInputType.visiblePassword,
                        label: AppStrings.password,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppStrings.enterUrPassword;
                          } else if (value.length < 6) {
                            return AppStrings.enterCharPassword;
                          }
                          return null;
                        },
                        isPassword: cubit.isPassword,
                        suffix: cubit.suffix,
                        onPressed: () {
                          cubit.changeLoginPasswordVisibility();
                        },
                      ),
                      const SizedBox(
                        height: AppSize.s80,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          MyTextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPasswordScreen(),
                                ),
                              );
                            },
                            text: AppStrings.forgotPass,
                            colors: ColorManager.sBlack,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: AppSize.s60,
                      ),
                      ConditionalBuilder(
                        condition: state is! GetLoginUserLoadingState,
                        builder: (context) => MyElevatedButton(
                          onPressed: () {
                            if (cubit.formKey.currentState!.validate()) {
                              cubit.getLoginUser(
                                email: cubit.emailController.text,
                                password: cubit.passwordController.text,
                                context: context,
                              );
                            }
                          },
                          colors: appColorBtn,
                          text: AppStrings.login,
                        ),
                        fallback: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  bottomNav(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        greyText(
          AppStrings.haveNotAccount,
        ),
        MyTextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const RegisterScreen(),
              ),
            );
          },
          colors: Colors.black,
          text: AppStrings.signUp,
        )
      ],
    );
  }

// imageButton(image, name) {
//   return ElevatedButton.icon(
//     icon: Image.asset(
//       image,
//       width: 24,
//       height: 24,
//     ),
//     label: Text(name),
//     onPressed: () {},
//     style: ElevatedButton.styleFrom(
//       primary: Colors.white,
//       onPrimary: Colors.black,
//       shadowColor: Colors.black38,
//       elevation: 5,
//       padding: const EdgeInsets.all(16),
//       shape: (RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(50),
//       )),
//     ),
//   );
// }
}
