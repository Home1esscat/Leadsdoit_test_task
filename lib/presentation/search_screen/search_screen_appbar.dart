import 'package:flutter/material.dart';

import '../../common/custom_colors.dart';
import '../../common/custom_theme.dart';

class SearchScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const SearchScreenAppBar(
      {super.key, required this.title, required this.onFavoritePressed});

  final String title;
  final VoidCallback onFavoritePressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppBar(
          actions: [
            GestureDetector(
              onTap: onFavoritePressed,
              child: const Padding(
                padding: EdgeInsets.only(right: CustomPadding.paddingI1),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                        color: CustomColors.primaryAppColor),
                    child: SizedBox(
                      width: 44,
                      height: 44,
                      child: Icon(Icons.star_rounded),
                    ),
                  ),
                ),
              ),
            ),
          ],
          elevation: 2,
          title: Text(title, style: CustomTextStyles.appBarTitleStyle),
          centerTitle: true,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(AppBarHeight.defaultHeight);
}
