import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_submission_1/data/api/api_service.dart';
import 'package:restaurant_app_submission_1/page/about.dart';
import 'package:restaurant_app_submission_1/page/detail.dart';
import 'package:restaurant_app_submission_1/page/home.dart';
import 'package:restaurant_app_submission_1/page/search.dart';
import 'package:restaurant_app_submission_1/page/splash.dart';
import 'package:restaurant_app_submission_1/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app_submission_1/provider/list_restaurant_provider.dart';
import 'package:restaurant_app_submission_1/provider/review_restaurant_provider.dart';
import 'package:restaurant_app_submission_1/provider/search_restaurant_provider.dart';
import 'package:restaurant_app_submission_1/style/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: primaryColor,
          hintColor: secondaryColor),
      initialRoute: SplashPage.routeName,
      routes: {
        SplashPage.routeName: (context) => const SplashPage(),
        // HomePage.routeName: (context) => HomePage(),
        HomePage.routeName: (context) => ChangeNotifierProvider(
              create: (_) => ListRestaurantProvider(apiService: ApiService()),
              child: HomePage(),
            ),
        // SearchPage.routeName: (context) =>
        //     SearchPage(ModalRoute.of(context)?.settings.arguments as String),
        SearchPage.routeName: (context) => ChangeNotifierProvider(
              create: (_) => SearchRestaurantProvider(
                apiService: ApiService(),
                query: ModalRoute.of(context)?.settings.arguments as String,
              ),
              child: SearchPage(
                ModalRoute.of(context)?.settings.arguments as String,
              ),
            ),
        // DetailPage.routeName: (context) => DetailPage(
        //     restaurant:
        //         ModalRoute.of(context)?.settings.arguments as Restaurant),
        DetailPage.routeName: (context) => MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (_) => DetailRestaurantProvider(
                      apiService: ApiService(),
                      restaurantId:
                          ModalRoute.of(context)?.settings.arguments as String),
                ),
                ChangeNotifierProvider(
                  create: (_) => ReviewRestaurantProvider(
                    apiService: ApiService(),
                  ),
                )
              ],
              child: DetailPage(),
            ),
        AboutPage.routeName: (context) => const AboutPage()
      },
    );
  }
}
