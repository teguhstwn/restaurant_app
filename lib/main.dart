import 'package:flutter/material.dart';
import 'package:restaurant_app_submission_1/data/restaurant.dart';
import 'package:restaurant_app_submission_1/page/about.dart';
import 'package:restaurant_app_submission_1/page/detail.dart';
import 'package:restaurant_app_submission_1/page/home.dart';
import 'package:restaurant_app_submission_1/page/search.dart';
import 'package:restaurant_app_submission_1/page/splash.dart';
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
        HomePage.routeName: (context) => HomePage(),
        SearchPage.routeName: (context) =>
            SearchPage(ModalRoute.of(context)?.settings.arguments as String),
        DetailPage.routeName: (context) => DetailPage(
            restaurant:
                ModalRoute.of(context)?.settings.arguments as Restaurant),
        AboutPage.routeName: (context) => const AboutPage()
      },
    );
  }
}
