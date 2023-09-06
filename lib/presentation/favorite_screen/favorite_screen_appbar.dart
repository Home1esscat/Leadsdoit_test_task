import 'package:flutter/material.dart';
import 'package:github_test_app/common/custom_colors.dart';
import 'package:github_test_app/common/custom_theme.dart';

class FavoriteScreenAppBar extends StatelessWidget with PreferredSizeWidget {
  const FavoriteScreenAppBar(
      {super.key, required this.title, required this.onBackPressed});

  final String title;
  final VoidCallback onBackPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppBar(
          elevation: 2,
          title: Text(title, style: CustomTextStyles.appBarTitleStyle),
          centerTitle: true,
          leading: GestureDetector(
            onTap: onBackPressed,
            child: const Align(
              child: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                    color: CustomColors.primaryAppColor),
                child: SizedBox(
                  width: 44,
                  height: 44,
                  child: Icon(Icons.arrow_back_ios_new),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
