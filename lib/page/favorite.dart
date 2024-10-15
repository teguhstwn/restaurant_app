import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_submission_1/provider/database_provider.dart';
import 'package:restaurant_app_submission_1/shared/theme.dart';
import 'package:restaurant_app_submission_1/widget/common.dart';
import 'package:restaurant_app_submission_1/widget/item_restaurant.dart';

class FavoritePage extends StatelessWidget {
  static final routeName = 'favorite';

  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greyColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Icon(Icons.arrow_back_ios),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Favorite',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, state, _) {
        if (state.state == LocalResourceState.loading) {
          return circularProgressIndicator();
        } else if (state.state == LocalResourceState.hasData) {
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return buildRestaurantItem(
                context,
                state.favorites[index],
              );
            },
            itemCount: state.favorites.length,
          );
        } else if (state.state == LocalResourceState.noData) {
          return Center(child: Text(state.message));
        } else if (state.state == LocalResourceState.error) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text(''));
        }
      },
    );
  }

}
