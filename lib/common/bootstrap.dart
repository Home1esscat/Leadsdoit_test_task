import 'package:flutter/material.dart';
import 'package:github_test_app/common/app_routes.dart';
import 'package:github_test_app/common/custom_theme.dart';
import 'package:github_test_app/presentation/favorite_screen/favorite_screen.dart';
import 'package:github_test_app/presentation/search_screen/search_screen.dart';
import 'package:github_test_app/presentation/splash_screen/splash_screen.dart';

class Bootstrap extends StatelessWidget {
  const Bootstrap({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.theme,
      initialRoute: AppRoutes.splashScreen,
      routes: {
        AppRoutes.splashScreen: (context) => const SplashScreen(),
        AppRoutes.favoriteScreen: (context) => const FavoriteScreen(),
        AppRoutes.searchScreen: (context) => const SearchScreen()
      },
    );
  }
}
