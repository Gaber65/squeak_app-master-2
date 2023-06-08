import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squeak/components/styles.dart';
import 'package:squeak/core/resources/assets_manager.dart';
import 'package:squeak/core/resources/color_manager.dart';
import 'package:squeak/core/resources/strings_manager.dart';
import 'package:squeak/core/resources/values_manager.dart';
import 'package:squeak/features/layout/cubit/squeak_cubit.dart';
import 'package:squeak/features/layout/cubit/squeak_state.dart';
import 'package:squeak/features/layout/profile/domain/entities/profile.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../update_profile/presentation/pages/add_pet_detail.dart';

class BuildProfile extends StatelessWidget {
  final Profile profile;
  const BuildProfile({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SqueakCubit, SqueakState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SqueakCubit.get(context);
        cubit.fullNameController.text = profile.data!.owner!.fullname!;
        cubit.addressController.text = profile.data!.owner!.addresss!;
        return Padding(
          padding: const EdgeInsets.all(
            AppPadding.p10,
          ),
          child: SingleChildScrollView(
            child: SizedBox(
              height: AppSize.s700,
              child: Column(
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      const SizedBox(
                        width: double.infinity,
                        height: AppSize.s250,
                        child: Card(
                          elevation: AppSize.s10,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: AppSize.s80,
                        ),
                        child: CircleAvatar(
                          radius: AppSize.s70,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          backgroundImage: const AssetImage(
                            ImageAssets.pet,
                          ),
                        ),
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: AppSize.s40),
                            child: Text(
                              profile.data!.owner!.fullname!,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: AppSize.s15),
                            child: SizedBox(
                              width: 200,
                              child: Text(
                                profile.data!.owner!.addresss!,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  color: ColorManager.gGrey.withOpacity(
                                    .8,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  ListView(
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
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.black.withOpacity(0.6),
                                duration: const Duration(milliseconds: 700),
                                content: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: MediaQuery.of(context).size.height/5,
                                        decoration:  BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          image: const DecorationImage(
                                            fit: BoxFit.cover,
                                            image: CachedNetworkImageProvider('https://img.freepik.com/premium-vector/animal-origami-vector_53876-16726.jpg?w=826'),
                                          ),
                                        ),
                                        child: MaterialButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                // cat 1
                                                builder: (context) =>  AddPetDetail(type: 2),
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
                                        height: MediaQuery.of(context).size.height/5,
                                        decoration:  BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          image: const DecorationImage(
                                            fit: BoxFit.cover,
                                            image: CachedNetworkImageProvider('https://img.freepik.com/premium-vector/animal-origami-vector_53876-16732.jpg?w=826'),
                                          ),
                                        ),
                                        child: MaterialButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                //dog  1
                                                builder: (context) =>  AddPetDetail(type: 1),
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
                          onTap: () {
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
