import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_submission_1/provider/preferences_provider.dart';
import 'package:restaurant_app_submission_1/provider/scheduling_provider.dart';
import 'package:restaurant_app_submission_1/shared/theme.dart';
import 'package:restaurant_app_submission_1/widget/custom_dialog.dart';

class AboutPage extends StatelessWidget {
  static final routeName = 'about';

  const AboutPage({super.key});

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
          'Setting',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Daily Restaurant Reminder',
                        style: blackTextStyle.copyWith(
                            fontSize: 20, fontWeight: semiBold),
                      ),
                      Consumer<PreferencesProvider>(
                        builder: (context, provider, child) {
                          return Consumer<SchedulingProvider>(
                            builder: (context, scheduled, _) {
                              return Switch.adaptive(
                                value: provider.isDailyRestaurantsActive,
                                activeColor: Colors
                                    .blue, // Color when the switch is active
                                inactiveThumbColor: Colors
                                    .grey, // Color of the thumb when inactive
                                inactiveTrackColor: Colors.grey[300],
                                onChanged: (value) async {
                                  if (Platform.isIOS) {
                                    customDialog(context);
                                  } else {
                                    scheduled.scheduledRestaurant(value);
                                    provider.enableDailyRestaurants(value);
                                  }
                                },
                              );
                            },
                          );
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
