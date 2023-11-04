import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squeak/core/widgets/components/styles.dart';
import 'package:squeak/features/availability/presentation/control/availabilities/availabilities_cubit.dart';
import 'package:squeak/features/availability/presentation/control/availabilities/availabilities_state.dart';
import 'package:squeak/features/layout/layout.dart';
import 'package:squeak/features/layout/presentation/components/get_av_widget.dart';
import 'package:squeak/features/layout/presentation/controller/Home_cubit/squeak_cubit.dart';
import 'package:squeak/features/layout/presentation/screens/clinic/clinic_cubit/clinic_cubit.dart';

import '../../../../../core/network/end-points.dart';
import '../../../../../core/service/service_locator.dart';
import '../../../../availability/presentation/page/appointments/add_appointments.dart';
import '../../../../availability/domain/entities/availabilities/create_availabilities_entities.dart';
import '../../../../availability/presentation/components/whatsAppBar.dart';
import '../../../../social_media/presentation/screens/chat.dart';
import '../../../domain/entites/clinic/all_clinics_entities.dart';

class SpecialistInfoPage extends StatelessWidget {
  SpecialistInfoPage(
      {Key? key, required this.nameDoctor, required this.clinics})
      : super(key: key);
  String nameDoctor;
  static const String pageId = 'specialistInfoPage';

  Clinics clinics;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return sl<ClinicCubit>();
          },
        ),
        BlocProvider(
          create: (context) {
            return sl<AvailabilitiesCubit>()
              ..getAvailabilities(clinicId: clinics!.clinicId);
          },
        ),
      ],
      child: BlocConsumer<ClinicCubit, ClinicState>(
        listener: (context, state) {
          if (state is SqueakFollowSuccessState) {
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
          return Scaffold(
            body: SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                    delegate: WhatsappAppbar(
                        clinics: clinics,
                        clinicId: clinics!.clinicId,
                        screenWidth: MediaQuery.of(context).size.width,
                        clinicName: clinics!.name,
                        image: clinics!.image,
                        context: context),
                    pinned: true,
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        PhoneAndName(
                          clinicName: clinics!.name,
                          speciality: clinics!.speciality.first.name,
                          phone: clinics.phone,
                        ),
                        ProfileIconButtons(
                          clinicId: clinics!.clinicId,
                          clinics: clinics,
                        )
                      ],
                    ),
                  ),
                  WhatsappProfileBody(
                    list: Column(
                      children: [
                        GetVUser(clinics: clinics!),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
