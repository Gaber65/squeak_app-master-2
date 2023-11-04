import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:squeak/core/widgets/components/styles.dart';
import 'package:squeak/core/resources/color_manager.dart';
import 'package:squeak/core/resources/strings_manager.dart';
import 'package:squeak/core/resources/values_manager.dart';
import 'package:squeak/core/service/service_locator.dart';
import 'package:squeak/core/widgets/my_form_field.dart';
import 'package:squeak/core/widgets/toast_state.dart';
import 'package:squeak/core/widgets/elevated_button.dart';
import 'package:squeak/features/authentication/login/presentation/pages/reset_password.dart';

import '../../../../../generated/l10n.dart';
import '../../../../setting/profile/presentation/pages/contact_us.dart';
import '../controller/cubit/login_cubit.dart';
import '../controller/cubit/login_state.dart';

class ForgotPasswordScreen extends StatelessWidget {
   ForgotPasswordScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<LoginCubit>(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is ForgetPasswordSuccessState) {
            if (state.forgetPassword.success) {
              showToast(
                text: state.forgetPassword.message,
                state: ToastState.success,
              );
            } else {
              showToast(
                text: state.forgetPassword.message,
                state: ToastState.error,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: ColorManager.sWhite,
            appBar: AppBar(
              backgroundColor: ColorManager.sWhite,
              iconTheme: const IconThemeData(
                color: ColorManager.black_87,
              ),
              elevation: 0,
              actions: [
                IconButton(

                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUsScreen(),));
                  },
                  icon: const Icon(Icons.help),
                )
              ],
            ),
            body: (state is ForgetPasswordSuccessState) ? ResetPasswordScreen(controller: LoginCubit.get(context).emailController) : Center(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(
                    AppPadding.p24,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: AppSize.s30,
                        ),
                        blackHeading(
                          S.of(context).forgotPass,

                        ),
                        const SizedBox(
                          height: AppSize.s30,
                        ),
                        greyText(
                          AppStrings.receiveEmail,
                        ),
                        const SizedBox(
                          height: AppSize.s30,
                        ),
                        MyFormField(
                          controller: LoginCubit.get(context).emailController,
                          type: TextInputType.text,
                          label: AppStrings.email,
                          suffix: const Icon(IconlyLight.message),

                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppStrings.enterUrEmail;
                            }
                            return null;
                          },
                          isUpperCase: false,
                        ),


                        const SizedBox(
                          height: AppSize.s30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ForgetPasswordLoadingState,
                          builder: (context) => MyElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).getForgetPassword(
                                  email: LoginCubit.get(context).emailController.text,
                                );
                              }
                            },
                            colors: appColorBtn,
                            text: AppStrings.sendMeNow,
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
            ),
          );
        },
      ),
    );
  }
}
