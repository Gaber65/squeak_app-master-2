import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squeak/components/styles.dart';
import 'package:squeak/core/resources/color_manager.dart';
import 'package:squeak/core/resources/values_manager.dart';
import 'package:squeak/core/widgets/circularImageBorder.dart';
import 'package:squeak/features/layout/update_profile/data/model/find_pet_by_owner_id_model.dart';
import 'package:squeak/features/layout/update_profile/presentation/pages/add_pet_detail.dart';
import 'package:squeak/features/layout/update_profile/presentation/pages/select_type.dart';
import '../../../home/pet_vaccination.dart';
import '../../cubit/beets_type_find_cubit.dart';
import '../../cubit/beets_type_find_states.dart';
import 'edit_pet_detail.dart';

class MyPets extends StatefulWidget {
  const MyPets({Key? key}) : super(key: key);

  @override
  State<MyPets> createState() => _MyPetsState();
}

class _MyPetsState extends State<MyPets> {
  ScrollController controller = ScrollController();
  int status = 0;
  String message = "";
  List<Pets> petsList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _onRefresh();
  }

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
            'My pets',
            style: TextStyle(color: Colors.black, fontFamily: 'bold'),
          ),
        ),
        body: BlocConsumer<BeedstypeCubit, BreedTypeStates>(
          listener: (context, state) {
            if (state is FindPetByOwnerIdSuccessState) {
              status = state.response.status! ? 1 : 2;
              // print(state.response.status.toString());
              // print(state.response.status.);
              // message = state.response.message!;

              if (!state.response.status!) {
                message = state.response.message!;
              }
              if (state.response.status!) {
                petsList.clear();
                petsList.addAll(state.response.data!.pets!.cast<Pets>());
              }
            }

            // TODO: implement listener
          },
          builder: (context, state) {
            if (status == 1) {
              return Center(
                child: Scaffold(
                  floatingActionButton: FloatingActionButton(
                    backgroundColor: appColor,
                    onPressed: () {
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
                                          builder: (context) =>
                                              const AddPetDetail(type: 2),
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
                                          builder: (context) =>
                                              const AddPetDetail(type: 1),
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
                    child: const Icon(Icons.add),
                  ),
                  body: RefreshIndicator(
                      color: Colors.blue,
                      onRefresh: () async {
                        _onRefresh();
                      },
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              controller: controller,
                              itemCount: petsList.length,
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(top: 16),
                              itemBuilder: (context, index) {
                                return _petsItem(petsList[index]);
                              },
                            ),
                          ),
                        ],
                      )),
                ),
              );
            }

            if (status == 2) {
              return Center(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      circularImageBorderAssetsCustom(
                          image: "assets/images/selectimg.png",
                          raduis: 10,
                          width: 200,
                          height: 100,
                          bottomMargin: 10,
                          leftMargin: 10,
                          rightMargin: 10,
                          topMargin: 10,
                          boxfit: BoxFit.contain),
                      const SizedBox(
                        height: AppSize.s30,
                      ),
                      Text(
                        "$message",
                        style: const TextStyle(
                            fontFamily: 'medium',
                            fontSize: 20,
                            color: ColorManager.blue),
                      ),
                      const SizedBox(
                        height: AppSize.s30,
                      ),
                      _buildSelect1("add a pets", () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SelectType(),
                          ),
                        );
                      }, Colors.transparent, Colors.black54)
                    ],
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }

  Widget _petsItem(Pets petsItem) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditPetDetail(petId: petsItem.petId!),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 16),
            height: 110,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        height: 80,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8)),
                        child: Card(
                          elevation: 15,
                          shadowColor: Colors.black.withOpacity(.20),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: ColorManager.black_45, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              petsItem.imageName!,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(petsItem.petName!,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'bold',
                                  color: Colors.black)),
                          const SizedBox(
                            height: AppSize.s10,
                          ),
                          Flexible(
                              child: Text(petsItem.breedName!,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'medium',
                                      color: Colors.black))),
                          const SizedBox(
                            height: AppSize.s10,
                          ),
                          Flexible(
                              child: Text(petsItem.birthdate!,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'medium',
                                      color: Colors.black))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: AppSize.s20, right: AppSize.s20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: _buildSelect(
                        'History', () {}, Colors.transparent, Colors.black54)),
                const SizedBox(
                  width: AppSize.s20,
                ),
                Expanded(
                  flex: 1,
                  child: _buildSelect('add new record', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PetVaccination(
                            gender: petsItem.gender!,
                            pitName: petsItem.petName!),
                      ),
                    );
                  }, appColorBtn, Colors.white),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSelect(
      String titel, Function()? onTap, Color color, Color textColor) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Text(titel,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'medium', fontSize: 14, color: textColor)),
      ),
    );
  }

  Widget _buildSelect1(
      String titel, Function() onTap, Color color, Color textColor) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(50)),
        ),
        child: Text(titel,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'medium', fontSize: 20, color: textColor)),
      ),
    );
  }

  void _onRefresh() async {
    BeedstypeCubit.get(context).FindPetByOwnerId();
  }
}
