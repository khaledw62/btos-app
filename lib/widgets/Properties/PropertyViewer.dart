import 'package:btos/controllers/PropertiesControllers/PropertiesListingController.dart';
import 'package:btos/widgets/Values/sizes.dart';
import 'package:btos/widgets/Values/theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';

class PropertyViewer extends StatefulWidget {
  int id;

  PropertyViewer({required this.id});

  @override
  State<PropertyViewer> createState() => _PropertyViewerState();
}

class _PropertyViewerState extends State<PropertyViewer> {
  final PropertiesListingController controller = Get.find();

  @override
  void initState() {
    controller.getProperty(widget.id);
    super.initState();
  }

  @override
  void dispose() {
    controller.clearProperty();
    super.dispose();
  }

  List<dynamic> f = [
    "https://read.opensooq.com/wp-content/uploads/2019/11/6g.jpg",
    "https://read.opensooq.com/wp-content/uploads/2019/11/6g.jpg",
    "https://read.opensooq.com/wp-content/uploads/2019/11/6g.jpg",
    "https://read.opensooq.com/wp-content/uploads/2019/11/6g.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig.init(context);
    return Directionality(
      textDirection: Get.locale == const Locale("ar") ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Themes().standardAppbar(context),
                GetX<PropertiesListingController>(
                  init: controller,
                  builder: (controller) => Column(
                    children: [
                      Container(
                        height: 400,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Theme.of(context).backgroundColor,
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).appBarTheme.foregroundColor!.withOpacity(0.3),
                              blurRadius: 7,
                              offset: const Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: controller.property.value.id == -1
                              ? Container()
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Stack(
                                    children: [
                                      Column(
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: CarouselSlider(
                                                options: CarouselOptions(
                                                  enlargeCenterPage: true,
                                                  disableCenter: true,
                                                  height: double.infinity,
                                                  scrollDirection: Axis.horizontal,
                                                  viewportFraction: 1,
                                                  aspectRatio: 1,
                                                ),
                                                items: f
                                                    .map((e) => Image.network(e.toString(), fit: BoxFit.cover))
                                                    .toList(),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              width: double.maxFinite,
                                              color: Theme.of(context).backgroundColor,
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      controller.property.value.price.textual_value,
                                                      style: Themes().titleStyle,
                                                    ),
                                                    Text(
                                                      controller.property.value.property_listing_type,
                                                      style: Themes().subTitleStyle,
                                                    ),
                                                  ],
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                ),
                                              ),
                                              padding: const EdgeInsets.only(left: 20, top: 15, right: 20, bottom: 5),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Positioned(
                                        right: 20,
                                        top: 300,
                                        child: Visibility(
                                          visible: controller.property.value.can_favourite,
                                          child: CircleAvatar(
                                            radius: 23,
                                            child: LikeButton(
                                              isLiked: controller.property.value.is_favourite,
                                              size: 23,
                                              bubblesColor: const BubblesColor(
                                                  dotPrimaryColor: lightRed, dotSecondaryColor: backgroundColor),
                                              circleColor: const CircleColor(start: lightRed, end: backgroundColor),
                                              countPostion: CountPostion.right,
                                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                              onTap: (isLike) async {
                                                setState(() {
                                                  controller.property.value.is_favourite =
                                                      controller.property.value.is_favourite;
                                                });
                                                /*markedAsFavourite(controller.property.value.id);*/
                                                return !isLike;
                                              },
                                              likeBuilder: (isLike) => Icon(
                                                  controller.property.value.is_favourite
                                                      ? Icons.favorite
                                                      : Icons.favorite_border,
                                                  color: lightRed),
                                            ),
                                            backgroundColor: Theme.of(context).backgroundColor.withOpacity(0.8),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ),
                      Container(
                        height: sizeConfig.screenHeight * 0.25,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).backgroundColor,
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).appBarTheme.foregroundColor!.withOpacity(0.3),
                              blurRadius: 7,
                              offset: const Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "LOCATION",
                                        style: Themes().titleStyle,
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        controller.property.value.project,
                                        style: Themes().subTitleStyle,
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).backgroundColor,
                                    image: const DecorationImage(
                                      image: AssetImage("assets/images/locationimage.png"),
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  margin: const EdgeInsets.only(right: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 200,
                        width: sizeConfig.screenWidth,
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).backgroundColor,
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).appBarTheme.foregroundColor!.withOpacity(0.3),
                              blurRadius: 7,
                              offset: const Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${controller.property.value.project.toUpperCase()} ${controller.property.value.property_listing_type} at ${controller.property.value.place}",
                                style: Themes().titleStyle,
                              ),
                              const SizedBox(height: 20),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(children: [
                                          SizedBox(
                                            child: SvgPicture.asset("assets/icons/property.svg"),
                                            height: 20,
                                            width: 20,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            "property tybe: ",
                                            style: Themes().titleStyle,
                                          )
                                        ]),
                                        Row(children: [
                                          SizedBox(
                                            child: SvgPicture.asset("assets/icons/bedroom.svg"),
                                            height: 20,
                                            width: 20,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            "bedrooms: ",
                                            style: Themes().titleStyle,
                                          )
                                        ]),
                                        Row(children: [
                                          SizedBox(
                                            child: SvgPicture.asset("assets/icons/bathroom.svg"),
                                            height: 20,
                                            width: 20,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            "BATHROOMS: ",
                                            style: Themes().titleStyle,
                                          )
                                        ]),
                                        Row(children: [
                                          SizedBox(
                                            child: SvgPicture.asset("assets/icons/area.svg"),
                                            height: 20,
                                            width: 20,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            "PROPERTY SIZE: ",
                                            style: Themes().titleStyle,
                                          )
                                        ]),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          controller.property.value.property_type_name,
                                          style: Themes().subTitleStyle,
                                        ),
                                        Text(
                                          controller.property.value.bedrooms.toString(),
                                          style: Themes().subTitleStyle,
                                        ),
                                        Text(
                                          controller.property.value.bathrooms.toString(),
                                          style: Themes().subTitleStyle,
                                        ),
                                        Text(
                                          controller.property.value.area.textual_value,
                                          style: Themes().subTitleStyle,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
