import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squeak/features/layout/cubit/squeak_state.dart';

import '../../../core/service/service_locator.dart';
import '../cubit/squeak_cubit.dart';
import '../profile/domain/entities/owner_pets.dart';

class NavScreen extends StatelessWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SqueakCubit, SqueakState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = SqueakCubit.get(context);
        return Scaffold(
          appBar: AppBar()
        );
      },
    );
  }

}
