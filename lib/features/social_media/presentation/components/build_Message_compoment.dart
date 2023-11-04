import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:squeak/core/main_basic/main_basic.dart';
import 'package:squeak/core/network/end-points.dart';
import 'package:voice_message_package/voice_message_package.dart';

import '../../../../core/widgets/components/styles.dart';
import '../../../setting/update_profile/presentation/controlls/cubit/beets_type_find_cubit.dart';
import '../../data/models/message_model.dart';
import '../../domain/entities/create_message_entities.dart';

Widget buildMyMessage(CreateMessageData model, context) {
  return Align(
    alignment: isArabic()
        ? AlignmentDirectional.bottomStart
        : AlignmentDirectional.bottomEnd,
    child: (model.voice == null)
        ? Container(
            decoration: BoxDecoration(
              color: appColorBtn.withOpacity(.3),
              borderRadius: BorderRadiusDirectional.only(
                bottomEnd: isArabic() ? Radius.circular(10) : Radius.zero,
                topEnd: Radius.circular(10),
                bottomStart: !isArabic() ? Radius.circular(10) : Radius.zero,
                topStart: Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Directionality(
                textDirection:
                    isArabic() ? TextDirection.ltr : TextDirection.rtl,
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
                          model.time.substring(11, 19),
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
                    if (model.image != null && model.image != '' )
                      Image.network(
                        '$imageUrl${model.image}',
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                  ],
                ),
              ),
            ),
          )
        : VoiceMessage(
            audioSrc: model.voice,
            played: false, // To show played badge or not.
            me: true, // Set message side.
            onPlay: () {
            },
      meBgColor: appColorBtn,
            // something when voice played.
          ),
  );
}

Widget buildMessage(CreateMessageData model, context) {
  return Align(
    alignment: isArabic()
        ? AlignmentDirectional.bottomEnd
        : AlignmentDirectional.bottomStart,
    child:(model.voice == null) ? Container(
      decoration: BoxDecoration(
        color: !BreedsTypeCubit.get(context).isDark
            ? Color.fromRGBO(242, 242, 242, 1)
            : ThemeData.dark().scaffoldBackgroundColor,
        borderRadius: BorderRadiusDirectional.only(
          bottomEnd: !isArabic() ? Radius.circular(10) : Radius.zero,
          topEnd: Radius.circular(10),
          bottomStart: isArabic() ? Radius.circular(10) : Radius.zero,
          topStart: Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Directionality(
          textDirection: isArabic() ? TextDirection.ltr : TextDirection.rtl,
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
                    model.time.substring(11, 19),
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
              if (model.image != '' && model.image != null)
                Image.network(
                  model.image.toString(),
                  height: 150,
                  fit: BoxFit.cover,
                ),
            ],
          ),
        ),
      ),
    ) : VoiceMessage(
      audioSrc: model.voice,
      played: true, // To show played badge or not.
      me: false, // Set message side.
      onPlay: () {},
      contactBgColor:  !BreedsTypeCubit.get(context).isDark
          ? Color.fromRGBO(242, 242, 242, 1)
          : ThemeData.dark().scaffoldBackgroundColor,
      // something when voice played.
    ),
  );
}
