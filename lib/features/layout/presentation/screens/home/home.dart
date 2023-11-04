import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:squeak/core/widgets/components/styles.dart';
import 'package:squeak/core/widgets/toast_state.dart';
import 'package:squeak/features/layout/presentation/controller/Home_cubit/squeak_cubit.dart';
import 'package:squeak/features/layout/presentation/controller/Home_cubit/squeak_state.dart';
import 'package:squeak/features/layout/presentation/components/search.dart';
import 'package:squeak/features/layout/presentation/controller/post_cubit/post_cubit.dart';
import 'package:squeak/features/social_media/presentation/controller/phone_cubit/phone_cubit.dart';
import 'package:squeak/features/social_media/presentation/screens/phone_verify/phone_number.dart';

import '../../../../../core/main_basic/main_basic.dart';
import '../../../../../core/network/end-points.dart';
import '../../../../../core/resources/strings_manager.dart';
import '../../../../../core/service/service_locator.dart';
import '../../../../../core/widgets/video_detail.dart';
import '../../../../../generated/l10n.dart';
import '../../../../setting/update_profile/domain/entities/find_pet_by_owner_id_data.dart';
import '../../../domain/entites/post/create_post_entites.dart';
import '../../../../comment/presentation/pages/comment.dart';
import '../../components/image_post_detail.dart';
import '../../components/notificationPage.dart';
import '../../controller/notification_cubit/notification_cubit.dart';
import '../clinic/clinic_cubit/clinic_cubit.dart';
import 'edit_post.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  void initState() {
    super.initState();
    PostCubit.get(context).userPostsModel.clear();
    PostCubit.get(context).allPostUserPageNumber = 1;
    PostCubit.get(context).getAllUserPost();

  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostCubit, PostState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SqueakCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: (cubit.ownerPetsEntities != null)
                ? BlocConsumer<SqueakCubit, SqueakState>(
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: buildDropDown(
                          petsData: cubit.ownerPetsEntities!.data!,
                          context: context,
                        ),
                      );
                    },
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FadeIn(
                      duration: const Duration(milliseconds: 400),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade700,
                        highlightColor: Colors.grey.shade600,
                        child: const CircleAvatar(),
                      ),
                    ),
                  ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchScreen(),
                      ),
                    );
                  },
                  icon: const Icon(
                    IconlyLight.search,
                  )),
              IconButton(
                iconSize: 32,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationScreen(),
                    ),
                  );
                },
                icon: Stack(
                  children: [
                    const Icon(IconlyLight.notification),
                    if (NotificationCubit.get(context).notificationModel !=
                        null)
                      CircleAvatar(
                        radius: 9,
                        child: NotificationCubit.get(context)
                                    .notificationModel!
                                    .data!
                                    .count <=
                                99
                            ? Text(
                                NotificationCubit.get(context)
                                    .notificationModel!
                                    .data!
                                    .count
                                    .toString(),
                                style: FontStyle().textStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                '+99',
                                style: FontStyle().textStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                  ],
                ),
              ),
            ],
            // bottom: (PhoneCubit.get(context).socialDataUser != null)
            //     ? (PhoneCubit.get(context).socialDataUser!.isPhoneVerify == false)
            //         ? PreferredSize(
            //             preferredSize: const Size.fromHeight(40),
            //             child: Padding(
            //               padding: const EdgeInsets.all(8.0),
            //               child: SizedBox(
            //                 height: 40,
            //                 child: Material(
            //                   color: Colors.yellow.shade50,
            //                   borderRadius: BorderRadius.circular(12),
            //                   child: InkWell(
            //                     borderRadius: BorderRadius.circular(12),
            //                     onTap: () {
            //                       PhoneCubit.get(context).verifySendPhoneNumber(
            //                         phoneNumber: PhoneCubit.get(context)
            //                             .socialDataUser!
            //                             .phone!,
            //                       );
            //                       Navigator.push(
            //                         context,
            //                         MaterialPageRoute(
            //                           builder: (context) {
            //                             return PhoneScreen();
            //                           },
            //                         ),
            //                       );
            //                     },
            //                     child: Row(
            //                       children: [
            //                         const Icon(IconlyLight.danger,
            //                             color: Colors.black),
            //                         const SizedBox(
            //                           width: 10,
            //                         ),
            //                         Text(
            //                           S.of(context).pleaseVerifyPhone,
            //                           style:
            //                               const TextStyle(color: Colors.black),
            //                         ),
            //                         const Spacer(),
            //                         const Icon(Icons.phone_android,
            //                             color: Colors.black),
            //                       ],
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           )
            //         : null
            //     : PreferredSize(
            //         preferredSize: const Size.fromHeight(40),
            //         child: Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: FadeIn(
            //             duration: const Duration(milliseconds: 400),
            //             child: Shimmer.fromColors(
            //               baseColor: Colors.grey.shade700,
            //               highlightColor: Colors.grey.shade600,
            //               child: const SizedBox(
            //                 height: 40,
            //                 width: double.infinity,
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
          ),
          body: BlocConsumer<PostCubit, PostState>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = PostCubit.get(context);
              return (cubit.condationPost != null)
                  ? NotificationListener<ScrollNotification>(
                      onNotification: (notification) {
                        if (notification.metrics.pixels == notification.metrics.maxScrollExtent && notification is ScrollUpdateNotification) {
                          PostCubit.get(context).getAllUserPost(pagination: true);
                        }
                        if (notification.metrics.pixels == notification.metrics.minScrollExtent && notification is ScrollEndNotification) {
                          cubit.userPostsModel.clear();
                          cubit.allPostUserPageNumber = 1;
                          cubit.handleRefresh();
                          PostCubit.get(context).getAllUserPost(pagination: true);
                        }
                        return true;
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (cubit.handleRefreshBool == true)
                            const RefreshProgressIndicator(),
                          if (cubit.userPosts.isNotEmpty && cubit.condationPost != null)
                            Expanded(
                              child: ListView.separated(
                                // physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return BuildPostItem(
                                    postItem:
                                        PostCubit.get(context).userPosts[index],
                                    clinicPost: PostCubit.get(context)
                                        .userPosts[index]
                                        .clinicPost!,
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  height: 12,
                                ),
                                itemCount: PostCubit.get(context).userPosts.length,
                                shrinkWrap: true,
                              ),
                            ),
                          if (cubit.userPosts.isEmpty && cubit.condationPost != null)
                            CachedNetworkImage(
                              imageUrl:
                                  'https://img.freepik.com/premium-vector/pet-veterinarian-online-service-platform-set-veterinary-doctor_277904-17803.jpg?size=626&ext=jpg&uid=R78903714&ga=GA1.1.798062041.1678310296&semt=ais',
                            ),
                        ],
                      ),
                    )
                  : FadeIn(
                      duration: const Duration(milliseconds: 400),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade700,
                        highlightColor: Colors.grey.shade600,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                elevation: 5.0,
                                margin: EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 140,
                                ),
                              ),
                            );
                          },
                          itemCount: 10,
                        ),
                      ),
                    );
            },
          ),
        );
      },
    );
  }

  Widget buildDropDown({
    required List<PetsData> petsData,
    required BuildContext context,
  }) {
    return DropdownButton<PetsData>(
      onChanged: (newValue) {
        SqueakCubit.get(context).changeSelect(
          dropDown: '$imageUrl${newValue!.imageName}',
          dropDownId: newValue.petId,
        );
        showToast(
          text: 'You are now acting ${newValue!.petName}',
          state: ToastState.success,
        );
      },
      isExpanded: false,
      iconSize: 0.0,
      elevation: 0,
      icon: const SizedBox.shrink(),
      underline: const SizedBox(),
      hint: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(
          SqueakCubit.get(context).dropDownItem,
        ),
      ),
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      items: petsData.map((PetsData value) {
        return DropdownMenuItem<PetsData>(
          value: value,
          child: CircleAvatar(
            radius: 20,
            backgroundImage: CachedNetworkImageProvider(
              '$imageUrl${value.imageName}',
            ),
          ),
        );
      }).toList(),
    );
  }
}

class BuildPostItem extends StatelessWidget {
  BuildPostItem({
    super.key,
    required this.clinicPost,
    required this.postItem,
  });
  ClinicPost clinicPost;
  Posts postItem;

  bool isRTL = false;

  @override
  Widget build(BuildContext context) {
    print('$imageUrl${postItem.video}');
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5.0,
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage: CachedNetworkImageProvider(
                    '$imageUrl${clinicPost.image}',
                  ),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        clinicPost.name,
                        style: const TextStyle(
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Row(
                        children: [
                          Text(
                            postItem.title.substring(0, 10),
                            style:
                                Theme.of(context).textTheme.caption?.copyWith(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      height: 1.4,
                                    ),
                          ),
                          const Spacer(),
                          Text(
                            postItem.title.substring(10, 16),
                            style:
                                Theme.of(context).textTheme.caption?.copyWith(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      height: 1.4,
                                    ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 15.0,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15.0,
              ),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            if (postItem.content.length < 100)
              Text(
                postItem.content,
              ),
            if (postItem.content.length > 100)
              ExpandablePanel(
                header: Text(postItem.content),
                collapsed: Text(
                  postItem.content,
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.grey, fontSize: 15),
                ),
                expanded: Text(
                  postItem.content,
                  softWrap: true,
                  style: const TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
            const SizedBox(
              height: 12,
            ),
            if (postItem.image != null && postItem.image != '')
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return ImagePostDetail(
                        image: "$imageUrl${postItem.image}",
                        title: postItem.content,
                      );
                    },
                  ));
                },
                child: Container(
                  height: 250.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        "$imageUrl${postItem.image}",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            if (postItem.video != null && postItem.video != '')
              VideoStringApp(
                video: "$imageUrl${postItem.video}",
              ),
            if (postItem.image != null &&
                postItem.image !=
                    'http://squeak101-001-site1.itempurl.com/postImages')
              const SizedBox(
                height: 12,
              ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10.0,
              ),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            Row(
              children: [
                CircleAvatar(
                  radius: 12,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Share.share('check out my website https://example.com');
                    },
                    icon: const Icon(
                      Icons.share,
                      size: 16,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: InkWell(
                      onTap: () {
                        print('object');
                        print(postItem.postId);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CommentScreen(
                              postId: postItem.postId,
                            ),
                          ),
                        );
                      },
                      child: TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          suffixIcon: const Icon(
                            IconlyLight.send,
                            size: 16,
                          ),
                          border: const OutlineInputBorder(),
                          labelText: S.of(context).addComment,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                // InkWell(
                //   child: Row(
                //     children: [
                //       const Icon(
                //         Icons.pets,
                //         size: 16.0,
                //         color: Colors.red,
                //       ),
                //       const SizedBox(
                //         width: 5.0,
                //       ),
                //       Text(
                //         'Like',
                //         style: Theme.of(context).textTheme.caption,
                //       ),
                //     ],
                //   ),
                //   onTap: () {},
                // ),
              ],
            ),
            const SizedBox(
              width: 15.0,
            ),
          ],
        ),
      ),
    );
  }
}
