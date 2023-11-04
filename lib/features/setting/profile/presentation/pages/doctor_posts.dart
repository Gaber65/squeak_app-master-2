import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:squeak/core/main_basic/main_basic.dart';
import 'package:squeak/core/widgets/components/styles.dart';
import 'package:squeak/features/layout/layout.dart';
import 'package:squeak/features/layout/presentation/controller/post_cubit/post_cubit.dart';
import 'package:squeak/features/layout/presentation/screens/home/create_post.dart';
import 'package:squeak/features/setting/update_profile/presentation/controlls/cubit/beets_type_find_cubit.dart';

import '../../../../../core/network/end-points.dart';
import '../../../../../core/resources/constants_manager.dart';
import '../../../../../core/service/service_locator.dart';
import '../../../../../core/widgets/video_detail.dart';
import '../../../../../generated/l10n.dart';
import '../../../../layout/domain/entites/clinic/all_clinics_entities.dart';
import '../../../../layout/domain/entites/post/create_post_entites.dart';
import '../../../../comment/presentation/pages/comment.dart';
import '../../../../layout/presentation/components/image_post_detail.dart';
import '../../../../layout/presentation/controller/Home_cubit/squeak_cubit.dart';
import '../../../../layout/presentation/screens/clinic/add_clinic/add_clinic.dart';
import '../../../../layout/presentation/screens/clinic/add_clinic/edit_clinic.dart';
import '../../../../layout/presentation/screens/clinic/clinic_cubit/clinic_cubit.dart';
import '../../../../layout/presentation/screens/clinic/follow_clinic/clinic_follower.dart';
import '../../../../layout/presentation/screens/home/edit_post.dart';
import '../../../update_profile/presentation/controlls/cubit/add_edit_beets_cubit.dart';

class DoctorPost extends StatelessWidget {
  const DoctorPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<ClinicCubit>()..getAllSupplierClinics(),
        ),
        BlocProvider(
          create: (context) => sl<PostCubit>()..getAllDoctorPost(),
        ),
      ],
      child: BlocConsumer<PostCubit, PostState>(
        listener: (context, state) {
          if (state is DeletePostSuccessState) {
            PostCubit.get(context).allPostPageNumber = 1;
            PostCubit.get(context).doctorPostsModel.clear();
            PostCubit.get(context).doctorPosts.clear();
            PostCubit.get(context).getAllDoctorPost();
          }
        },
        builder: (context, state) {
          var cubitPost = PostCubit.get(context);
          var cubitClinic = ClinicCubit.get(context);
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Activities'),
                leading: IconButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LayoutScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(60),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        buildTabBarItem(context),
                        if (state is DeletePostLoadingState)
                          const LinearProgressIndicator(),
                      ],
                    ),
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocConsumer<ClinicCubit, ClinicState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return (cubitClinic.allClinicSupplierEntities != null)
                        ? TabBarView(
                            children: [
                              Column(
                                mainAxisAlignment: (cubitClinic
                                        .allClinicSupplierEntities!
                                        .data!
                                        .clinics
                                        .isEmpty)
                                    ? MainAxisAlignment.center
                                    : MainAxisAlignment.start,
                                children: [
                                  if (cubitClinic.allClinicSupplierEntities!
                                      .data!.clinics.isNotEmpty)
                                    Expanded(
                                      child: ListView.separated(
                                        physics: const BouncingScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return buildDetailsContent(
                                            cubitClinic
                                                .allClinicSupplierEntities!
                                                .data!
                                                .clinics[index],
                                            context,
                                            index,
                                          );
                                        },
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(
                                          height: 10,
                                        ),
                                        itemCount: cubitClinic
                                            .allClinicSupplierEntities!
                                            .data!
                                            .clinics
                                            .length,
                                      ),
                                    ),
                                  if (cubitClinic.allClinicSupplierEntities!
                                      .data!.clinics.isEmpty)
                                    buildInkWell2(context),
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    (cubitPost.doctorPosts.isEmpty)
                                        ? MainAxisAlignment.center
                                        : MainAxisAlignment.start,
                                children: [
                                  if (cubitPost.doctorPosts.isEmpty)
                                    buildInkWell(context),
                                  if (cubitPost.doctorPosts.isNotEmpty)
                                    Expanded(
                                      child: NotificationListener<
                                          ScrollNotification>(
                                        onNotification: (notification) {
                                          if (notification.metrics.pixels ==
                                                  notification.metrics
                                                      .maxScrollExtent &&
                                              notification
                                                  is ScrollUpdateNotification) {
                                            cubitPost.getAllDoctorPost(
                                                pagination: true);
                                          }
                                          return true;
                                        },
                                        child: // if (cubitPost.postDoctorEntities!.data!.getPost.isNotEmpty)
                                            ListView.separated(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return BuildPostItem(
                                              postItem:
                                                  cubitPost.doctorPosts[index],
                                              clinicPost: cubitPost
                                                  .doctorPosts[index]
                                                  .clinicPost!,
                                            );
                                          },
                                          separatorBuilder: (context, index) =>
                                              const SizedBox(
                                            height: 12,
                                          ),
                                          itemCount:
                                              cubitPost.doctorPosts.length,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          )
                        : TabBarView(
                            children: [
                              FadeIn(
                                duration: const Duration(milliseconds: 400),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey.shade700,
                                  highlightColor: Colors.grey.shade600,
                                  child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Container(
                                        height: 60,
                                        width: double.infinity,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        decoration: BoxDecoration(
                                          color: !BreedsTypeCubit.get(context)
                                                  .isDark
                                              ? Colors.blue.shade50
                                              : Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      );
                                    },
                                    itemCount: 10,
                                  ),
                                ),
                              ),
                              FadeIn(
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
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
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
                              ),
                            ],
                          );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  InkWell buildInkWell2(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(120),
      onTap: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const AddClinic(),
            ),
            (route) => false);
      },
      child: Center(
        child: Column(
          children: [
            Material(
              color: Colors.transparent,
              elevation: 9,
              shadowColor: Colors.amberAccent.shade100,
              shape: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(120),
                gapPadding: 0,
              ),
              child: const Icon(
                Icons.info,
                color: appColorBtn,
                size: 130,
              ),
            ),
            Text(
              S.of(context).addPetService,
              style: FontStyle().textStyle(
                  color: appColorBtn,
                  fontSize: 30,
                  fontWeight: FontWeight.w100),
            ),
          ],
        ),
      ),
    );
  }

  InkWell buildInkWell(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(120),
      onTap: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => CreatePost(),
            ),
            (route) => false);
      },
      child: Center(
        child: Column(
          children: [
            Material(
              color: Colors.transparent,
              elevation: 9,
              shadowColor: Colors.amberAccent.shade100,
              shape: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(120),
                gapPadding: 0,
              ),
              child: const Icon(
                Icons.info,
                color: appColorBtn,
                size: 130,
              ),
            ),
            Text(
              S.of(context).createPost,
              style: FontStyle().textStyle(
                  color: appColorBtn,
                  fontSize: 30,
                  fontWeight: FontWeight.w100),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildTabBarItem(context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8), // Creates border
      color: BreedsTypeCubit.get(context).isDark
          ? Colors.grey.shade900
          : const Color.fromRGBO(250, 250, 250, 1),
    ),
    child: Padding(
      padding: const EdgeInsets.all(6.0),
      child: TabBar(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey,
        labelStyle: FontStyle().textStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: appColorBtn,
        ),
        unselectedLabelStyle: FontStyle().textStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(8), // Creates border
          color: appColorBtn,
        ),
        isScrollable: true,
        tabs: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: SizedBox(
              height: 20,
              width: MediaQuery.of(context).size.width / 2.5,
              child: Text(
                isArabic() ? 'العيادات' : "Supplier",
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2.5,
              height: 20,
              child: Text(
                isArabic() ? 'المنشورات' : "Posts",
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildDetailsContent(Clinics clinics, context, index) {
  return InkWell(
    borderRadius: BorderRadius.circular(8),
    onTap: () {
      print(clinics);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ClinicFollower(
            clinicId: clinics.clinicId,
            clinics: clinics,
          ),
        ),
      );
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8), // Creates border
        color: BreedsTypeCubit.get(context).isDark
            ? Colors.grey.shade900
            : const Color.fromRGBO(250, 250, 250, 1),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 33,
            backgroundImage: CachedNetworkImageProvider(
              '$imageUrl${clinics.image}',
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            clinics.name,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'bold', fontSize: 15),
          ),
        ],
      ),
    ),
  );
}

class BuildPostItem extends StatelessWidget {
  BuildPostItem({
    super.key,
    required this.clinicPost,
    required this.postItem,
  });
  ClinicPost clinicPost;
  Posts postItem;
  @override
  Widget build(BuildContext context) {
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
                PopupMenuButton<int>(
                  onCanceled: () {
                    Navigator.of(context);
                  },
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      onTap: () {
                        PostCubit.get(context)
                            .deletePost(postId: postItem.postId);
                      },
                      child: Row(
                        children: [
                          Text(
                            S.of(context).removePost,
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const Spacer(),
                          const Icon(Icons.close)
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: InkWell(
                        onTap: () {
                          print('*******');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditPost(
                                clinicPost: clinicPost,
                                postItem: postItem,
                                image: postItem.image,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Text(
                              S.of(context).edit,
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            const Spacer(),
                            const Icon(IconlyLight.edit)
                          ],
                        ),
                      ),
                    ),
                  ],
                  icon: const Icon(
                    Icons.more_horiz,
                  ),
                  offset: const Offset(0, 20),
                )
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
            if (postItem.content.length < 100) Text(postItem.content),
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
                  height: 300.0,
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
            // const Padding(
            //   padding: EdgeInsets.symmetric(
            //     vertical: 5.0,
            //   ),
            //   child: Row(
            //     children: [
            //       Icon(
            //         Icons.pets,
            //         size: 16.0,
            //         color: Colors.red,
            //       ),
            //       SizedBox(
            //         width: 5.0,
            //       ),
            //       Text(
            //         '8',
            //         style: TextStyle(fontSize: 16),
            //       ),
            //       Spacer(),
            //       Icon(
            //         Icons.forum,
            //         size: 16.0,
            //         color: Colors.amber,
            //       ),
            //       SizedBox(
            //         width: 5.0,
            //       ),
            //       Text('1'),
            //     ],
            //   ),
            // ),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CommentScreen(postId: postItem.postId),
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
                          hintText: S.of(context).addComment,
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
