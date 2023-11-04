import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:squeak/core/resources/color_manager.dart';
import 'package:squeak/core/resources/strings_manager.dart';
import 'package:squeak/core/resources/values_manager.dart';
import 'package:squeak/core/service/service_locator.dart';
import 'package:squeak/core/widgets/toast_state.dart';

import '../../../../../core/widgets/elevated_button.dart';
import '../../../../../core/widgets/my_form_field.dart';
import '../controller/cubit/login_cubit.dart';
import '../controller/cubit/login_state.dart';
import 'login.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({
    Key? key,
    required this.controller,
  }) : super(key: key);

  TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<LoginCubit>(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is ResetPasswordSuccessState) {
            if (state.resetPassword.status) {
              showToast(
                text: state.resetPassword.messages,
                state: ToastState.success,
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            } else {
              showToast(
                text: state.resetPassword.errors.values.isNotEmpty
                    ? state.resetPassword.errors.values.first[0]
                    : state.resetPassword.messages,
                state: ToastState.error,
              );
            }
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            backgroundColor: ColorManager.sWhite,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(
                  AppPadding.p20,
                ),
                child: SizedBox(
                  height: AppSize.s650,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.changePassword,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(
                        height: AppSize.s30,
                      ),
                      Form(
                        key: cubit.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyFormField(
                              controller: cubit.codeController,
                              type: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return AppStrings.enterCode;
                                }
                                return null;
                              },
                              label: AppStrings.receiveCode,
                              suffix: Icon(Icons.restore_sharp),
                            ),
                            const SizedBox(
                              height: AppSize.s10,
                            ),

                            const SizedBox(
                              height: AppSize.s10,
                            ),
                            MyFormField(
                                fillColor: Colors.white,
                                controller: cubit.newPasswordController,
                                type: TextInputType.visiblePassword,
                                label: AppStrings.newPassword,
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
                                    cubit.changeRegisterAsADoctorPasswordVisibility();
                                  },
                                )),
                            const SizedBox(
                              height: AppSize.s10,
                            ),
                            MyFormField(
                                fillColor: Colors.white,
                                controller: cubit.confirmNewPasswordController,
                                type: TextInputType.visiblePassword,
                                label: AppStrings.confirmNewPassword,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppStrings.enterUrPassword;
                                  } else if (value.length < 6) {
                                    return AppStrings.enterCharPassword;
                                  }
                                  return null;
                                },
                                isPassword: cubit.isConPassword,
                                suffix: IconButton(
                                  icon: Icon(cubit.suffixCon),
                                  onPressed: () {
                                    cubit.changeRegisterAsADoctorConPasswordVisibility();
                                  },
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: AppSize.s30,
                      ),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      ConditionalBuilder(
                        condition: state is! ResetPasswordLoadingState,
                        builder: (context) => MyElevatedButton(
                          onPressed: () {
                            if (cubit.formKey.currentState!.validate()) {
                              cubit.getResetPassword(
                                token: cubit.codeController.text,
                                password: cubit.newPasswordController.text,
                                email: controller.text,
                                confirmNewPassword:
                                    cubit.confirmNewPasswordController.text,
                              );
                            }
                          },
                          text: AppStrings.save,
                          colors: ColorManager.lightRed,
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
}
