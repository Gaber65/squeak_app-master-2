import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squeak/features/layout/presentation/screens/clinic/clinic_cubit/clinic_cubit.dart';

class TimeScreen extends StatelessWidget {
  const TimeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClinicCubit, ClinicState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Center(
          child: Text(
            'Time',
            style: Theme
                .of(context)
                .textTheme
                .titleLarge,
          ),
        );
      },
    );
  }
}