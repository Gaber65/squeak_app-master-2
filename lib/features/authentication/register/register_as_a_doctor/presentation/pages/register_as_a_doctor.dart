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
import 'package:squeak/core/widgets/national_phone.dart';
import 'package:squeak/core/widgets/text_btn.dart';
import 'package:squeak/core/widgets/toast_state.dart';
import 'package:squeak/features/authentication/register/register_as_a_user/presentation/controller/cubit/register_cubit.dart';
import 'package:squeak/features/authentication/register/register_as_a_user/presentation/controller/cubit/register_state.dart';

import '../../../../../layout/build_layout.dart';
import '../../../../../setting/profile/presentation/pages/contact_us.dart';
import '../../../../login/presentation/pages/login.dart';
import '../../../verficiation/presentation/pages/verification.dart';
import '../controller/cubit/register_as_a_doctor_cubit.dart';
import '../controller/cubit/register_as_a_doctor_state.dart';

class RegisterAsADoctorScreen extends StatelessWidget {
  RegisterAsADoctorScreen({Key? key}) : super(key: key);

  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<RegisterAsADoctorCubit>(),
      child: BlocConsumer<RegisterAsADoctorCubit, RegisterAsADoctorState>(
        listener: (context, state) {
          if (state is GetRegisterAsADoctorSuccessState) {
            if (state.registerAsADoctor.status) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Verification(
                    emailController: emailController,
                  ),
                ),
              );
              showToast(
                text: state.registerAsADoctor.messages,
                state: ToastState.success,
              );
            } else {
              showToast(
                text: state.registerAsADoctor.errors.values.first[0]!,
                state: ToastState.success,
              );
            }
          }
        },
        builder: (context, state) {
          var cubit = RegisterAsADoctorCubit.get(context);
          return Scaffold(
            backgroundColor: ColorManager.sWhite,
            bottomNavigationBar: bottomNav(context),
            // resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: appColorBtn,
              iconTheme: const IconThemeData(
                color: ColorManager.black_54,
              ),
              elevation: 0,
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContactUsScreen(),
                        ));
                  },
                  icon: const Icon(Icons.help),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Form(
                key: cubit.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              _buildProfile(context),
                              _buildProfileDtl(context)
                            ],
                          ),
                          SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Container(
                                padding: const EdgeInsets.all(24),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 70),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 8.0,
                                    ),
                                  ],
                                ),
                                child: buildColumnForm(cubit, state),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Column buildColumnForm(
      RegisterAsADoctorCubit cubit, RegisterAsADoctorState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyFormField(
          fillColor: Colors.white,
          controller: emailController,
          type: TextInputType.emailAddress,
          label: AppStrings.email,
          validator: (value) {
            if (value!.isEmpty) {
              return AppStrings.enterUrEmail;
            }
            return null;
          },
          isUpperCase: false,
          suffix: const Icon(IconlyLight.message),
        ),
        const SizedBox(
          height: AppSize.s10,
        ),
        MyFormField(
          fillColor: Colors.white,
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
          suffix: const Icon(IconlyLight.profile),
        ),
        const SizedBox(
          height: AppSize.s10,
        ),
        IntlPhoneNumber(controller: cubit.phoneController),
        const SizedBox(
          height: AppSize.s10,
        ),
        MyFormField(
          fillColor: Colors.white,
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
          isPassword: cubit.isPassword,
          suffix: IconButton(
            icon: Icon(cubit.suffix),
            onPressed: () {
              cubit.changeRegisterAsADoctorPasswordVisibility();
            },
          ),
        ),
        const SizedBox(
          height: AppSize.s10,
        ),
        MyFormField(
          fillColor: Colors.white,
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
              cubit.changeRegisterAsADoctorConPasswordVisibility();
            },
          ),
        ),
        const SizedBox(
          height: AppSize.s20,
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
          condition: state is! GetRegisterAsADoctorLoadingState,
          builder: (context) => MyElevatedButton(
            onPressed: () {
              if (cubit.formKey.currentState!.validate()) {
                // cubit.userRegister(
                //   username: cubit.nameController.text,
                //   email: emailController.text,
                //   phone: cubit.phoneController.text,
                //   password: cubit.passwordController.text,
                //   role: 2,
                // );
                cubit.getRegisterAsADoctor(
                  fullName: cubit.nameController.text,
                  email: emailController.text,
                  phone: cubit.phoneController.text!.length == 12
                      ? '0${cubit.phoneController.text}'
                      : cubit.phoneController.text,
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
      ],
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
                  builder: (context) => LoginScreen(),
                ),
              );
            },
            colors: Colors.black,
            text: AppStrings.login)
      ],
    );
  }

  Widget _buildProfile(context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.35,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      color: appColorBtn,
      child: const Text(
        AppStrings.signUpAsADoctor,
        style: TextStyle(fontSize: 30, color: Colors.white),
      ),
    );
  }

  Widget _buildProfileDtl(context) {
    return Container(
      padding: const EdgeInsets.all(24),
      height: MediaQuery.of(context).size.height * 0.45,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [],
      ),
    );
  }
}
