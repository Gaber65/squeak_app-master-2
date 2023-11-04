
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media_recorder/audio_encoder_type.dart';
import 'package:social_media_recorder/screen/social_media_recorder.dart';
import 'package:squeak/core/main_basic/main_basic.dart';
import 'package:squeak/core/network/helper/helper_cubit.dart';
import 'package:squeak/features/setting/update_profile/presentation/controlls/cubit/beets_type_find_cubit.dart';
import '../../../../core/service/service_locator.dart';

import '../controller/chat_cubit.dart';
import 'package:audioplayers/audioplayers.dart';

class BuildOptionSend extends StatefulWidget {
  BuildOptionSend({
    super.key,
    required this.messageController,
    required this.context,
    required this.toUserId,
    required this.clinicId,
    required this.cubit,
  });
  ChatCubit cubit;
  TextEditingController messageController;
  BuildContext context;
  String toUserId;
  String clinicId;

  @override
  State<BuildOptionSend> createState() => _BuildOptionSendState();
}

class _BuildOptionSendState extends State<BuildOptionSend> {
  String text = '';


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: isArabic() ? TextDirection.ltr : TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.cubit.messageImage != null)
              Stack(
                children: [
                  Image.file(
                    widget.cubit.messageImage!,
                    height: 200,
                  ),
                  IconButton(
                    onPressed: () {
                      widget.cubit.deleteFile();
                    },
                    icon: const CircleAvatar(
                      child: Icon(Icons.close),
                    ),
                  ),
                ],
              ),
            Row(
              children: [
                (text == '')
                    ? InkWell(
                        onTap: () {
                          AudioPlayer player = AudioPlayer();
                          Source alarmAudioPath =
                              AssetSource("Notification.mp3");
                          player.play(alarmAudioPath);
                        },
                        onLongPress: () {
                          AudioPlayer player = AudioPlayer();
                          Source alarmAudioPath =
                              AssetSource("Notification.mp3");
                          player.play(alarmAudioPath);
                        },
                        child: SocialMediaRecorder(
                          sendRequestFunction: (soundFile) {
                            print("the current path is ${soundFile.path}");
                            //
                            widget.cubit.getSound(
                              file: soundFile,
                            );
                          },
                          encode: AudioEncoderType.OPUS,
                          recordIconWhenLockBackGroundColor: Colors.transparent,
                          recordIconBackGroundColor: Colors.transparent,
                          sendButtonIcon: const Icon(
                            IconlyLight.send,
                            color: Colors.white,
                            size: 18,
                          ),
                          backGroundColor: Colors.transparent,
                          recordIcon: const Icon(
                            IconlyLight.voice_2,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      )
                    : CircleAvatar(
                        radius: 22,
                        child: IconButton(
                          onPressed: () {
                            print('-------------------------');
                            print(sl<SharedPreferences>().getString('clintId'));
                            if (widget.messageController.text.isNotEmpty) {
                              if (widget.cubit.messageImage == null) {
                                (sl<SharedPreferences>().getInt('role') == 1)
                                    ? widget.cubit
                                        .sendMessage(
                                        description:
                                            widget.messageController.text,
                                        clinicId: widget.clinicId,
                                      )
                                        .then((value) {
                                        widget.messageController.clear();
                                      })
                                    : widget.cubit
                                        .sendAdminMessage(
                                        description:
                                            widget.messageController.text,
                                        clinicId: widget.clinicId,
                                        toUserId: widget.toUserId,
                                      )
                                        .then((value) {
                                        widget.messageController.clear();
                                      });
                              } else {
                                (sl<SharedPreferences>().getInt('role') == 1)
                                    ? widget.cubit
                                        .sendMessage(
                                        clinicId: widget.clinicId,
                                        description:
                                            widget.messageController.text,
                                        image: HelperCubit().modelImage!.data!,
                                      )
                                        .then((value) {
                                        widget.messageController.clear();
                                        HelperCubit().modelImage = null;
                                      })
                                    : widget.cubit
                                        .sendAdminMessage(
                                        description:
                                            widget.messageController.text,
                                        clinicId: widget.clinicId,
                                        image: HelperCubit().modelImage!.data!,
                                        toUserId: widget.toUserId,
                                      )
                                        .then((value) {
                                        widget.messageController.clear();
                                      });
                              }
                            }
                          },
                          icon: Icon(IconlyLight.send),
                        ),
                      ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                        color: !BreedsTypeCubit.get(context).isDark
                            ? const Color.fromRGBO(242, 242, 242, 1)
                            : ThemeData.dark().scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: widget.messageController,
                        onChanged: (value) {
                          setState(() {
                            text = value;
                          });
                          print(text);
                          print(value);
                        },
                        onFieldSubmitted: (value) {
                          print('-------------------------');
                          print(sl<SharedPreferences>().getString('clintId'));
                          if (widget.messageController.text.isNotEmpty) {
                            if (widget.cubit.messageImage == null) {
                              (sl<SharedPreferences>().getInt('role') == 1)
                                  ? widget.cubit
                                      .sendMessage(
                                      description:
                                          widget.messageController.text,
                                      clinicId: widget.clinicId,
                                    )
                                      .then((value) {
                                      widget.messageController.clear();
                                    })
                                  : widget.cubit
                                      .sendAdminMessage(
                                      description:
                                          widget.messageController.text,
                                      clinicId: widget.clinicId,
                                      toUserId: widget.toUserId,
                                    )
                                      .then((value) {
                                      widget.messageController.clear();
                                    });
                            } else {
                              (sl<SharedPreferences>().getInt('role') == 1)
                                  ? widget.cubit
                                      .sendMessage(
                                      clinicId: widget.clinicId,
                                      description:
                                          widget.messageController.text,
                                      image: HelperCubit().modelImage!.data!,
                                    )
                                      .then((value) {
                                      widget.messageController.clear();
                                      HelperCubit().modelImage = null;
                                    })
                                  : widget.cubit
                                      .sendAdminMessage(
                                      description:
                                          widget.messageController.text,
                                      clinicId: widget.clinicId,
                                      image: HelperCubit().modelImage!.data!,
                                      toUserId: widget.toUserId,
                                    )
                                      .then((value) {
                                      widget.messageController.clear();
                                    });
                            }
                          }
                        },
                        keyboardType: TextInputType.text,
                        keyboardAppearance: Brightness.dark,
                        decoration: InputDecoration(
                          suffixIcon: (widget.cubit.messageImage != null)
                              ? InkWell(
                                  onTap: () {
                                    widget.cubit.sendMessage(
                                      clinicId: widget.clinicId,
                                      description:
                                          widget.messageController.text,
                                      image: HelperCubit.get(context)
                                          .modelImage!
                                          .data!,
                                    );
                                  },
                                  child: const Icon(
                                    IconlyBold.send,
                                    color: Colors.grey,
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    widget.cubit.getMessageImageFromGallery();
                                  },
                                  child: const Icon(
                                    Icons.attach_file,
                                    color: Colors.grey,
                                  ),
                                ),
                          hintText: isArabic()
                              ? '   أكتب رسالتك الآن'
                              : "Write your message now",
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
