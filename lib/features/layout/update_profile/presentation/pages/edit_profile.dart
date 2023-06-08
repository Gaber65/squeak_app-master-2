import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squeak/core/resources/assets_manager.dart';
import 'package:squeak/core/resources/color_manager.dart';
import 'package:squeak/core/resources/strings_manager.dart';
import 'package:squeak/core/service/service_locator.dart';
import 'package:squeak/core/widgets/text_btn.dart';
import 'package:squeak/features/layout/cubit/squeak_cubit.dart';
import 'package:squeak/features/layout/cubit/squeak_state.dart';
import 'package:squeak/features/layout/update_profile/presentation/widgets/build_update_profile.dart';

import '../../../../../core/utils/translation/applocal.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      BlocProvider(
      create: (BuildContext context)=>
      sl<SqueakCubit>()..getProfile(),

      // sl<SqueakCubit>()..getUpdateProfile(
      //     fullName: SqueakCubit.get(context).fullNameController.text
      //     , emailAddress: SqueakCubit.get(context).emailController.text,
      //     phone: SqueakCubit.get(context).phoneController.text,
      //     imageName: '',
      //     address: SqueakCubit.get(context).addressController.text,
      //     gender: SqueakCubit.get(context).genderController.text,
      // ),
      child: BlocConsumer<SqueakCubit, SqueakState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SqueakCubit.get(context);
          return Scaffold(
            backgroundColor: ColorManager.sWhite,
            appBar: AppBar(
              backgroundColor: ColorManager.sWhite,
              elevation: 0.0,
              title:  Text("${getLang(context, "profile")}"
                ,
              ),
              actions: [
                MyTextButton(
                  onPressed: () {},
                  text:"${getLang(context, "skip")}",
                  colors: ColorManager.lightRed,
                ),
              ],
            ),
            body: ConditionalBuilder(
              condition: cubit.profile != null,
              builder: (context) =>
                  BuildUpdateProfile(model: cubit.profile!),
              fallback: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
      ),
    );
  }
}
