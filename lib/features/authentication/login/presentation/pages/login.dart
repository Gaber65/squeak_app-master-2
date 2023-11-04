import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:squeak/core/widgets/components/styles.dart';
import 'package:squeak/core/network/end-points.dart';
import 'package:squeak/core/resources/color_manager.dart';
import 'package:squeak/core/resources/strings_manager.dart';
import 'package:squeak/core/resources/values_manager.dart';
import 'package:squeak/core/service/service_locator.dart';
import 'package:squeak/core/widgets/elevated_button.dart';
import 'package:squeak/core/widgets/my_form_field.dart';
import 'package:squeak/core/widgets/text_btn.dart';
import 'package:squeak/core/widgets/toast_state.dart';
import 'package:squeak/features/availability/presentation/control/appointments/appointments_cubit.dart';
import 'package:squeak/features/layout/layout.dart';
import 'package:squeak/features/setting/profile/presentation/pages/contact_us.dart';
import 'package:squeak/features/setting/update_profile/presentation/controlls/cubit/beets_type_find_cubit.dart';
import 'package:squeak/features/social_media/presentation/controller/phone_cubit/phone_cubit.dart';

import '../../../../../core/resources/constants_manager.dart';
import '../../../../../generated/l10n.dart';
import '../../../../layout/build_layout.dart';
import '../../../../layout/presentation/controller/Home_cubit/squeak_cubit.dart';
import '../../../../layout/presentation/controller/post_cubit/post_cubit.dart';
import '../../../../layout/presentation/screens/clinic/clinic_cubit/clinic_cubit.dart';
import '../../../register/register_as_a_user/presentation/pages/register.dart';
import '../controller/cubit/login_cubit.dart';
import '../controller/cubit/login_state.dart';
import 'forgot_password.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<LoginCubit>(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is GetLoginUserSuccessState) {
            if (state.login.status) {
              showToast(
                text: state.login.messages,
                state: ToastState.success,
              );
              sl<SharedPreferences>().setString('token', state.login.data!.token);
              sl<SharedPreferences>().setInt('role', state.login.data!.role);
              sl<SharedPreferences>().setString('clintId', state.login.data!.id);
              sl<SharedPreferences>().setString('refreshToken', state.login.data!.refreshToken);
              sl<SharedPreferences>().setString('email', state.login.data!.email);
              sl<SharedPreferences>().setString('password', LoginCubit.get(context).passwordController.text);



              token = state.login.data!.token;
              clintId = state.login.data!.id;
              refreshToken = state.login.data!.refreshToken;
              email = state.login.data!.email;
              password = LoginCubit.get(context).passwordController.text;

              SqueakCubit.get(context).getProfile();
              PostCubit.get(context).getAllUserPost();
              PostCubit.get(context).getAllDoctorPost();
              ClinicCubit.get(context).geMyFollowerClinic();
              AppointmentsCubit.get(context).getAppointments();
              // PhoneCubit.get(context).getUserData();

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LayoutScreen(),
                ),
                (route) => false,
              );
            }

            if (!state.login.status) {
              showToast(
                text: state.login.messages,
                state: ToastState.success,
              );
            }
          }
          if (state is SuccessLoginState) {
            sl<SharedPreferences>().setString('uId', state.uId);
            uId = state.uId;
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: ColorManager.sWhite,
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
            bottomNavigationBar: bottomNav(context),
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
                              padding: const EdgeInsets.only(top: 100),
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
                                child: buildColumnForm(cubit, context, state),
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
          suffix: const Icon(IconlyLight.message),
          fillColor: Colors.white,
        ),
        const SizedBox(
          height: AppSize.s50,
        ),
        MyFormField(
            fillColor: Colors.white,
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
          children: [
            MyTextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ForgotPasswordScreen(),
                  ),
                );
              },
              text: S.of(context).forgotPass,
              colors: ColorManager.sBlack,
            ),
          ],
        ),
        const SizedBox(
          height: AppSize.s10,
        ),
        ConditionalBuilder(
          condition: state is! GetLoginUserLoadingState,
          builder: (context) => MyElevatedButton(
            onPressed: () {
              if (cubit.formKey.currentState!.validate()) {
                // cubit.userLogin(
                //   email: cubit.emailController.text,
                //   password: cubit.passwordController.text,
                // );
                cubit.getLoginUser(
                  email: cubit.emailController.text,
                  password: cubit.passwordController.text,
                );
              }
            },
            colors: appColorBtn,
            text: S.of(context).login,
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
        greyText(
          S.of(context).haveNotAccount,
        ),
        MyTextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => RegisterScreen(),
              ),
            );
          },
          colors: Colors.black,
          text: S.of(context).signUp,
        )
      ],
    );
  }

  Widget _buildProfile(context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.35,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      color: appColorBtn,
      child: Text(
        S.of(context).login,
        style: const TextStyle(fontSize: 40, color: Colors.white),
      ),
    );
  }

  Widget _buildProfileDtl(context) {
    return Container(
      padding: const EdgeInsets.all(24),
      height: MediaQuery.of(context).size.height * 0.45,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [],
      ),
    );
  }
}
