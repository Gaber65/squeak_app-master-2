import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:squeak/features/availability/presentation/components/whatsAppBar.dart';

import '../../../layout/presentation/screens/clinic/clinic_cubit/clinic_cubit.dart';
import '../../../layout/presentation/screens/clinic/follow_clinic/clinic_follower.dart';
import '../../../setting/update_profile/presentation/controlls/cubit/beets_type_find_cubit.dart';

class SliverToBox extends StatelessWidget {
  const SliverToBox({
    super.key,
    required this.widget,
    required this.cubit,
  });

  final ClinicFollower widget;
  final ClinicCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          PhoneAndName(
            clinicName: widget.clinics.name,
            speciality: widget.clinics.speciality.first.name,
            phone: widget.clinics.phone,
          ),
          BottomNavigationBar(
            elevation: 0,
            currentIndex: cubit.currentIndex,
            backgroundColor: Colors.transparent,
            onTap: (value) {
              cubit.changeBottomNav(value);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(IconlyLight.user), label: ''),
              BottomNavigationBarItem(
                  icon: Icon(IconlyLight.time_circle), label: ''),
            ],
          ),
        ],
      ),
    );
  }
}
