import 'package:flutter/material.dart';
import '../../common/custom_colors.dart';
import '../../common/custom_theme.dart';

class SearchCardItemWidget extends StatelessWidget {
  const SearchCardItemWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(
            color: CustomColors.cardItemColor,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        width: double.infinity,
        height: 48,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    title,
                    style: CustomTextStyles.cardItemTextStyle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
