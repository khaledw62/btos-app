import 'package:btos/models/PropertiesModels/Property.dart';
import 'package:btos/widgets/Values/Functions.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 330,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: white,
        boxShadow: [
          BoxShadow(
            color: black.withOpacity(0.3),
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
                    margin: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: AssetImage("assets/testimages/ad2.jpeg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    width: double.maxFinite,
                    color: white,
                    child: Column(
                      children: [
                        Text(
                          widget.property.project,
                          style: Themes().titleStyle,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          widget.property.property_type_name,
                          style: Themes().titleStyle,
                        ),
                        const SizedBox(
                          height: 8,
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
                        const SizedBox(
                          height: 8,
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
              top: 166,
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
                    /*likeBuilder: (isLike) =>
                                Icon(widget.client.is_vip ? CRMIcons().vip : CRMIcons().borderVip, color: AppColors().amber),*/
                  ),
                  backgroundColor: white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  markedAsFavourite(int id) async {
    try {
      await ApiServices().post("api/favourite/properties",{'property_id':'$id'});
    } catch (e) {
      setState(() {
        widget.property.is_favourite = !widget.property.is_favourite;
      });
    }
  }
}
