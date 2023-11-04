import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squeak/web_view/authentication/user_web_register.dart';

import '../../core/resources/color_manager.dart';
import '../../core/resources/strings_manager.dart';
import '../../core/resources/values_manager.dart';
import '../../core/service/service_locator.dart';
import '../../core/widgets/components/styles.dart';
import '../../core/widgets/elevated_button.dart';
import '../../core/widgets/my_form_field.dart';
import '../../features/authentication/login/presentation/controller/cubit/login_cubit.dart';
import '../../features/authentication/login/presentation/controller/cubit/login_state.dart';
import '../../features/authentication/login/presentation/pages/forgot_password.dart';
import '../../features/authentication/register/register_as_a_user/presentation/pages/register.dart';

class LoginWebView extends StatelessWidget {
  const LoginWebView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<LoginCubit>(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            body: Form(
              key: cubit.formKey,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: appColorBtn,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.35,
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 24),
                            color: appColorBtn,
                            child: const Text(
                              AppStrings.login,
                              style: TextStyle(
                                fontSize: 40,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: buildColumnForm(cubit, context, state),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            greyText(
                              AppStrings.haveNotAccount,
                            ),
                            MyElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const UserRegisterWebView(),
                                  ),
                                );
                              },
                              text: AppStrings.signUp,
                              colors: Colors.black,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Column buildColumnForm(
      LoginCubit cubit, BuildContext context, LoginState state) {
    return Column(
      children: [
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
          suffix: const Icon(Icons.alternate_email),
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
            suffix: IconButton(
              icon: Icon(cubit.suffix),
              onPressed: () {
                cubit.changeLoginPasswordVisibility();
              },
            )),
        const SizedBox(
          height: AppSize.s10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MyElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  ForgotPasswordScreen(),
                  ),
                );
              },
              colors: Colors.black,
              text: AppStrings.forgotPass,
            ),
          ],
        ),
        const SizedBox(
          height: AppSize.s10,
        ),
        ConditionalBuilder(
          condition: state is! GetLoginUserLoadingState &&
              state is! GetLoginUserErrorState,
          builder: (context) => MyElevatedButton(
            onPressed: () {
              if (cubit.formKey.currentState!.validate()) {
                cubit.getLoginUser(
                  email: cubit.emailController.text,
                  password: cubit.passwordController.text,
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
    );
  }
}
