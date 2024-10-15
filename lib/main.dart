import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_submission_1/common/common.dart';
import 'package:restaurant_app_submission_1/data/api/api_service.dart';
import 'package:restaurant_app_submission_1/data/local/db/database_helper.dart';
import 'package:restaurant_app_submission_1/page/about.dart';
import 'package:restaurant_app_submission_1/page/detail.dart';
import 'package:restaurant_app_submission_1/page/favorite.dart';
import 'package:restaurant_app_submission_1/page/home.dart';
import 'package:restaurant_app_submission_1/page/search.dart';
import 'package:restaurant_app_submission_1/page/splash.dart';
import 'package:restaurant_app_submission_1/provider/database_provider.dart';
import 'package:restaurant_app_submission_1/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app_submission_1/provider/list_restaurant_provider.dart';
import 'package:restaurant_app_submission_1/provider/preferences_provider.dart';
import 'package:restaurant_app_submission_1/provider/review_restaurant_provider.dart';
import 'package:restaurant_app_submission_1/provider/scheduling_provider.dart';
import 'package:restaurant_app_submission_1/provider/search_restaurant_provider.dart';
import 'package:restaurant_app_submission_1/style/colors.dart';
import 'package:restaurant_app_submission_1/utils/background_service.dart';
import 'package:restaurant_app_submission_1/utils/notification_helper.dart';
import 'package:restaurant_app_submission_1/utils/preferences_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ListRestaurantProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => ReviewRestaurantProvider(
            apiService: ApiService(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(
            databaseHelper: DatabaseHelper(),
          ),
        ),
        ChangeNotifierProvider(create: (_) => SchedulingProvider()),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: primaryColor, colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(secondary: secondaryColor),
        ),
        navigatorKey: navigatorKey,
        initialRoute: SplashPage.routeName,
        routes: {
          SplashPage.routeName: (context) => SplashPage(),
          HomePage.routeName: (context) => HomePage(),
          SearchPage.routeName: (context) => ChangeNotifierProvider(
                create: (_) => SearchRestaurantProvider(
                  apiService: ApiService(),
                  query: ModalRoute.of(context)?.settings.arguments as String,
                ),
                child: SearchPage(
                  ModalRoute.of(context)?.settings.arguments as String,
                ),
              ),
          DetailPage.routeName: (context) => ChangeNotifierProvider(
                create: (_) => DetailRestaurantProvider(
                    apiService: ApiService(),
                    restaurantId:
                        ModalRoute.of(context)?.settings.arguments as String),
                child: DetailPage(),
              ),
          AboutPage.routeName: (context) => AboutPage(),
          FavoritePage.routeName: (context) => FavoritePage(),
        },
      ),
    );
  }
}
