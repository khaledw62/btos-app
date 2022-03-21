import 'package:btos/controllers/dashboardController.dart';
import 'package:btos/models/PropertiesModels/Property.dart';
import 'package:btos/widgets/Properties/PropertyViewer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';

import '../../services/api_services.dart';
import '../Values/theme.dart';

class PropertyCard extends StatefulWidget {
  Property property;

  PropertyCard({required this.property});

  @override
  State<PropertyCard> createState() => _PropertyCardState();
}

class _PropertyCardState extends State<PropertyCard> {
  final DashboardController dashboardController = Get.find();

  List<dynamic> f = [
    "https://read.opensooq.com/wp-content/uploads/2019/11/6g.jpg",
    "https://read.opensooq.com/wp-content/uploads/2019/11/6g.jpg",
    "https://read.opensooq.com/wp-content/uploads/2019/11/6g.jpg",
    "https://read.opensooq.com/wp-content/uploads/2019/11/6g.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 350,
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
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    flex: 7,
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
                        items: f.map((e) => Image.network(e.toString(), fit: BoxFit.cover)).toList(),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      width: double.maxFinite,
                      color: Theme.of(context).backgroundColor,
                      child: Column(
                        children: [
                          Text(
                            widget.property.project,
                            style: Themes().titleStyle,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            widget.property.property_type_name,
                            style: Themes().titleStyle,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.place_outlined,
                                color: backgroundColor,
                                size: 30,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                widget.property.place,
                                style: Themes().subTitleStyle,
                              ),
                            ],
                          ),
                          const Divider(
                            color: neutralGray,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: SvgPicture.asset("assets/icons/bedroom.svg"),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "${widget.property.bedrooms}",
                                style: Themes().subTitleStyle,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: SvgPicture.asset("assets/icons/bathroom.svg"),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "${widget.property.bathrooms}",
                                style: Themes().subTitleStyle,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: SvgPicture.asset("assets/icons/area.svg"),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.property.area.textual_value,
                                style: Themes().subTitleStyle,
                              ),
                            ],
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                      padding: const EdgeInsets.only(left: 20, top: 15, right: 20, bottom: 5),
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 20,
                top: 188,
                child: Visibility(
                  visible: widget.property.can_favourite,
                  child: CircleAvatar(
                    radius: 23,
                    child: LikeButton(
                      isLiked: widget.property.is_favourite,
                      size: 23,
                      bubblesColor: const BubblesColor(dotPrimaryColor: lightRed, dotSecondaryColor: backgroundColor),
                      circleColor: const CircleColor(start: lightRed, end: backgroundColor),
                      countPostion: CountPostion.right,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      onTap: (isLike) async {
                        setState(() {
                          widget.property.is_favourite = !widget.property.is_favourite;
                        });
                        markedAsFavourite(widget.property.id);
                        return !isLike;
                      },
                      likeBuilder: (isLike) =>
                          Icon(widget.property.is_favourite ? Icons.favorite : Icons.favorite_border, color: lightRed),
                    ),
                    backgroundColor: Theme.of(context).backgroundColor.withOpacity(0.8),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () => Get.to(()=>PropertyViewer(id: widget.property.id)),
    );
  }

  markedAsFavourite(int id) async {
    String route = "api/favourite/properties";
    Map<String, String> body = {};
    if (!widget.property.is_favourite) {
      route += "/$id";
      body["_method"] = 'DELETE';
    } else {
      body['property_id'] = '$id';
    }
    print("object $body");
    try {
      await ApiServices().post(route, body).then((value) => print("object $value"));
    } catch (e) {
      setState(() {
        widget.property.is_favourite = !widget.property.is_favourite;
      });
    }
  }
}
