import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurant_app_submission_1/page/home.dart';
import 'package:restaurant_app_submission_1/style/colors.dart';

class SplashPage extends StatefulWidget {
  static const routeName = 'splash';

  const SplashPage({super.key});
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Center(
        child: Lottie.asset('assets/splash.json',
            width: 300, height: 300, fit: BoxFit.fill),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3),
        () {Navigator.pushNamed(context, HomePage.routeName);});
  }
}
