import 'package:flutter/material.dart.';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mostakbal/core/const/const.dart';
import 'package:mostakbal/feature/profile-feature/chat-feature/cubit/chat-cubit.dart';
import 'package:mostakbal/feature/profile-feature/chat-feature/cubit/chat-states.dart';

import '../../../../../core/models/auth_model/login_model.dart';
import '../admin/chat-details-admin.dart';

class AllUserScreen extends StatelessWidget {
  const AllUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit()..getAllUserData(),
      child: BlocConsumer<ChatCubit, ChatStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = ChatCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'كل عملاء الشركة',
                style: FontStyle().textStyle(),
              ),
            ),
            body: ListView.builder(
              itemBuilder: (context, index) {
                return buildAllItemUser(
                  context: context,
                  model: cubit.allUser[index],
                );
              },
              itemCount: cubit.allUser.length,
            ),
          );
        },
      ),
    );
  }

  Widget buildAllItemUser({
    required BuildContext context,
    required UserDataModel model,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ChatDetailsAdmin(
                  model: model!,
                );
              },
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(242, 242, 242, 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 35.0,
                backgroundImage: NetworkImage(model!.image),
              ),
              const Spacer(),
              Text(model.fullName, style: FontStyle().textStyle(),),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
