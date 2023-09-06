import 'dart:async';

import 'package:flutter/material.dart';
import 'package:github_test_app/common/app_routes.dart';
import 'package:github_test_app/common/custom_colors.dart';
import 'package:github_test_app/common/custom_theme.dart';

import 'package:github_test_app/common/string_resources.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushNamed(context, AppRoutes.searchScreen);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: CustomColors.splashScreenBackgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                StringResources.splashPageTitle,
                style: CustomTextStyles.splashScreenTextStyle,
              ),
              SizedBox(height: 16),
              CircularProgressIndicator(
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
