import 'package:flutter/material.dart';
import 'package:restaurant_app_submission_1/data/restaurant.dart';
import 'package:restaurant_app_submission_1/style/colors.dart';
import 'package:restaurant_app_submission_1/style/style.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/detail';

  final Restaurant restaurant;

  const DetailPage({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(245),
      body: SingleChildScrollView(
        child: Column(
          children: [_buildHeader(context), _buildContent(context)],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: restaurant.name,
          child: Image.network(restaurant.pictureId),
        ),
        SafeArea(
            child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 4),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, shape: const CircleBorder()),
            child: Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Icon(
                Icons.arrow_back_ios,
                color: primaryColor,
                size: 16,
              ),
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      transform: Matrix4.translationValues(0.0, -30.0, 0),
      child: Column(
        children: [_buildAbout(context), _buildMenu(context)],
      ),
    );
  }

  Widget _buildAbout(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      decoration: cardDecoration(),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(restaurant.name, style: Theme.of(context).textTheme.headlineMedium),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Icon(Icons.star, color: primaryColor, size: 16),
                  Container(
                      margin: const EdgeInsets.only(left: 4),
                      child: Text(restaurant.rating.toString(),
                          style: Theme.of(context).textTheme.bodySmall)),
                  Container(
                      margin: const EdgeInsets.only(left: 12),
                      child: const VerticalDivider(
                        thickness: 1.5,
                      )),
                  Container(
                      margin: const EdgeInsets.only(left: 12),
                      child: Icon(Icons.location_on,
                          color: primaryColor, size: 16)),
                  Container(
                      margin: const EdgeInsets.only(left: 4),
                      child: Text(restaurant.city,
                          style: Theme.of(context).textTheme.bodySmall))
                ],
              ),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(top: 14),
              child:
                  Text('About', style: Theme.of(context).textTheme.titleLarge)),
          Container(
              margin: const EdgeInsets.only(top: 4),
              child: Text(restaurant.description,
                  style: Theme.of(context).textTheme.bodyMedium))
        ],
      ),
    );
  }

  Widget _buildMenu(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      padding: const EdgeInsets.all(12),
      decoration: cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Menus',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Container(
              margin: const EdgeInsets.only(top: 8, bottom: 4), child: const Text('Foods')),
          SizedBox(
            height: 33,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: restaurant.menus.foods.length,
              itemBuilder: (context, index) {
                var food = restaurant.menus.foods[index];
                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(25),
                      borderRadius: const BorderRadius.all(Radius.circular(4))),
                  child: Text(food.name,
                      style: const TextStyle(fontWeight: FontWeight.w300)),
                );
              },
            ),
          ),
          Container(
              margin: const EdgeInsets.only(top: 12, bottom: 4),
              child: const Text('Drinks')),
          SizedBox(
            height: 33,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: restaurant.menus.drinks.length,
              itemBuilder: (context, index) {
                var drink = restaurant.menus.drinks[index];
                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(25),
                      borderRadius: const BorderRadius.all(Radius.circular(4))),
                  child: Text(drink.name,
                      style: const TextStyle(fontWeight: FontWeight.w300)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
