import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart.';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mostakbal/core/const/const.dart';

import '../../cubit/chat-cubit.dart';
import '../../cubit/chat-states.dart';
import 'chat-details-admin.dart';

class AdminChatScreen extends StatelessWidget {
  const AdminChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit()..getAdminData(),
      child: BlocConsumer<ChatCubit, ChatStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ChatCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: (state is GetAllUserSuccessHomePageStates)
                ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ChatDetailsAdmin(
                                model: cubit.allAdmin!,
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
                              backgroundImage: NetworkImage(
                                  cubit.allAdmin!.image.toString()),
                            ),
                            Spacer(),
                            Text(cubit.allAdmin!.fullName,
                                style: FontStyle().textStyle()),
                            Spacer(),
                          ],
                        ),
                      ),
                  ),
                )
                : const Column(),
          );
        },
      ),
    );
  }
}
