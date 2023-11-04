import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:squeak/core/network/end-points.dart';
import 'package:squeak/features/layout/presentation/controller/Home_cubit/squeak_cubit.dart';
import 'package:squeak/features/layout/presentation/controller/post_cubit/post_cubit.dart';

import 'package:squeak/features/layout/presentation/screens/clinic/clinic_cubit/clinic_cubit.dart';

import '../../../../core/resources/constants_manager.dart';
import '../../../../core/service/service_locator.dart';
import '../../../../core/widgets/components/styles.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entites/clinic/all_clinics_entities.dart';

import 'package:cached_network_image/cached_network_image.dart';

import '../../domain/entites/clinic/speciality_entities.dart';
import '../../layout.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var formKey = GlobalKey<FormState>();

  var searchController = TextEditingController();

  bool isGridView = false;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  bool _isRTL(String text) {
    final rtlRegex = RegExp(r'[\u0600-\u06FF]|[\u0750-\u077F]|[\u0590-\u05FF]');
    return rtlRegex.hasMatch(text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ClinicCubit>(),
      child: BlocConsumer<ClinicCubit, ClinicState>(
        listener: (context, state) {
          if (state is SqueakFollowSuccessState) {
            ClinicCubit.get(context).clinicFollowersEntities = null;
            print(ClinicCubit.get(context).clinicFollowersEntities);
            ClinicCubit.get(context).geMyFollowerClinic();
            SqueakCubit.get(context).changeBottomNav(1);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const LayoutScreen(),
              ),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          var cubit = ClinicCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                S.of(context).search,
                style: FontStyle().textStyle(
                  fontSize: 18,
                ),
              ),
              actions: [
                MaterialButton(
                  minWidth: 20,
                  elevation: 0,
                  onPressed: () {
                    setState(() {
                      isGridView = !isGridView;
                    });
                  },
                  child: Icon(
                    Icons.grid_view_rounded,
                    color: isGridView ? Colors.red.shade900 : Colors.black,
                  ),
                ),
                MaterialButton(
                  minWidth: 20,
                  elevation: 0,
                  onPressed: () {
                    setState(() {
                      isGridView = !isGridView;
                    });
                  },
                  child: Icon(
                    Icons.horizontal_split,
                    color: !isGridView ? Colors.red.shade900 : Colors.black,
                  ),
                ),
              ],
              centerTitle: true,
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTextFormField(cubit, context),
                    if (state is SqueakGetAllClinicLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 80,
                    ),
                    if (state is SqueakGetAllClinicSuccessState &&
                        state.allClinicEntities.data!.clinics.isEmpty)
                      Center(
                        child: Material(
                          color: Colors.transparent,
                          elevation: 9,
                          shadowColor: Colors.amberAccent.shade100,
                          shape: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(120),
                            gapPadding: 0,
                          ),
                          child: const Icon(
                            Icons.info,
                            color: appColorBtn,
                            size: 130,
                          ),
                        ),
                      ),
                    if (state is SqueakGetAllClinicSuccessState && !isGridView)
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return buildDetailsContent(
                                state.allClinicEntities.data!.clinics[index],
                                cubit,
                                state.allClinicEntities.data!.clinics[index]
                                    .speciality.first,
                                context,
                                index);
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 12,
                            );
                          },
                          itemCount:
                              state.allClinicEntities.data!.clinics.length,
                        ),
                      ),
                    if (state is SqueakGetAllClinicSuccessState && isGridView)
                      Expanded(
                        child: GridView.builder(
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            mainAxisExtent: 280.0,
                            maxCrossAxisExtent: 222.0,
                          ),
                          itemBuilder: (context, index) {
                            return buildPaddingWatch(context,
                                state.allClinicEntities!.data!.clinics![index]);
                          },
                          itemCount:
                              state.allClinicEntities!.data!.clinics.length,
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

  TextFormField buildTextFormField(ClinicCubit cubit, BuildContext context) {
    return TextFormField(
      controller: searchController,
      textDirection:
          _isRTL(searchController.text) ? TextDirection.rtl : TextDirection.ltr,
      keyboardType: TextInputType.multiline,
      onChanged: (value) {
        cubit.getAllClinics(clinicName: '%$value%');
      },
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
        hintText: S.of(context).searchFor,
        filled: true,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(
            right: 5.0,
          ),
          child: IconButton(
            padding: const EdgeInsets.all(0.0),
            onPressed: searchController.text.isNotEmpty
                ? () {
                    cubit.getAllClinics(clinicName: searchController.text);
                  }
                : () {},
            icon: const Icon(
              IconlyLight.search,
              color: appColorBtn,
              size: 22.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDetailsContent(Clinics entities, ClinicCubit cubit,
      SpecialitiesData specialitiesData, context, index) {
    return Card(
      elevation: 3,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  entities.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontFamily: 'bold', fontSize: 15),
                ),
                const Spacer(),
                Text(
                  specialitiesData.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontFamily: 'bold', fontSize: 15),
                ),
                const Spacer(),
                CircleAvatar(
                  backgroundImage:
                      CachedNetworkImageProvider('$imageUrl${entities.image}'),
                  radius: 20,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Icon(
                  Icons.location_city,
                  size: 14,
                ),
                const SizedBox(
                  width: 2,
                ),
                Text(
                  '${entities.location} , ${entities.city}  , ${entities.address} ',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12, fontFamily: 'bold'),
                ),
                const Spacer(),
                CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 15,
                  child: IconButton(
                    iconSize: 15,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(S.of(context).followConfirmation),
                            content: Container(
                              width: MediaQuery.of(context).size.width + 100,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        entities.name,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const Spacer(),
                                      const Spacer(),
                                      CircleAvatar(
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                                '$imageUrl${entities.image}'),
                                        radius: 20,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    entities.speciality.first.name,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontFamily: 'bold', fontSize: 15),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        IconlyLight.location,
                                        size: 14,
                                      ),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.sizeOf(context).width /
                                                2,
                                        child: Text(
                                          '${entities.location} , ${entities.address} , ${entities.city} ',
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 12, fontFamily: 'bold'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        IconlyLight.call,
                                        size: 14,
                                      ),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        entities.phone,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                child: TextButton(
                                  child: Text(
                                    S.of(context).followConfirmation,
                                    style: TextStyle(color: Colors.green),
                                  ),
                                  onPressed: () {
                                    cubit.postFollowClinics(
                                        clinicId: entities.clinicId);
                                    // Subscribe the user to the topic "news".
                                    FirebaseMessaging.instance
                                        .subscribeToTopic(entities.clinicId);
                                  },
                                ),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: Text(
                                  S.of(context).cancelFollow,
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.person_add),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPaddingWatch(BuildContext context, Clinics model) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 3,
        surfaceTintColor: Colors.white,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      '$imageUrl${model.image}',
                      width: 161,
                      height: 127,
                      fit: BoxFit.cover,
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 15,
                    child: IconButton(
                      iconSize: 15,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Follow Confirmation"),
                              content: Container(
                                width: MediaQuery.of(context).size.width + 100,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          model.name,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontFamily: 'bold', fontSize: 15),
                                        ),
                                        const Spacer(),
                                        const Spacer(),
                                        CircleAvatar(
                                          backgroundImage:
                                              CachedNetworkImageProvider(
                                                  '$imageUrl${model.image}'),
                                          radius: 20,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      model.speciality.first.name,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontFamily: 'bold', fontSize: 15),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.location_city,
                                          size: 14,
                                        ),
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        SizedBox(
                                          width:
                                              MediaQuery.sizeOf(context).width /
                                                  2,
                                          child: Text(
                                            '${model.location} , ${model.address} , ${model.city} ',
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'bold'),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.phone,
                                          size: 14,
                                        ),
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        const SizedBox(
                                          width: 3,
                                        ),
                                        Text(
                                          model.phone,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 12, fontFamily: 'bold'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                  child: TextButton(
                                    child: const Text(
                                      "Follow",
                                      style: TextStyle(color: Colors.green),
                                    ),
                                    onPressed: () {
                                      ClinicCubit.get(context)
                                          .postFollowClinics(
                                              clinicId: model.clinicId);
                                      // Subscribe the user to the topic "news".
                                      FirebaseMessaging.instance
                                          .subscribeToTopic(model.clinicId);
                                    },
                                  ),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: const Text(
                                    "Cancel",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.person_add),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        model.name,
                        style: FontStyle().textStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        model.speciality.first.name,
                        style: FontStyle().textStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            color: Colors.grey,
                            size: 16,
                          ),
                          Text(
                            model.address!,
                            style: FontStyle().textStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
