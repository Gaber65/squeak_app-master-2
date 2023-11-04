import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:shimmer/shimmer.dart';
import 'package:squeak/core/widgets/components/styles.dart';
import 'package:squeak/core/resources/color_manager.dart';
import 'package:squeak/core/resources/values_manager.dart';
import 'package:squeak/features/layout/presentation/controller/Home_cubit/squeak_cubit.dart';
import 'package:squeak/features/layout/presentation/screens/vaccination/pet_vaccination.dart';
import 'package:squeak/features/setting/update_profile/presentation/pages/add_pet_detail.dart';
import 'package:squeak/features/setting/update_profile/presentation/pages/edit_pet_detail.dart';
import 'package:squeak/generated/l10n.dart';

import '../../../../../core/main_basic/main_basic.dart';
import '../../../../../core/network/end-points.dart';
import '../../../../../core/service/service_locator.dart';
import '../../../../layout/layout.dart';
import '../../domain/entities/find_pet_by_owner_id_data.dart';
import '../controlls/cubit/beets_type_find_cubit.dart';
import '../controlls/cubit/beets_type_find_states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class MyPets extends StatelessWidget {
  const MyPets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<BreedsTypeCubit>()..getOwnerPits(),
      child: BlocConsumer<BreedsTypeCubit, BreedTypeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LayoutScreen(),
                    ),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
              title: Text(
                S.of(context).myPets,
              ),
            ),
            floatingActionButton: (state is SqueakGetOwnerPitsSuccessState &&
                    state.ownerPetsEntities.data!.isNotEmpty)
                ? FloatingActionButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        buildSnackBar(context),
                      );
                    },
                    child: const Icon(Icons.add),
                  )
                : null,
            body: Column(
              mainAxisAlignment: (state is SqueakGetOwnerPitsSuccessState &&
                      state.ownerPetsEntities.data!.isEmpty)
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.center,
              children: [
                if (state is SqueakGetOwnerPitsSuccessState &&
                    state.ownerPetsEntities.data!.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return buildDetailsContent(
                            state.ownerPetsEntities.data![index], context);
                      },
                      itemCount: state.ownerPetsEntities.data!.length,
                    ),
                  ),
                if (state is SqueakGetOwnerPitsSuccessState &&
                    state.ownerPetsEntities.data!.isEmpty)
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              Image.asset("assets/images/selectimg.png").image,
                          radius: 70,
                        ),
                        const SizedBox(
                          height: AppSize.s30,
                        ),
                        const SizedBox(
                          height: AppSize.s30,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              buildSnackBar(context),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.red,
                            backgroundColor:
                                Colors.red.shade100.withOpacity(.4),
                            elevation: 0,
                            shape: (RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            )),
                          ),
                          child: Text(isArabic()
                              ? S.of(context).addPet
                              : 'Add New Pet'),
                        ),
                      ],
                    ),
                  ),
                if (state is SqueakGetOwnerPitsLoadingState)
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return FadeIn(
                          duration: const Duration(milliseconds: 400),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade600,
                            child: Card(
                              elevation: 3,
                              shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: const BorderSide(
                                  style: BorderStyle.none,
                                ),
                              ),
                              child: SizedBox(
                                height: 150,
                                width: double.infinity,
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: 10,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  SnackBar buildSnackBar(BuildContext context) {
    return SnackBar(
      backgroundColor: Colors.black.withOpacity(0.6),
      duration: const Duration(seconds: 5),
      content: Row(
        children: [
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height / 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                      'https://img.freepik.com/premium-vector/animal-origami-vector_53876-16726.jpg?w=826'),
                ),
              ),
              child: MaterialButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      // cat 1
                      builder: (context) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        return AddPetDetail(
                          // type: 2,
                          dropdownValueSpecies: 'Cat',
                          pathImage:
                              'https://img.freepik.com/premium-vector/animal-origami-vector_53876-16726.jpg?w=826',
                          species: '2b40cb3c-02d2-4a09-9958-0e60806471c5',
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height / 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                      'https://img.freepik.com/premium-vector/animal-origami-vector_53876-16732.jpg?w=826'),
                ),
              ),
              child: MaterialButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        //dog  1
                        builder: (context) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      return AddPetDetail(
                        dropdownValueSpecies: 'Dog',
                        // type: 1,
                        pathImage:
                            'https://img.freepik.com/premium-vector/animal-origami-vector_53876-16732.jpg?w=826',
                        species: '5fb7097c-335c-4d07-b4fd-000004e2d28c',
                      );
                    }),
                  );
                  print('dog');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDetailsContent(PetsData pet, context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditPetDetail(
              petsData: pet,
            ),
          ),
        );
      },
      child: Card(
        elevation: 3,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            style: BorderStyle.none,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${pet!.petName}',
                        style: FontStyle().textStyle(),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        pet.birthdate.substring(0, 10),
                      ),
                    ],
                  ),
                  const Spacer(),
                  CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                      '$imageUrl${pet.imageName}',
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PetVaccination(
                              gender: pet.gender,
                              petName: pet.petName,
                              petId: pet.petId,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.green,
                        backgroundColor: Colors.green.shade100.withOpacity(.4),
                        elevation: 0,
                        shape: (RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        )),
                      ),
                      child: Text(
                        !isArabic() ? 'Add Service' : 'اضافة الخدمات',
                        overflow: TextOverflow.ellipsis,
                        style: FontStyle().textStyle(fontSize: 14),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                isArabic()
                                    ? 'تأكيد الحذف'
                                    : "Delete Confirmation",
                                style: FontStyle().textStyle(fontSize: 14),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "${isArabic() ? 'هل أنت متأكد أنك تريد حذف' : 'Are you sure you want to delete '} ${pet!.petName}",
                                    style: FontStyle().textStyle(fontSize: 14),
                                  ),
                                  const CircleAvatar(
                                    backgroundImage: CachedNetworkImageProvider(
                                        'https://img.freepik.com/premium-vector/sad-dog_161669-74.jpg?size=626&ext=jpg&uid=R78903714&ga=GA1.2.131510781.1692744483&semt=ais'),
                                    radius: 60,
                                  ),
                                ],
                              ),
                              actions: <Widget>[
                                SizedBox(
                                  width: 150,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.green,
                                      backgroundColor:
                                          Colors.green.shade100.withOpacity(.4),
                                      elevation: 0,
                                      shape: (RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      )),
                                    ),
                                    child: Text(
                                      isArabic() ? 'لا' : 'Back',
                                      style:
                                          FontStyle().textStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 150,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      await BreedsTypeCubit.get(context)
                                          .deletePet(petId: pet.petId)
                                          .then(
                                        (value) {
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return const MyPets();
                                              },
                                            ),
                                            (route) => false,
                                          );
                                        },
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.red,
                                      backgroundColor:
                                          Colors.red.shade100.withOpacity(.4),
                                      elevation: 0,
                                      shape: (RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      )),
                                    ),
                                    child: Text(
                                      isArabic() ? 'نعم' : 'Confirm',
                                      style:
                                          FontStyle().textStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.red,
                        backgroundColor: Colors.red.shade100.withOpacity(.4),
                        elevation: 0,
                        shape: (RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        )),
                      ),
                      child: Text(
                        isArabic() ? 'حذف' : 'Delete',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
