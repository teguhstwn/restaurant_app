import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_app_submission_1/data/restaurant.dart';
import 'package:restaurant_app_submission_1/style/colors.dart';
import 'package:restaurant_app_submission_1/style/style.dart';
import 'package:restaurant_app_submission_1/widget/item_restaurant.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search';

  final String searchQuery;

  const SearchPage(this.searchQuery, {super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Restaurant> restaurants = [];
  List<Restaurant> unfilteredRestaurants = [];

  late Future _future;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [_buildSearchbar(), _buildList()],
      ),
    );
  }

  Widget _buildSearchbar() {
    return Container(
      color: greyColor,
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                    color: greyColor.withAlpha(70),
                    spreadRadius: 1,
                    blurRadius: 10)
              ]),
          child: TextFormField(
            initialValue: widget.searchQuery,
            onChanged: (query) => _searchRestaurants(query),
            decoration: InputDecoration(
                hintText: 'Search restaurant...',
                labelText: null,
                enabledBorder: searchTextFieldFormStyle(),
                border: searchTextFieldFormStyle(),
                focusedBorder: searchTextFieldFormStyle(),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: primaryColor,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                )),
          ),
        ),
      ),
    );
  }

  Widget _buildList() {
    return Expanded(
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: FutureBuilder(
              future: _future,
              builder: (context, snapshot) {
                if (restaurants.isNotEmpty) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return buildRestaurantItem(context, restaurants[index]);
                    },
                    itemCount: restaurants.length,
                  );
                } else {
                  return const Center(
                    child:
                        Text('Failed to find restaurant you searched for :('),
                  );
                }
              },
            )));
  }

  Future loadRestaurants() async {
    var loadedRestaurantAssets =
        json.decode(await rootBundle.loadString('assets/restaurants.json'));

    var restaurantList = parseRestaurantsFromJson(loadedRestaurantAssets);

    setState(() {
      restaurants = restaurantList;
      unfilteredRestaurants = restaurantList;
    });

    return restaurantList;
  }

  void _searchRestaurants(String query) {
    if (query.isEmpty) {
      setState(() {
        restaurants = unfilteredRestaurants;
      });
    } else {
      var filteredRestaurant = restaurants
          .where((restaurant) =>
              restaurant.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

      setState(() {
        restaurants = filteredRestaurant;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _future = loadRestaurants();
    _future.then((_) => _searchRestaurants(widget.searchQuery));
  }
}
