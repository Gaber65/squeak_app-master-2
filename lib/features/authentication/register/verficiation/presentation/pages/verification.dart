import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squeak/components/styles.dart';
import 'package:squeak/core/resources/color_manager.dart';
import 'package:squeak/core/resources/strings_manager.dart';
import 'package:squeak/core/resources/values_manager.dart';
import 'package:squeak/core/service/service_locator.dart';
import 'package:squeak/core/widgets/elevated_button.dart';
import 'package:squeak/core/widgets/my_form_field.dart';
import 'package:squeak/core/widgets/toast_state.dart';

import '../../../../login/presentation/pages/login.dart';
import '../controller/cubit/ver_cubit.dart';
import '../controller/cubit/ver_state.dart';




class Verification extends StatelessWidget {
  const Verification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(create: (BuildContext context) => sl<VerificationCodeCubit>(),
      child: BlocConsumer<VerificationCodeCubit, VerificationCodeState>(
        listener: (context, state) {
          if (state is GetVerificationSuccessState) {
            if (state.verificationCode.status) {
              showToast(
                text: state.verificationCode.messages,
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
                text: state.verificationCode.messages,
                state: ToastState.error,
              );
            }
          }
        },
        builder: (context, state) {
          var cubit = VerificationCodeCubit.get(context);
          return Scaffold(
              backgroundColor: ColorManager.sWhite,
              appBar: AppBar(
                backgroundColor: ColorManager.sWhite,
                iconTheme: const IconThemeData(
                  color: ColorManager.black_87,
                ),
                elevation: 0,
              ),
              body: Center(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(
                      AppPadding.p24,
                    ),
                    child: Form(
                      key: cubit.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: AppSize.s30,
                          ),
                          blackHeading(
                            AppStrings.verification,
                          ),
                          const SizedBox(
                            height: AppSize.s30,
                          ),
                          greyText(
                            AppStrings.sentVerification,
                          ),
                          blackText(
                            AppStrings.checkYourEmail,
                          ),
                          const SizedBox(
                            height: AppSize.s30,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: AppPadding.p10,
                              horizontal: AppPadding.p16,
                            ),
                            child: Column(
                              children: [
                                MyFormField(
                                  controller: cubit.verificationTokenController,
                                  type: TextInputType.text,
                                  label: AppStrings.verification,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppStrings.sentVerification;
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: AppSize.s50,),
                          ConditionalBuilder(
                            condition: state is! GetVerificationLoadingState,
                            builder: (context) => MyElevatedButton(
                              onPressed: () {
                                if (cubit.formKey.currentState!.validate()) {
                                  cubit.getVerificationCode(
                                    verificationToken:
                                    cubit.verificationTokenController.text,
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
              ));
        },
      ),
    );
  }
}
