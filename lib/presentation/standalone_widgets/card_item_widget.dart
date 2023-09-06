import 'package:flutter/material.dart';

import '../../common/custom_colors.dart';
import '../../common/custom_theme.dart';
import '../../domain/model/repository_model.dart';

class CardItemWidget extends StatelessWidget {
  const CardItemWidget(
      {super.key,
      required this.index,
      required this.onFavoritePressed,
      required this.repository,
      required this.isFavorite});

  final int index;
  final VoidCallback onFavoritePressed;
  final Repository repository;
  final bool isFavorite;

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    '${repository.name} [${repository.id}]',
                    style: CustomTextStyles.cardItemTextStyle),
              ),
              GestureDetector(
                  onTap: () => onFavoritePressed(),
                  child: Icon(
                    isFavorite
                        ? Icons.star_rounded
                        : Icons.star_outline_rounded,
                    color: CustomColors.primaryAppColor,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
