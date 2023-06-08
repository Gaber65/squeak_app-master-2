import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squeak/core/resources/color_manager.dart';
import 'package:squeak/core/resources/strings_manager.dart';
import 'package:squeak/core/resources/values_manager.dart';
import 'package:squeak/core/service/service_locator.dart';
import 'package:squeak/core/widgets/my_button.dart';
import 'package:squeak/core/widgets/my_form_field_custom.dart';
import 'package:squeak/core/widgets/toast_state.dart';


import '../controller/cubit/login_cubit.dart';
import '../controller/cubit/login_state.dart';
import 'login.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

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
                  builder: (context) => const LoginScreen(),
                ),
              );
            } else {
              showToast(
                text: state.resetPassword.messages,
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
              elevation: 0.0,
            ),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.receiveCode,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(
                            height: AppSize.s10,
                          ),
                          MyFormFieldCustom(
                            controller: cubit.codeController,
                            type: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppStrings.enterCode;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: AppSize.s30,
                          ),
                          Text(
                            AppStrings.newPassword,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(
                            height: AppSize.s10,
                          ),
                          MyFormFieldCustom(
                            controller: cubit.newPasswordController,
                            type: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppStrings.enterCode;
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                      const Spacer(),
                      ConditionalBuilder(
                        condition: state is! ResetPasswordLoadingState,
                        builder: (context) => MyButton(
                          onPressedTextButton: () {
                            cubit.getResetPassword(
                              token: cubit.codeController.text,
                              password: cubit.newPasswordController.text,
                            );
                          },
                          text: AppStrings.save,
                          background: ColorManager.lightRed,
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    color: ColorManager.sWhite,
                                  ),
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
