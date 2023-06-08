import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squeak/core/service/service_locator.dart';
import 'package:squeak/features/layout/cubit/squeak_cubit.dart';
import 'package:squeak/features/layout/cubit/squeak_state.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:squeak/features/layout/home/image_post_detail.dart';
import 'package:squeak/features/layout/home/search.dart';

import '../profile/domain/entities/owner_pets.dart';
import 'comment.dart';
import 'notificationPage.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SqueakCubit, SqueakState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = SqueakCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: const Text(
              'Feeds ',
              style: TextStyle(fontWeight: FontWeight.normal),
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
                  icon: const Icon(Icons.search)),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotificationScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.notifications_outlined)),
            ],
          ),
          body: (state is SqueakGetOwnerPitsLoadingState ||
                  state is SqueakUGetOwnerPitsErrorState ||
                  state is SqueakProfileDataLoadingState ||
                  state is SqueakProfileDataErrorState)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          if (cubit.isShow)
                            DelayedDisplay(
                              delay: const Duration(microseconds: 400),
                              slidingBeginOffset: const Offset(0, 0),
                              child: Card(
                                elevation: 4,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    right: 40,
                                    left: 8,
                                    top: 20,
                                  ),
                                  child: SizedBox(
                                    height: 60,
                                    width: MediaQuery.of(context).size.width,
                                    child: (state
                                            is SqueakGetOwnerPitsSuccessState)
                                        ? const Row()
                                        : ListView.separated(
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) =>
                                                BuildOwnerPit(
                                              ownerBreed: cubit
                                                  .ownerPetsEntities
                                                  .data
                                                  .breed[index],
                                            ),
                                            separatorBuilder:
                                                (context, index) =>
                                                    const SizedBox(
                                              width: 12,
                                            ),
                                            itemCount: cubit.ownerPetsEntities
                                                .data.breed.length,
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          if (!cubit.isShow)
                            const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Row(
                                children: [],
                              ),
                            ),
                          IconButton(
                            onPressed: () {
                              cubit.changeExpandedRow();
                            },
                            icon: !cubit.isShow
                                ? CircleAvatar(
                                    backgroundColor: Colors.red.shade200,
                                    child: const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Icon(Icons.keyboard_arrow_up),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      buildPostItem(cubit: cubit),
                    ],
                  ),
                ),
        );
      },
    );
  }
}

class buildPostItem extends StatelessWidget {
  buildPostItem({super.key, required this.cubit});
  var cubit;
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
                const CircleAvatar(
                  radius: 25.0,
                  backgroundImage: CachedNetworkImageProvider(
                      'https://img.freepik.com/premium-photo/cartoon-drawing-white-cat-with-blue-eyes-sits-blue-background_881695-6630.jpg?size=626&ext=jpg&uid=R78903714&ga=GA1.1.798062041.1678310296&semt=ais'),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Text(
                            'Gaber Abdelrheem Gaber',
                            style: TextStyle(
                              height: 1.4,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                        ],
                      ),
                      Text(
                        '6:00 pm',
                        style: Theme.of(context).textTheme.caption?.copyWith(
                              height: 1.4,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                PopupMenuButton<int>(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: InkWell(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Success Remove'),
                            ),
                          );
                        },
                        child: const Row(
                          children: [
                            Text(
                              'Remove post',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Spacer(),
                            Icon(Icons.remove)
                          ],
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: InkWell(
                        onTap: () {},
                        child: const Row(
                          children: [
                            Text(
                              'Unfollow',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Spacer(),
                            Icon(Icons.no_accounts_outlined)
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
            const Text(
              'Nice Feature ❤️🔥',
              maxLines: 6,
            ),
            const SizedBox(
              height: 12,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return ImagePostDetail(
                      image:
                          'https://img.freepik.com/free-photo/small-funny-dog-beagle-posing-isolated-white-wall_155003-33570.jpg?size=626&ext=jpg&uid=R78903714&ga=GA1.2.798062041.1678310296&semt=sph',
                    );
                  },
                ));
              },
              child: Container(
                height: 300.0,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      'https://img.freepik.com/free-photo/small-funny-dog-beagle-posing-isolated-white-wall_155003-33570.jpg?size=626&ext=jpg&uid=R78903714&ga=GA1.2.798062041.1678310296&semt=sph',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 5.0,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.pets,
                    size: 16.0,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    '8',
                    style: TextStyle(fontSize: 16),
                  ),
                  Spacer(),
                  Icon(
                    Icons.forum,
                    size: 16.0,
                    color: Colors.amber,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text('1'),
                ],
              ),
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
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: InkWell(
                      onTap: () {
                        print('object');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CommentScreen(),
                          ),
                        );
                      },
                      child: const TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.near_me,
                            size: 16,
                          ),
                          border: OutlineInputBorder(),
                          labelText: "Add comment . . . .",
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.pets,
                        size: 16.0,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        'Like',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BuildOwnerPit extends StatelessWidget {
  BuildOwnerPit({super.key, required this.ownerBreed});
  OwnerBreed ownerBreed;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(ownerBreed.imageName),
        ),
        Text(
          ownerBreed.petName,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
