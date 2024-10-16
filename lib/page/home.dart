import 'package:flutter/material.dart';
import 'package:restaurant_app_submission_1/data/restaurant.dart';
import 'package:restaurant_app_submission_1/page/about.dart';
import 'package:restaurant_app_submission_1/page/search.dart';
import 'package:restaurant_app_submission_1/style/colors.dart';
import 'package:restaurant_app_submission_1/style/style.dart';
import 'package:restaurant_app_submission_1/widget/item_restaurant.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(245),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 210,
              decoration: BoxDecoration(color: greyColor),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [_buildHeader(context), _buildList(context)],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 45,
              height: 45,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    "assets/image_avatar.png",
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 16),
                child: const Text(
                  'Welcome Back !',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, AboutPage.routeName);
                },
                icon: const Icon(Icons.info, color: Colors.white))
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 24),
          child: const Text(
            'Browse the best restaurant in town !',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.w500, color: Colors.white),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            boxShadow: [
              BoxShadow(
                  color: greyColor.withAlpha(70),
                  spreadRadius: 1,
                  blurRadius: 10)
            ],
          ),
          child: TextFormField(
            onFieldSubmitted: (query) => {
              Navigator.pushNamed(context, SearchPage.routeName,
                  arguments: query)
            },
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: greyColor,
              ),
              hintText: 'Search restaurant...',
              labelText: null,
              enabledBorder: searchTextFieldFormStyle(),
              border: searchTextFieldFormStyle(),
              focusedBorder: searchTextFieldFormStyle(),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 24, bottom: 8),
          child: const Text(
            'Explore',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  Widget _buildList(BuildContext context) {
    return FutureBuilder<String>(
      future: DefaultAssetBundle.of(context)
          .loadString('assets/local_restaurant.json'),
      builder: (context, snapshot) {
        final restaurants = parseRestaurantsFromJsonString(snapshot.data);
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return buildRestaurantItem(context, restaurants[index]);
          },
          itemCount: restaurants.length,
        );
      },
    );
  }
}
