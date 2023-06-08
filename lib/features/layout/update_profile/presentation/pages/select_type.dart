import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squeak/components/styles.dart';
import 'package:squeak/core/resources/color_manager.dart';
import 'package:squeak/core/resources/strings_manager.dart';
import 'package:squeak/core/resources/values_manager.dart';
import 'package:squeak/core/service/service_locator.dart';
import 'package:squeak/core/widgets/circularImageBorder.dart';
import 'package:squeak/core/widgets/elevated_button.dart';
import 'package:squeak/core/widgets/my_form_field.dart';
import 'package:squeak/core/widgets/toast_state.dart';
import 'package:squeak/features/layout/update_profile/presentation/pages/add_pet_detail.dart';

class SelectType extends StatefulWidget {
  const SelectType({Key? key}) : super(key: key);

  @override
  State<SelectType> createState() => _SelectTypeState();
}

class _SelectTypeState extends State<SelectType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.sWhite,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: appColor),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Select pet Type',
            style: TextStyle(color: Colors.black, fontFamily: 'bold'),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(
                AppPadding.p24,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddPetDetail(type: 1),
                              ),
                            );
                          },
                          child: circularImageBorderAssetsCustom(
                              image: "assets/images/dog.png",
                              raduis: 10,
                              width: 200,
                              height: 200,
                              bottomMargin: 10,
                              leftMargin: 10,
                              rightMargin: 10,
                              topMargin: 10,
                              boxfit: BoxFit.contain))),
                  const SizedBox(
                    height: AppSize.s30,
                  ),
                  Expanded(
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddPetDetail(type: 2),
                              ),
                            );
                          },
                          child: circularImageBorderAssetsCustom(
                              image: "assets/images/cat.png",
                              raduis: 10,
                              width: 200,
                              height: 200,
                              bottomMargin: 10,
                              leftMargin: 10,
                              rightMargin: 10,
                              topMargin: 10,
                              boxfit: BoxFit.contain))),
                ],
              ),
            ),
          ),
        ));
  }
}
