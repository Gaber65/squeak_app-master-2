import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squeak/core/main_basic/main_basic.dart';
import 'package:squeak/features/availability/presentation/control/availabilities/availabilities_state.dart';
import 'package:squeak/features/setting/update_profile/presentation/controlls/cubit/beets_type_find_cubit.dart';
import 'package:squeak/features/setting/update_profile/presentation/controlls/cubit/beets_type_find_states.dart';

import '../../../../core/service/service_locator.dart';
import '../../../../generated/l10n.dart';
import '../../../availability/domain/entities/availabilities/create_availabilities_entities.dart';
import '../../../availability/presentation/control/availabilities/availabilities_cubit.dart';
import '../../../availability/presentation/page/appointments/add_appointments.dart';
import '../../domain/entites/clinic/all_clinics_entities.dart';

class GetVUser extends StatelessWidget {
  GetVUser({Key? key, required this.clinics}) : super(key: key);
  Clinics clinics;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AvailabilitiesCubit>()
        ..getAvailabilities(clinicId: clinics.clinicId),
      child: BlocConsumer<AvailabilitiesCubit, AvailabilitiesState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return (state is GetAvailabilitiesSuccess)
              ? Expanded(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => buildPadding(
                        AvailabilitiesCubit.get(context)
                            .availabilitiesEntities!
                            .availabilitiesDate
                            .availabilities[index],
                        context),
                    itemCount: AvailabilitiesCubit.get(context)
                        .availabilitiesEntities!
                        .availabilitiesDate
                        .count,
                  ),
                )
              : const LinearProgressIndicator();
        },
      ),
    );
  }

  Padding buildPadding(Availabilities availabilities, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
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
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            S.of(context).openAt,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            availabilities.startTime,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            isArabic() ? "الدكتور" : "Doctor",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            clinics.admin!.fullName,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: Colors.grey.shade300)),
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
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            S.of(context).closeIn,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            availabilities.endTime,
                            overflow: TextOverflow.ellipsis,
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
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            isArabic() ? 'المكان' : 'Place',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            clinics.location,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return buildAlertDialog(context, availabilities);
                        },
                      );
                    },
                    child: Text(S.of(context).booking),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  AlertDialog buildAlertDialog(
      BuildContext context, Availabilities availabilities) {
    return AlertDialog(
      backgroundColor:
          !BreedsTypeCubit.get(context).isDark ? Colors.white : Colors.black,
      title: Row(
        children: [
           Text(S.of(context).addAppointment),
          const Spacer(),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            icon: const Icon(
              Icons.close,
            ),
          )
        ],
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width + 200,
        child: AddAppointments(
          doctorId: clinics!.admin!.id,
          availabilityId: availabilities.id,
          numOfDays: availabilities.dayOfWeek,
        ),
      ),
    );
  }
}
