import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squeak/features/layout/presentation/controller/Home_cubit/squeak_state.dart';
import 'package:squeak/features/social_media/presentation/components/user_components.dart';

import '../../../../core/network/end-points.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/service/service_locator.dart';
import '../../../layout/domain/entites/clinic/all_clinics_entities.dart';
import '../../../layout/presentation/controller/Home_cubit/squeak_cubit.dart';
import '../controller/chat_cubit.dart';

class FollowingPage extends StatelessWidget {
  FollowingPage({super.key});

  String name = 'Vivian Richardson';
  String image =
      'https://img.freepik.com/free-photo/doctor-presenting-something-isolated-white-background_1368-5834.jpg?w=826&t=st=1686647804~exp=1686648404~hmac=139c2b13a7fbb05a24e42e0444fa6b2fa146de61e1741eb9d5af1af1e77269ea';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SqueakCubit, SqueakState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = SqueakCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title:  Text(AppStrings.allClinicFollow),
          ),
          // body: ListView.separated(
          //   itemBuilder: (context, index) =>
          //       buildDetailsContent(cubit.followClinic[index], cubit),
          //   separatorBuilder: (context, index) =>
          //   const SizedBox(
          //     height: 6,
          //   ),
          //   itemCount: cubit.followClinic.length,
          // ),
        );
      },
    );
  }

  Widget buildDetailsContent(Clinics entities, SqueakCubit cubit) {
    return Card(
      elevation: 3,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // CircleAvatar(
                        //   backgroundColor:
                        //   entities.isActive ? Colors.green : Colors.red,
                        //   radius: 6,
                        // ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          entities.name,
                          overflow: TextOverflow.ellipsis,
                          style:
                          const TextStyle(fontFamily: 'bold', fontSize: 15),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
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
                              '${entities.location} , ${entities
                                  .city}  , ${entities.address} ',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 12, fontFamily: 'bold'),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.green,
                              child: IconButton(
                                onPressed: () {
                                  // cubit.postFollowClinics(
                                  //     clinicId: entities.clinicId);
                                },
                                icon: const Icon(Icons.person_add),
                              ),
                            ),
                            const SizedBox(
                              width: 14,
                            ),
                            // CircleAvatar(
                            //   backgroundColor: Colors.red,
                            //   child: IconButton(
                            //     onPressed: () {},
                            //     icon: const Icon(Icons.person_add_disabled),
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
