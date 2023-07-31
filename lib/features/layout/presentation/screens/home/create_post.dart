import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squeak/core/widgets/components/styles.dart';
import 'package:squeak/features/layout/presentation/controller/Home_cubit/squeak_cubit.dart';
import 'package:squeak/features/layout/presentation/controller/Home_cubit/squeak_state.dart';

import '../../../../../core/utils/translation/applocal.dart';
import '../../../../../core/widgets/video_detail.dart';
import '../../../../setting/update_profile/presentation/controlls/cubit/beets_type_find_cubit.dart';

class CreatePost extends StatefulWidget {
  CreatePost({Key? key, required this.userImage, required this.username})
      : super(key: key);
  String userImage;
  String username;

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  String dropdownValueBreed = 'Public';
  String dropdownValue = 'Type';
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SqueakCubit, SqueakState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = SqueakCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(
              "${getLang(context, "createPost")}",
            ),
            actions: [
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Publish',
                ),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size(double.infinity, 70),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(widget.userImage),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 150,
                        child: Text(
                          widget.username,
                        ),
                      ),
                      Row(
                        children: [
                          buildDropDownSelectC(),
                          const SizedBox(
                            width: 20,
                          ),
                          buildDropDown(),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textField(
                    // maxLines: 4,
                    // onSubmitted: (value) {},
                    // keyboardType: TextInputType.multiline,
                    // style: const TextStyle(height: 2, fontSize: 12),
                    // decoration: InputDecoration(
                    //   label: Text(
                    //     "${getLang(context, "labelPost")}",
                    //     style: const TextStyle(fontSize: 22),
                    //   ),
                    //   alignLabelWithHint: true,
                    // ),
                    "${getLang(context, "labelPost")}",
                    null,
                    TextEditingController(),
                    'Please add Email',
                    obscureText: false,
                    maxLines: 8),
                const SizedBox(
                  height: 20.0,
                ),
                if (cubit.postImage != null || cubit.postCamera != null)
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 5.0,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    child: Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              4.0,
                            ),
                            image: DecorationImage(
                              image: FileImage(
                                  cubit.postImage ?? cubit.postCamera!),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const CircleAvatar(
                            radius: 20.0,
                            child: Icon(
                              Icons.close,
                              size: 16.0,
                            ),
                          ),
                          onPressed: () {
                            cubit.removePostImage();
                          },
                        ),
                      ],
                    ),
                  ),
                if (cubit.postVideo != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        height: 200, child: VideoApp(video: cubit.postVideo!)),
                  ),
                if (cubit.postVideo != null)
                  TextButton(
                    onPressed: () {
                      cubit.removePostImage();
                    },
                    child: const Text(
                      'Remove video',
                    ),
                  ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        scaffoldKey.currentState!
                            .showBottomSheet(
                              elevation: 7,
                              (context) => SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height / 3,
                                child: Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        cubit.changeBottomSheetShow(
                                          isShow: false,
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down_sharp,
                                      ),
                                    ),
                                    const Spacer(),
                                    MaterialButton(
                                      onPressed: () {
                                        cubit.getPostVideo();
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.movie_creation_outlined,
                                            color: BreedsTypeCubit.get(context)
                                                    .isDark
                                                ? Colors.white
                                                : Colors.red,
                                          ),
                                          const SizedBox(
                                            width: 40,
                                          ),
                                          const Text("/Add Video"),
                                          const Spacer(),
                                          const Spacer(),
                                        ],
                                      ),
                                    ),
                                    const Divider(),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                        cubit.getPostCamera();
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.camera,
                                            color: BreedsTypeCubit.get(context)
                                                    .isDark
                                                ? Colors.white
                                                : Colors.red,
                                          ),
                                          const SizedBox(
                                            width: 40,
                                          ),
                                          const Text("/Take camera"),
                                          const Spacer(),
                                        ],
                                      ),
                                    ),
                                    const Divider(),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                        cubit.getPostImage();
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.photo_library_outlined,
                                            color: BreedsTypeCubit.get(context)
                                                    .isDark
                                                ? Colors.white
                                                : Colors.green,
                                          ),
                                          const SizedBox(
                                            width: 40,
                                          ),
                                          const Text("/Take Pets"),
                                          const Spacer(),
                                          const Spacer(),
                                        ],
                                      ),
                                    ),
                                    const Divider(),
                                  ],
                                ),
                              ),
                            )
                            .closed
                            .then((value) {
                          cubit.changeBottomSheetShow(isShow: false);
                        });
                      },
                      icon: const Icon(
                        Icons.keyboard_arrow_up,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildDropDownSelectC() {
    return DropdownButton<String>(
      underline: const SizedBox(),
      iconSize: 18,
      iconEnabledColor:
          BreedsTypeCubit.get(context).isDark ? Colors.white : Colors.black,
      value: dropdownValueBreed,
      onChanged: (newValue) {
        setState(() {
          dropdownValueBreed = newValue!;
        });
      },
      style: TextStyle(
        color: BreedsTypeCubit.get(context).isDark
            ?  Colors.white
            : Colors.black,
      ),
      items: [
        'Public',
        'Sheikh',
        'Fifth ',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: const TextStyle(color: Colors.black, fontSize: 14),

          ),
        );
      }).toList(),
    );
  }

  Widget buildDropDown() {
    return DropdownButton<String>(
      underline: const SizedBox(),
      iconSize: 18,
      iconEnabledColor: BreedsTypeCubit.get(context).isDark
        ?  Colors.white
        : Colors.black,
      value: dropdownValue,
      onChanged: (newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      style: TextStyle(
        color: BreedsTypeCubit.get(context).isDark
            ?  Colors.white
            : Colors.black,
      ),
      items: [
        'Type',
        'Cat',
        'Dog',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: const TextStyle(color: Colors.black, fontSize: 14),
          ),
        );
      }).toList(),
    );
  }
}
