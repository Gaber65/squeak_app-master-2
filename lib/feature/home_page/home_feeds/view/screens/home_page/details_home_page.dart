import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:mostakbal/core/const/components/elevated_button.dart';
import 'package:mostakbal/core/const/const.dart';
import 'package:mostakbal/feature/home_page/home_feeds/view/screens/home_page/hotail_screen.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../../../core/models/home_model/for_you_tap_model.dart';
import '../../../../../appointment/view/screens/booking-step1-screen.dart';

class FeedsDetails extends StatefulWidget {
  FeedsDetails({super.key, required this.model, required this.itemId});
  TripModel model;
  String itemId;

  @override
  State<FeedsDetails> createState() => _FeedsDetailsState();
}

class _FeedsDetailsState extends State<FeedsDetails> {
  int? currentIndex;
  bool isShow = true;
  bool isTextShow = true;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: InkWell(
        onTap: () {
          setState(() {
            isShow = !isShow;
          });
        },
        onLongPress: () {
          setState(() {
            isShow = !isShow;
          });
        },
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Image(
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.fill,
              image: CachedNetworkImageProvider(currentIndex == null
                  ? widget.model.image
                  : widget.model.listOfImage[currentIndex!]),
            ),
            Padding(
              padding: EdgeInsets.only(top: 64),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: const Color.fromRGBO(27, 30, 40, .2),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          IconlyLight.arrow_right,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: const Color.fromRGBO(27, 30, 40, .2),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          IconlyLight.heart,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: const Color.fromRGBO(27, 30, 40, .2),
                      child: IconButton(
                        onPressed: () {
                          Share.share(widget.model.image);
                        },
                        icon: const Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: isShow
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 220,
                  width: 63,
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          print('object');
                          setState(() {
                            currentIndex = index;
                          });
                          print(currentIndex);
                        },
                        child: Material(
                          shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                widget.model.listOfImage[index],
                                height: 58,
                                width: 58,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: widget.model.listOfImage.length,
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 10,
                      );
                    },
                  ),
                ),
              ],
            )
          : null,
      bottomSheet: isShow
          ? null
          : Material(
              elevation: 12,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.minimize,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    MaterialButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        RoutePage().navigateTo(
                          context,
                          HotailScreen(
                            itemId: widget.itemId,
                            hotailName: widget.model.hotailName,
                          ),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                widget.model.flightName,
                                style: FontStyle().textStyle(
                                    fontWeight: FontWeight.w700, fontSize: 24),
                              ),
                              Spacer(),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'ج2000',
                                    maxLines: 2,
                                    style: FontStyle().textStyle(
                                      fontSize: 20,
                                      fontColor: ColorStyle().primaryColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    '/فرد',
                                    maxLines: 2,
                                    style: FontStyle().textStyle(
                                      fontSize: 20,
                                      fontColor: Colors.grey,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 14,
                                backgroundImage: CachedNetworkImageProvider(
                                    widget.model.image),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                widget.model.hotailName,
                                style: FontStyle().textStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    fontColor: Colors.grey),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                IconlyLight.location,
                                color: Colors.grey,
                                size: 22,
                              ),
                              Text(
                                widget.model.location,
                                style: FontStyle().textStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  fontColor: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                width: 60,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                  bottom: 5,
                                ),
                                child: Icon(
                                  IconlyBold.star,
                                  color: Colors.amber,
                                  size: 16,
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Text(
                                widget.model.rating.toString(),
                                style: FontStyle().textStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontColor: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 52,
                      width: double.infinity,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              print('object');
                              setState(() {
                                currentIndex = index;
                              });
                              print(currentIndex);
                            },
                            child: Material(
                              shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    widget.model.listOfImage[index],
                                    height: 52,
                                    width: 52,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: widget.model.listOfImage.length,
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 10,
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'عن الرحلة',
                      style: FontStyle()
                          .textStyle(fontWeight: FontWeight.w700, fontSize: 24),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.model.details,
                      maxLines: 3,
                      style: FontStyle().textStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                          fontColor: Colors.grey),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    MyElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context){

                          return BookingStep1Screen(
                            hotialName:widget.model.hotailName ,
                            hotialImage: widget.model.image,
                          );
                        }));
                      },
                      text: 'حجز الان',
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
