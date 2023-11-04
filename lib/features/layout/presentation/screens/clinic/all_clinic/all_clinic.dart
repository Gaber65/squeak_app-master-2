import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squeak/features/layout/presentation/controller/Home_cubit/squeak_state.dart';

import '../../../../../../core/resources/strings_manager.dart';
import '../../../../domain/entites/clinic/all_clinics_entities.dart';
import '../../../controller/Home_cubit/squeak_cubit.dart';

class AllClinic extends StatelessWidget {
  const AllClinic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SqueakCubit, SqueakState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cunit = SqueakCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.allClinic),
          ),
          // body: ListView.separated(
          //   itemBuilder: (context, index) => _buildDetailsContent(cunit.allClinicEntities[index], cunit),
          //   separatorBuilder: (context, index) => const SizedBox(
          //     height: 6,
          //   ),
          //   itemCount: cunit.allClinicEntities.length,
          // ),
        );
      },
    );
  }

  Widget _buildDetailsContent(Clinics entities, SqueakCubit cubit) {
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
                        //       entities.isActive ? Colors.green : Colors.red,
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
                              '${entities.location} , ${entities.city}  , ${entities.address} ',
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
                                  // cubit.postFollowClinics(clinicId: entities.clinicId);
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
