import 'package:flutter/material.dart';
import 'package:github_test_app/common/custom_theme.dart';
import 'package:github_test_app/presentation/favorite_screen/favorite_screen.dart';
import 'package:github_test_app/presentation/search_screen/search_screen.dart';
import 'package:github_test_app/presentation/search_screen/search_screen_cubit/search_screen_cubit.dart';
import 'package:provider/provider.dart';

import '../presentation/favorite_screen/favorite_screen_cubit/favorite_screen_cubit.dart';
import '../presentation/search_screen/search_screen_history_cubit/search_screen_history_cubit.dart';

class Bootstrap extends StatelessWidget {
  const Bootstrap({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<SearchScreenCubit>(
          create: (context) => SearchScreenCubit(),
        ),
        Provider<FavoriteScreenCubit>(
            create: (context) => FavoriteScreenCubit()),
        Provider<SearchScreenHistoryCubit>(
            create: (context) => SearchScreenHistoryCubit())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: CustomTheme.theme,
        initialRoute: '/',
        routes: {
          '/': (context) => const SearchScreen(),
          '/favorite': (context) => const FavoriteScreen()
        },
      ),
    );
  }
}
