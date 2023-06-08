import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squeak/features/layout/cubit/squeak_cubit.dart';
import 'package:squeak/features/layout/cubit/squeak_state.dart';

import '../../../components/styles.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/resources/constants_manager.dart';
import '../../../core/utils/translation/applocal.dart';
import '../../../core/widgets/video_detail.dart';
import '../update_profile/presentation/pages/my_pets.dart';

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
          appBar: AppBar(
            title:  Text(
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
                TextField(
                  maxLines: 4,
                  onSubmitted: (value) {},
                  keyboardType: TextInputType.multiline,
                  style: const TextStyle(height: 2, fontSize: 12),
                  decoration: InputDecoration(
                    label: Text(
                      "${getLang(context, "labelPost")}",
                      style: const TextStyle(fontSize: 22),
                    ),
                    alignLabelWithHint: true,
                  ),
                ),
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
                      height: 200,
                      child: VideoApp(
                        video: cubit.postVideo!,
                      ),
                    ),
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
                                      child: const Row(
                                        children: [
                                          Icon(
                                            Icons.movie_creation_outlined,
                                            color: Colors.red,
                                          ),
                                          SizedBox(
                                            width: 40,
                                          ),
                                          Text("/Add Video"),
                                          Spacer(),
                                          Spacer(),
                                        ],
                                      ),
                                    ),
                                    Divider(),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                        cubit.getPostCamera();
                                      },
                                      child: const Row(
                                        children: [
                                          Icon(
                                            Icons.camera,
                                          ),
                                          SizedBox(
                                            width: 40,
                                          ),
                                          Text("/Take camera"),
                                          Spacer(),
                                          Spacer(),
                                        ],
                                      ),
                                    ),
                                    Divider(),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                        cubit.getPostImage();
                                      },
                                      child: const Row(
                                        children: [
                                          Icon(
                                            Icons.photo_library_outlined,
                                            color: Colors.green,
                                          ),
                                          SizedBox(
                                            width: 40,
                                          ),
                                          Text("/Take Pits"),
                                          Spacer(),
                                          Spacer(),
                                        ],
                                      ),
                                    ),
                                    Divider(),
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
      iconEnabledColor: Colors.black,
      value: dropdownValueBreed,
      onChanged: (newValue) {
        setState(() {
          dropdownValueBreed = newValue!;
        });
      },
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
      iconEnabledColor: Colors.black,
      value: dropdownValue,
      onChanged: (newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
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
