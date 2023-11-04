import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squeak/core/network/end-points.dart';
import 'package:squeak/core/widgets/components/styles.dart';
import 'package:squeak/features/setting/update_profile/domain/entities/find_pet_by_owner_id_data.dart';

import 'package:squeak/features/setting/update_profile/presentation/controlls/cubit/add_edit_beets_state.dart';
import 'package:squeak/features/setting/update_profile/presentation/controlls/cubit/beets_type_find_cubit.dart';
import '../../../../../core/main_basic/main_basic.dart';
import '../../../../../core/network/helper/helper_cubit.dart';

import '../../../../../core/service/service_locator.dart';
import '../../../../../core/widgets/elevated_button.dart';
import '../../../../../core/widgets/toast_state.dart';
import '../../../../../generated/l10n.dart';
import '../../../../layout/presentation/controller/Home_cubit/squeak_cubit.dart';
import '../controlls/cubit/add_edit_beets_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'my_pets.dart';

class EditPetDetail extends StatefulWidget {
  PetsData petsData;
  EditPetDetail({
    Key? key,
    required this.petsData,
  }) : super(key: key);

  @override
  _EditPetDetailState createState() => _EditPetDetailState();
}

class _EditPetDetailState extends State<EditPetDetail> {
  int selectID = 1;
  DateTime? currentDate = DateTime.now();
  var namePetController = TextEditingController();
  String? timeDate = DateTime.now().toString().substring(0, 10);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime.now());
    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        currentDate = pickedDate;
        timeDate = "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    timeDate = widget.petsData.birthdate.substring(0, 10);
    namePetController.text = widget.petsData.petName;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AddBeetsCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<HelperCubit>(),
        ),
      ],
      child: BlocConsumer<AddBeetsCubit, AddBeetsState>(
        listener: (context, state) {
          if (state is SqueakPitsImagePickedSuccessState) {
            HelperCubit.get(context).getGlobalImage(
              file: state.file,
              uploadPlace: UploadPlace().petsImages,
            );
          }
          if (state is SqueakEditPetsSuccessState) {
            BreedsTypeCubit.get(context).getOwnerPits();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyPets(),
              ),
            );
          }
        },
        builder: (context, state) {
          var cubit = AddBeetsCubit.get(context);
          return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                centerTitle: true,
                title: Text(
                  S.of(context).edit,
                ),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(10),
                  child:   BlocConsumer<HelperCubit, HelperState>(
                    builder: (context, state) {
                      if (state is ImageHelperLoading) {
                        return LinearProgressIndicator();
                      } else {
                        return SizedBox();
                      }
                    },
                    listener: (context, state) {},
                  ),
                ),
              ),
              body: _buildBody(cubit, context, state));
        },
      ),
    );
  }

  Widget _buildBody(AddBeetsCubit cubit, context, AddBeetsState state) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: cubit.pitsImage == null
                      ? CachedNetworkImageProvider(
                              '$imageUrl${widget.petsData.imageName}')
                          as ImageProvider
                      : FileImage(cubit.pitsImage!),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 15,
                  ),
                  child: CircleAvatar(
                    radius: 15,
                    child: IconButton(
                      icon: const Icon(Icons.camera_alt_outlined),
                      iconSize: 15,
                      onPressed: () {
                        cubit.getPitsImage().then((value) {
                          print(
                              '=============================== response ============================');
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(S.of(context).generalInformation),
          const SizedBox(height: 20),
          TextFormField(
            controller: namePetController,
            focusNode: FocusNode(),
            maxLines: 1,
            decoration: InputDecoration(
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: appColor,
                ),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: appColor,
                ),
              ),
              filled: true,
              hintText: '${S.of(context).petName}',
              suffixIcon: const Icon(
                Icons.pets,
                color: appColorBtn,
                size: 22.0,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(S.of(context).gender),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: buildSelect(isArabic() ? "ذكر" : 'Male', 1)),
              const SizedBox(
                width: 10,
              ),
              Expanded(child: buildSelect(isArabic() ? 'أنثى' : 'Female', 2)),
            ],
          ),
          const SizedBox(height: 8),
          Text(isArabic() ? 'تاريخ الميلاد' : 'date of birth'),
          const SizedBox(height: 20),
          buildSelectDate2(),
          const SizedBox(height: 20),
          ConditionalBuilder(
            condition: state is! SqueakEditPetsLoadingState,
            builder: (context) {
              return MyElevatedButton(
                onPressed: () {
                  cubit.editPets(
                    petName: namePetController.text,
                    gender: selectID,
                    birthdate: currentDate!.toString().substring(0, 10),
                    breedId: widget.petsData.breedId!,
                    petId: widget.petsData.petId,
                    image: HelperCubit.get(context).modelImage == null
                        ? widget.petsData.imageName
                        : HelperCubit.get(context).modelImage!.data!,
                  );
                },
                colors: appColorBtn,
                text: S.of(context).save,
              );
            },
            fallback: (context) {
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildSelect(title, id) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectID = id;
        });
      },
      child: Container(
        height: 50,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          color: selectID == id ? appColorBtn : Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        ),
        child: Text(title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'medium',
                fontSize: 14,
                color: selectID == id ? Colors.white : Colors.black54)),
      ),
    );
  }

  Widget buildSelectDate2() {
    return InkWell(
      onTap: () => _selectDate(context),
      child: TextFormField(
        enabled: false,
        focusNode: FocusNode(),
        maxLines: 1,
        decoration: InputDecoration(
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: appColor,
            ),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: appColor,
            ),
          ),
          disabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: appColor,
            ),
          ),
          filled: true,
          hintText: timeDate!,
          suffixIcon: const Icon(
            Icons.calendar_month,
            color: appColorBtn,
            size: 22.0,
          ),
        ),
      ),
    );
  }

  Future<void> Validation() async {
    if (namePetController.text.isEmpty) {
      showToast(
        text: "name is empty",
        state: ToastState.error,
      );
      return;
    }
    if (AddBeetsCubit.get(context).pitsImage == null) {
      showToast(
        text: "image is empty",
        state: ToastState.error,
      );
      return;
    }
    if (timeDate!.isEmpty) {
      showToast(
        text: "date is empty",
        state: ToastState.error,
      );
      return;
    }
  }
}
