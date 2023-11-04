import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:squeak/core/main_basic/main_basic.dart';
import 'package:squeak/core/widgets/components/styles.dart';
import 'package:squeak/features/availability/presentation/control/availabilities/availabilities_cubit.dart';
import 'package:squeak/features/availability/presentation/control/availabilities/availabilities_state.dart';
import 'package:squeak/features/availability/presentation/page/Availability/edit_availabilities.dart';
import 'package:squeak/features/layout/domain/entites/clinic/all_clinics_entities.dart';

import '../../../../../core/service/service_locator.dart';
import '../../../../../generated/l10n.dart';
import '../../../domain/entities/availabilities/create_availabilities_entities.dart';

class GetAvailabilities extends StatelessWidget {
  GetAvailabilities({Key? key, required this.clinicId, required this.clinics})
      : super(key: key);
  String clinicId;
  Clinics clinics;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<AvailabilitiesCubit>()..getAvailabilities(clinicId: clinicId),
      child: BlocConsumer<AvailabilitiesCubit, AvailabilitiesState>(
        listener: (context, state) {
          if (state is DeleteAvailabilitiesSuccess) {
            AvailabilitiesCubit.get(context)
                .getAvailabilities(clinicId: clinicId);
          }
        },
        builder: (context, state) {
          var cubit = AvailabilitiesCubit.get(context);
          return Scaffold(
            body: (cubit.availabilitiesEntities != null ||
                    state is GetAvailabilitiesSuccess)
                ? ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => _buildPastContent(
                        cubit.availabilitiesEntities!.availabilitiesDate
                            .availabilities[index],
                        clinics,
                        context),
                    itemCount:
                        cubit.availabilitiesEntities!.availabilitiesDate.count,
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          );
        },
      ),
    );
  }

  Widget _buildPastContent(
      Availabilities availabilities, Clinics clinics, context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                S.of(context).openAt,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                availabilities.startTime,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                isArabic() ? 'اسم الدكتور' : 'Doctor',
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                clinics.admin!.fullName,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey.shade300)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                S.of(context).closeIn,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                availabilities.endTime,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                isArabic() ? 'المكان' : 'Place',
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                clinics.location,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          PopupMenuButton<int>(
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none),
            onCanceled: () {
              Navigator.of(context);
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                onTap: () {
                  AvailabilitiesCubit.get(context).deleteAvailabilities(
                      availabilitiesId: availabilities.id);
                },
                child: Row(
                  children: [
                    Text(
                      isArabic() ? 'حذف' : ' remove',
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      IconlyLight.delete,
                      color: appColorBtn,
                    )
                  ],
                ),
              ),
              PopupMenuItem(
                value: 1,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditAvailability(
                          clinicId: clinicId,
                          availabilities: availabilities,
                        ),
                      ));
                },
                child: Row(
                  children: [
                    Text(
                      S.of(context).edit,
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      IconlyLight.edit,
                      color: Colors.green,
                    )
                  ],
                ),
              ),
            ],
            icon: const Icon(
              Icons.more_vert,
              size: 25,
            ),
            offset: const Offset(0, 20),
          ),
        ],
      ),
    );
  }
}
