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
import 'package:squeak/core/widgets/text_btn.dart';
import 'package:squeak/core/widgets/toast_state.dart';


import '../../../../login/presentation/pages/login.dart';
import '../../../verficiation/presentation/pages/verification.dart';
import '../controller/cubit/register_as_a_doctor_cubit.dart';
import '../controller/cubit/register_as_a_doctor_state.dart';



class RegisterAsADoctorScreen extends StatelessWidget {
  const RegisterAsADoctorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<RegisterAsADoctorCubit>(),
      child: BlocConsumer<RegisterAsADoctorCubit, RegisterAsADoctorState>(
        listener: (context, state) {
          if (state is GetRegisterAsADoctorSuccessState) {
            if (state.registerAsADoctor.status) {
              showToast(
                text: state.registerAsADoctor.messages.toString(),
                state: ToastState.success,
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Verification(),
                ),
              );
            } else {
              showToast(
                text: state.registerAsADoctor.messages.toString(),
                state: ToastState.error,
              );
            }
          }
        },
        builder: (context, state) {
          var cubit = RegisterAsADoctorCubit.get(context);
          return Scaffold(
            backgroundColor: ColorManager.sWhite,
            bottomNavigationBar: bottomNav(context),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(
                  AppPadding.p24,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppPadding.p40,
                  ),
                  child: Form(
                    key: cubit.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        blackHeading(
                          AppStrings.signUpAsADoctor,
                        ),
                        const SizedBox(
                          height: AppSize.s20,
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
                          height: AppSize.s20,
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
                        ),
                        const SizedBox(
                          height: AppSize.s20,
                        ),
                        MyFormField(
                          controller: cubit.phoneController,
                          type: TextInputType.phone,
                          label: AppStrings.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppStrings.enterPhone;
                            }
                            return null;
                          },
                          isUpperCase: false,
                        ),
                        const SizedBox(
                          height: AppSize.s20,
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
                          suffix: cubit.suffix,
                          isPassword: cubit.isPassword,
                          onPressed: () {
                            cubit.changeRegisterAsADoctorPasswordVisibility();
                          },
                        ),
                        const SizedBox(
                          height: AppSize.s20,
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
                          suffix: cubit.suffixCon,
                          isPassword: cubit.isConPassword,
                          onPressed: () {
                            cubit
                                .changeRegisterAsADoctorConPasswordVisibility();
                          },
                        ),
                        const SizedBox(
                          height: AppSize.s40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: AppPadding.p36,
                                    vertical: AppPadding.p16),
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
                          condition: state is! GetRegisterAsADoctorLoadingState,
                          builder: (context) => MyElevatedButton(
                            onPressed: () {
                              if (cubit.formKey.currentState!.validate()) {
                                cubit.getRegisterAsADoctor(
                                  fullName: cubit.nameController.text,
                                  email: cubit.emailController.text,
                                  phone: cubit.phoneController.text,
                                  password: cubit.passwordController.text,
                                  confirmationPassword:
                                      cubit.passwordConfirmController.text,
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

  bottomNav(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        greyText(AppStrings.alreadyHaveAccount),
        MyTextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
            colors: Colors.black,
            text: AppStrings.login)
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
