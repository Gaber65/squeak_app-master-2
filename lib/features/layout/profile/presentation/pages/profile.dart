import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squeak/components/styles.dart';
import 'package:squeak/core/resources/assets_manager.dart';
import 'package:squeak/core/resources/color_manager.dart';
import 'package:squeak/core/resources/strings_manager.dart';
import 'package:squeak/core/resources/values_manager.dart';
import 'package:squeak/core/service/service_locator.dart';
import 'package:squeak/core/widgets/text_btn.dart';
import 'package:squeak/features/layout/cubit/squeak_cubit.dart';
import 'package:squeak/features/layout/cubit/squeak_state.dart';
import 'package:squeak/features/layout/profile/domain/entities/profile.dart';
import 'package:squeak/features/layout/update_profile/presentation/pages/edit_profile.dart';

import '../../../update_profile/presentation/pages/add_pet_detail.dart';
import '../../../update_profile/presentation/pages/my_pets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SqueakCubit, SqueakState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SqueakCubit.get(context);

        return Scaffold(
          backgroundColor: ColorManager.sWhite,
          appBar: AppBar(
            title: const Text('Profile'),
            backgroundColor: ColorManager.sWhite,
            elevation: 4,
            actions: [
              Row(
                children: [
                  const Icon(
                    Icons.edit,
                    color: ColorManager.lightRed,
                  ),
                  MyTextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditProfileScreen(),
                          ),
                        );
                      },
                      text: AppStrings.edit,
                      colors: ColorManager.lightRed),
                ],
              )
            ],
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            )),
            bottom: PreferredSize(
              preferredSize: const Size(double.infinity, 222),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          backgroundImage: CachedNetworkImageProvider(
                            cubit.profile!.data!.owner!.imageName!,
                          ),
                        ),
                        Text(
                          cubit.profile!.data!.owner!.fullname!,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("100"),
                            SizedBox(
                              height: 12,
                            ),
                            Text("Post"),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("10K"),
                            SizedBox(
                              height: 12,
                            ),
                            Text("Followers"),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("64"),
                            SizedBox(
                              height: 12,
                            ),
                            Text("Following"),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(
              AppPadding.p10,
            ),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                        backgroundColor: backgroundColor,
                        child: Icon(
                          Icons.pets,
                          color: ColorManager.lightRed,
                        )),
                    title: const Text(AppStrings.myPets),
                    onTap: () {
                      if (cubit.ownerPetsEntities!.data.breed.isEmpty ||
                          cubit.ownerPetsEntities == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.black.withOpacity(0.6),
                            duration: const Duration(milliseconds: 850),
                            content: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 5,
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
                                            builder: (context) => MyPets(),
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
                                    height:
                                        MediaQuery.of(context).size.height / 5,
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
                                            builder: (context) => MyPets(),
                                          ),
                                        );
                                        print('dog');
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            // cat 1
                            builder: (context) => MyPets(),
                          ),
                        );
                      }
                    },
                    trailing: const Icon(
                      Icons.chevron_right,
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                        backgroundColor: backgroundColor,
                        child: Icon(
                          Icons.favorite_border,
                          color: ColorManager.lightRed,
                        )),
                    title: const Text(
                      AppStrings.myFavorites,
                    ),
                    onTap: () {},
                    trailing: const Icon(
                      Icons.chevron_right,
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                        backgroundColor: backgroundColor,
                        child: Icon(
                          Icons.home_repair_service_outlined,
                          color: ColorManager.lightRed,
                        )),
                    title: const Text(
                      AppStrings.addPetService,
                    ),
                    onTap: () {},
                    trailing: const Icon(
                      Icons.chevron_right,
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                        backgroundColor: backgroundColor,
                        child: Icon(
                          Icons.share,
                          color: ColorManager.lightRed,
                        )),
                    title: const Text(
                      AppStrings.inviteFriends,
                    ),
                    onTap: () {},
                    trailing: const Icon(
                      Icons.chevron_right,
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                        backgroundColor: backgroundColor,
                        child: Icon(
                          Icons.help_outline,
                          color: ColorManager.lightRed,
                        )),
                    title: const Text(
                      AppStrings.help,
                    ),
                    onTap: () {},
                    trailing: const Icon(
                      Icons.chevron_right,
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                        backgroundColor: backgroundColor,
                        child: Icon(
                          Icons.settings_outlined,
                          color: ColorManager.lightRed,
                        )),
                    title: const Text(
                      AppStrings.settings,
                    ),
                    onTap: () {},
                    trailing: const Icon(
                      Icons.chevron_right,
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                        backgroundColor: backgroundColor,
                        child: Icon(
                          Icons.power_settings_new_outlined,
                          color: ColorManager.lightRed,
                        )),
                    title: const Text(
                      AppStrings.signOut,
                    ),
                    onTap: () {},
                    trailing: const Icon(
                      Icons.chevron_right,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
