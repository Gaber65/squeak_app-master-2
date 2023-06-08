import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/service/service_locator.dart';
import 'cubit/squeak_cubit.dart';
import 'cubit/squeak_state.dart';
import 'home/create_post.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SqueakCubit>()
        ..getOwnerPits()
        ..getProfile(),
      child: BlocConsumer<SqueakCubit, SqueakState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SqueakCubit.get(context);
          return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.items,
              elevation: 0.0,
              currentIndex: cubit.currentIndex,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                cubit.changeBottomNav(index);
              },
            ),
            body: cubit.screens[cubit.currentIndex],
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              elevation: 7,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreatePost(
                      userImage: cubit.profile!.data!.owner!.imageName!,
                      username: cubit.profile!.data!.owner!.fullname!,
                    ),
                  ),
                );
              },
              child: const Icon(
                Icons.hive,
              ),
            ),
          );
        },
      ),
    );
  }
}
