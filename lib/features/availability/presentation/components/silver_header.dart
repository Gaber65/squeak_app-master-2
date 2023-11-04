import 'package:flutter/material.dart';
import 'package:squeak/features/availability/presentation/components/whatsAppBar.dart';

import '../../../layout/presentation/screens/clinic/follow_clinic/clinic_follower.dart';

class SliverHeader extends StatelessWidget {
  const SliverHeader({
    super.key,
    required this.widget,
  });

  final ClinicFollower widget;


  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: WhatsappAppbar(
        clinics: widget.clinics,
        clinicId: widget.clinicId,
        screenWidth: MediaQuery.of(context).size.width,
        clinicName: widget.clinics.name,
        image: widget.clinics.image,
        context: context
      ),
      pinned: true,
    );
  }
}
