import 'package:flutter/material.dart';
import 'package:restaurant_app_submission_1/data/restaurant.dart';
import 'package:restaurant_app_submission_1/page/detail.dart';
import 'package:restaurant_app_submission_1/style/colors.dart';
import 'package:restaurant_app_submission_1/style/style.dart';

Widget buildRestaurantItem(BuildContext context, Restaurant restaurant) {
  return Container(
    margin: EdgeInsets.only(bottom: 12),
    child: Ink(
      decoration: cardDecoration(),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, DetailPage.routeName,
              arguments: restaurant);
        },
        child: Row(
          children: [
            Hero(
              tag: restaurant.name,
              child: Container(
                width: 85,
                height: 85,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(restaurant.pictureId),
                    ),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8))),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                margin: EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: false,
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 2),
                        child: Text(
                          restaurant.city,
                          style: TextStyle(color: Colors.grey),
                        )),
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: primaryColor,
                            size: 16,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 8),
                            child: Text(
                              restaurant.rating.toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Icon(
                Icons.arrow_forward_ios,
                color: primaryColor,
              ),
              flex: 1,
            )
          ],
        ),
      ),
    ),
  );
}
