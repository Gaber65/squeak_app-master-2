import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mostakbal/core/const/components/elevated_button.dart';
import 'package:mostakbal/core/const/const.dart';
import 'package:mostakbal/core/models/auth_model/login_model.dart';
import 'package:iconly/iconly.dart';
import '../../cubit/chat-cubit.dart';
import '../../cubit/chat-states.dart';
import '../../models/chat_model.dart';

class ChatDetailsAdmin extends StatelessWidget {
  ChatDetailsAdmin({super.key, required this.model});
  UserDataModel model;
  var now = DateTime.now();
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit()
        ..getAllUserData()
        ..getMessage(receiveId: model!.uId!),
      child: BlocConsumer<ChatCubit, ChatStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ChatCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    model!.fullName,
                    style: FontStyle().textStyle(
                      fontColor: ColorStyle().primaryColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'نشط الان',
                    style: FontStyle().textStyle(
                      fontColor: ColorStyle().secondColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    IconlyLight.call,
                    color: ColorStyle().primaryColor,
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (cubit.uId == cubit.messages[index].senderId) {
                      return myMessages(cubit.messages[index], context);
                    } else {
                      return senderMessage(cubit.messages[index], context);
                    }
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                  itemCount: cubit.messages.length),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (cubit.chatImage != null)
                    Stack(
                      children: [
                        Expanded(
                          child: Image.file(
                            cubit.chatImage!,
                            height: 200,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            cubit.removePostImage();
                          },
                          icon: const CircleAvatar(
                            child: Icon(Icons.close),
                          ),
                        ),
                      ],
                    ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(242, 242, 242, 1),
                              borderRadius: BorderRadius.circular(8)),
                          child: TextFormField(
                            cursorColor: Colors.blue,
                            controller: textController,
                            onFieldSubmitted: (value) {
                              if (cubit.chatImage == null) {
                                cubit.sendMessage(
                                  text: textController.text,
                                  dateTime: now.toString(),
                                  receiverId: model.uId,
                                );
                              } else {
                                cubit.sendChatImage(
                                  text: textController.text,
                                  dateTime: now.toString(),
                                  receiverId: model.uId,
                                );
                              }
                              cubit.removePostImage();
                              textController.clear();
                            },
                            keyboardType: TextInputType.text,
                            keyboardAppearance: Brightness.dark,
                            decoration: InputDecoration(
                              hintText: '   أكتب رسالتك الآن',
                              hintStyle: FontStyle().textStyle(
                                  fontSize: 16,
                                  fontColor: Colors.grey,
                                  fontWeight: FontWeight.w500),
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  cubit.getChatImage();
                                },
                                icon: const Icon(
                                  Icons.attach_file,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: ColorStyle().primaryColor,
                        child: const Icon(
                          IconlyLight.voice_2,
                          color: Colors.white,
                        ),
                      ),
                    ],
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

Widget myMessages(MessageModel model, context) {
  return Align(
    alignment: AlignmentDirectional.bottomStart,
    child: Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(229, 244, 255, 1),
        borderRadius: BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(10),
          topEnd: Radius.circular(10),
          topStart: Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.done_all,
                  size: 12,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  '${model.time.toString().substring(11, 16)}',
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    '${model.message}',
                    textAlign: TextAlign.start,

                  ),
                ),
              ],
            ),
            if (model.image != '')
              Image.network(
                model.image.toString(),
                height: 150,
                fit: BoxFit.cover,
              ),
          ],
        ),
      ),
    ),
  );
}

Widget senderMessage(MessageModel model, context) {
  return Align(
    alignment: AlignmentDirectional.bottomEnd,
    child: Container(
      decoration: const BoxDecoration(
        color: const Color.fromRGBO(242, 242, 242, 1),
        borderRadius: BorderRadiusDirectional.only(
          bottomStart: Radius.circular(10),
          topEnd: Radius.circular(10),
          topStart: Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    '${model.message}',
                    textAlign: TextAlign.end,
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  '${model.time.toString().substring(11, 16)}',
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(
                  width: 4,
                ),
                const Icon(
                  Icons.done_all,
                  size: 12,
                ),
              ],
            ),
            if (model.image != '')
              Image.network(
                model.image.toString(),
                height: 150,
                fit: BoxFit.cover,
              ),
          ],
        ),
      ),
    ),
  );
}
