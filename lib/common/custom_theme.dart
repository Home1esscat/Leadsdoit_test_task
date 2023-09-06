import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'custom_colors.dart';

const String ralewayFont = 'Raleway';

class CustomTheme {
  static ThemeData get theme => ThemeData(
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          color: CustomColors.appBarColor,
        ),
      );
}

class CustomTextStyles {
  static const TextStyle appBarTitleStyle = TextStyle(
      color: Colors.black,
      fontFamily: ralewayFont,
      fontWeight: FontWeight.bold);

  static const TextStyle searchHintInputStyle = TextStyle(
      color: CustomColors.inputTextHintColor,
      fontFamily: ralewayFont,
      fontWeight: FontWeight.w100);

  static const TextStyle searchTextInputStyle = TextStyle(
      color: CustomColors.textColor,
      fontFamily: ralewayFont,
      fontWeight: FontWeight.bold);

  static const TextStyle infoMessageStyle = TextStyle(
      color: CustomColors.inputTextHintColor,
      fontFamily: ralewayFont,
      fontWeight: FontWeight.w400);

  static const TextStyle cardItemTextStyle = TextStyle(
      color: CustomColors.textColor,
      fontFamily: ralewayFont,
      fontWeight: FontWeight.w400);

  static const TextStyle searchSubtitleStyle = TextStyle(
      color: CustomColors.primaryAppColor,
      fontFamily: ralewayFont,
      fontSize: 16,
      fontWeight: FontWeight.w600);
}
