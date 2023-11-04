import 'package:flutter/material.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squeak/web_view/authentication/user_web_register.dart';
import 'package:squeak/web_view/authentication/web_login.dart';

import '../../core/resources/color_manager.dart';
import '../../core/resources/strings_manager.dart';
import '../../core/resources/values_manager.dart';
import '../../core/service/service_locator.dart';
import '../../core/widgets/components/styles.dart';
import '../../core/widgets/elevated_button.dart';
import '../../core/widgets/my_form_field.dart';
import '../../core/widgets/national_phone.dart';
import '../../features/authentication/login/presentation/controller/cubit/login_cubit.dart';
import '../../features/authentication/login/presentation/controller/cubit/login_state.dart';
import '../../features/authentication/login/presentation/pages/forgot_password.dart';
import '../../features/authentication/register/register_as_a_doctor/presentation/pages/register_as_a_doctor.dart';
import '../../features/authentication/register/register_as_a_user/presentation/controller/cubit/register_cubit.dart';
import '../../features/authentication/register/register_as_a_user/presentation/controller/cubit/register_state.dart';
import '../../features/authentication/register/register_as_a_user/presentation/pages/register.dart';

class UserRegisterWebView extends StatelessWidget {
  const UserRegisterWebView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<RegisterCubit>(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
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
                          child:buildColumnForm(cubit, state, context),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            greyText(AppStrings.alreadyHaveAccount),
                            MyElevatedButton(
                              onPressed:  () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginWebView(),
                                  ),
                                );
                              },
                              colors: Colors.black,
                              text: AppStrings.login,
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
      RegisterCubit cubit, RegisterState state, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppSize.s10,
        ),
        // MyFormField(
        //   controller: emailController,
        //   type: TextInputType.emailAddress,
        //   label: AppStrings.email,
        //   validator: (value) {
        //     if (value!.isEmpty) {
        //       return AppStrings.enterUrEmail;
        //     }
        //     return null;
        //   },
        //   isUpperCase: false,
        //   suffix: Icon(Icons.alternate_email),
        //
        // ),
        const SizedBox(
          height: AppSize.s10,
        ),
        MyFormField(
          controller: cubit.nameController,
          type: TextInputType.text,
          label: AppStrings.fullName,
          validator: (value) {
            if (value!.isEmpty) {
              return AppStrings.enterName;
            } else if (value.length < 6) {
              return AppStrings.enterCharNamePls;
            }
            return null;
          },
          isUpperCase: false,
          suffix: Icon(Icons.person),
        ),
        const SizedBox(
          height: AppSize.s10,
        ),
        IntlPhoneNumber(controller: cubit.phoneController),
        const SizedBox(
          height: AppSize.s10,
        ),
        MyFormField(
          controller: cubit.passwordController,
          type: TextInputType.visiblePassword,
          label: AppStrings.password,
          validator: (value) {
            if (value!.isEmpty) {
              return AppStrings.enterUrPassword;
            }
            return null;
          },
          isUpperCase: false,
          suffix: IconButton(
            icon: Icon(cubit.suffix),
            onPressed: () {
              cubit.changeRegisterConPasswordVisibility();
            },
          ),
          isPassword: cubit.isPassword,
        ),
        const SizedBox(
          height: AppSize.s10,
        ),
        MyFormField(
          controller: cubit.passwordConfirmController,
          type: TextInputType.visiblePassword,
          label: AppStrings.confirmPassword,
          validator: (value) {
            if (value!.isEmpty) {
              return AppStrings.comparePassword;
            } else if (cubit.passwordController ==
                cubit.passwordConfirmController) {
              return AppStrings.notEqualPassword;
            }
            return null;
          },
          isUpperCase: false,
          isPassword: cubit.isConPassword,
          suffix: IconButton(
            icon: Icon(cubit.suffix),
            onPressed: () {
              cubit.changeRegisterConPasswordVisibility();
            },
          ),
        ),
        const SizedBox(
          height: AppSize.s10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p36, vertical: AppPadding.p16),
                child: const Text(
                  AppStrings.terms,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorManager.black_45,
                    fontSize: AppSize.s12,
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: AppSize.s30,
        ),
        ConditionalBuilder(
          condition: state is! GetRegisterUserLoadingState,
          builder: (context) => MyElevatedButton(
            onPressed: () {
              if (cubit.formKey.currentState!.validate()) {
                cubit.getRegisterUser(
                  fullName: cubit.nameController.text,
                  email: 'cubit.emailController.text',
                  phone: cubit.phoneController.text,
                  password: cubit.passwordController.text,
                  confirmationPassword: cubit.passwordConfirmController.text,
                );
              }
            },
            colors: appColorBtn,
            text: AppStrings.signUp,
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
        const SizedBox(
          height: AppSize.s20,
        ),
        Center(
          child: MyElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>  RegisterAsADoctorScreen(),
                ),
              );
            },
            text: AppStrings.signUpAsADoctor,
            colors: Colors.black,
          ),
        ),
      ],
    );
  }
}
