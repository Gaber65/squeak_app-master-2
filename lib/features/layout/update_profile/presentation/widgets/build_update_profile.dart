import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squeak/components/styles.dart';
import 'package:squeak/core/resources/color_manager.dart';
import 'package:squeak/core/resources/strings_manager.dart';
import 'package:squeak/core/resources/values_manager.dart';
import 'package:squeak/core/service/service_locator.dart';
import 'package:squeak/core/widgets/my_button.dart';
import 'package:squeak/core/widgets/my_form_field.dart';
import 'package:squeak/features/layout/cubit/squeak_cubit.dart';
import 'package:squeak/features/layout/cubit/squeak_state.dart';
import 'package:squeak/features/layout/layout.dart';
import 'package:squeak/features/layout/profile/domain/entities/profile.dart';
import 'package:squeak/features/layout/update_profile/domain/entities/update_profile.dart';

import '../../../../../core/utils/translation/applocal.dart';
import '../../../../../core/widgets/toast_state.dart';

class BuildUpdateProfile extends StatefulWidget {
  final Profile model;

  const BuildUpdateProfile({Key? key, required this.model}) : super(key: key);

  @override
  State<BuildUpdateProfile> createState() => _BuildUpdateProfileState();
}

class _BuildUpdateProfileState extends State<BuildUpdateProfile> {
  DateTime currentDate = DateTime.now();
  late String timeDate = "";
  var cubit;

  late String birthdat = "";
  var profileImage;
  int selectID = 1;
  String gender = "1";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = SqueakCubit.get(context);

    cubit.fullNameController.text = widget.model.data!.owner!.fullname!;
    cubit.phoneController.text = widget.model.data!.owner!.phone!;
    cubit.emailController.text = widget.model.data!.owner!.email!;
    cubit.addressController.text = widget.model.data!.owner!.addresss==null?"":widget.model.data!.owner!.addresss;
    cubit.genderController.text = widget.model.data!.owner!.gender!.toString();
    cubit.imageController.text =
        widget.model.data!.owner!.imageName!.toString();
    cubit.fullNameController.text = widget.model.data!.owner!.fullname!;
    birthdat = widget.model.data!.owner!.birthdat != null
        ? widget.model.data!.owner!.birthdat!
        : "";
    setState(() {
      timeDate = birthdat;
      gender = widget.model.data!.owner!.gender!.toString();
      selectID = widget.model.data!.owner!.gender!;
    });
  }

  @override
  Widget build(BuildContext context) {
    profileImage = SqueakCubit.get(context).profileImage;

    return BlocConsumer<SqueakCubit, SqueakState>(
      listener: (context, state) {




      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(
              AppPadding.p20,
            ),
            child: Column(
              children: [
                Center(
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      CircleAvatar(
                        radius: AppSize.s60,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        backgroundImage: profileImage == null
                            ? NetworkImage(
                                widget.model.data!.owner!.imageName.toString(),
                              )
                            : FileImage(cubit.profileImage) as ImageProvider,
                      ),
                      IconButton(
                        onPressed: () {
                          cubit.getProfileImage();

                        },
                        icon: const CircleAvatar(
                          radius: AppSize.s30,
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: ColorManager.sWhite,
                            size: AppSize.s20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                MyFormField(
                  controller: cubit.fullNameController,
                  type: TextInputType.text,
                  label:"${getLang(context, "fullName")}" ,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "${getLang(context, "enterName")}" ;
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildSelect('Male', 1),
                    _buildSelect('Female', 0),
                  ],
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                MyFormField(
                  controller: cubit.emailController,
                  type: TextInputType.emailAddress,
                  label:"${getLang(context, "email")}" ,
                  enable: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "${getLang(context, "enterUrEmail")}" ;
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                MyFormField(
                  controller: cubit.phoneController,
                  type: TextInputType.phone,
                  label: "${getLang(context, "phone")}",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "${getLang(context, "enterPhone")}" ;
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                MyFormField(
                  controller: cubit.addressController,
                  type: TextInputType.text,
                  label: "${getLang(context, "address")}",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "${getLang(context, "enterUrAddress")}";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'Date of birth',
                      textAlign: TextAlign.left,
                      style:
                          const TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ],
                ),
                _buildSelectDate(),
                const SizedBox(
                  height: AppSize.s50,
                ),
                BlocConsumer<SqueakCubit, SqueakState>(
                  listener: (context, state) {
                    if (state is SqueakUpdateProfileSuccessState) {
                      showToast
                        (
                        text: state.updateProfile.message!,
                        state: ToastState.success,
                      );


                      sl<SqueakCubit>()..getProfile();
                      cubit.changeBottomNav(3);


                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                          const LayoutScreen(),
                        ),
                      );

//                       setState(() {
//
// });
                      // Navigator.pop(context);
                    }

        if (state is SqueakUpdateProfileErrorState) {
          showToast
            (
            text: state.error!,
            state: ToastState.error,
          );
        }

                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    return MyButton(
                      onPressedTextButton: () {
                        // print("cccccccccccccccc${gender}");
                        // print("cccccccccccccccc${selectID}");

                        cubit.getUpdateProfile(
                          fullName: cubit.fullNameController.text,
                          emailAddress: cubit.emailController.text,
                          phone: cubit.phoneController.text,
                          imageName:
                              profileImage == null ? "" : profileImage.path,
                          Imagepath:
                              profileImage == null ? "" : profileImage.path,
                          Birthdate: timeDate.isNotEmpty
                              ? timeDate
                              : birthdat != null
                                  ? birthdat
                                  : "",
                          address: cubit.addressController.text,
                          gender: gender,
                        );
                      },
                      text: "${getLang(context, "save")}"
                      ,
                      background: ColorManager.lightRed,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: ColorManager.sWhite,
                          ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        currentDate = pickedDate;
        timeDate = pickedDate.day.toString() +
            " / " +
            pickedDate.month.toString() +
            " / " +
            pickedDate.year.toString();
      });
    }
  }

  Widget _buildSelectDate() {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black26)),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //  Text(currentDate.toString()),
            Text(timeDate.isEmpty ? birthdat : timeDate,
                style: TextStyle(
                    fontFamily: 'medium', fontSize: 14, color: Colors.black54)),
            Icon(Icons.calendar_month, color: appColor)
          ],
        ),
      ),
    );
  }

  Widget _buildSelect(title, id) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectID = id;
          gender = selectID.toString();
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 50),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          color: selectID == id ? appColor : Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(50.0)),
        ),
        child: Text(title,
            style: TextStyle(
                fontFamily: 'medium',
                fontSize: 14,
                color: selectID == id ? Colors.white : Colors.black54)),
      ),
    );
  }
}
