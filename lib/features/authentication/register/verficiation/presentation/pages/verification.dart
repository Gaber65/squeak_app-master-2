import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:squeak/core/widgets/components/styles.dart';
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
  Verification({Key? key , required this.emailController,}) : super(key: key);
  var verificationTokenController = TextEditingController();
  TextEditingController emailController ;

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(create: (BuildContext context) => sl<VerificationCodeCubit>(),
      child: BlocConsumer<VerificationCodeCubit, VerificationCodeState>(
        listener: (context, state) {
          if (state is GetVerificationSuccessState) {
            if (state.verificationCode.success) {
              showToast(
                text: state.verificationCode.message,
                state: ToastState.success,
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>  LoginScreen(),
                ),
              );
            } else {
              showToast(
                text: state.verificationCode.message,
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

                elevation: 0,
              ),
              body: Center(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(
                      AppPadding.p12,
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

                                const SizedBox(height: 12,),

                                MyFormField(
                                  controller: verificationTokenController,
                                  type: TextInputType.text,
                                  label: AppStrings.verification,
                                  suffix: const Icon(IconlyLight.shield_done),

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
                                    verificationToken:verificationTokenController.text,
                                    email:emailController.text,
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
