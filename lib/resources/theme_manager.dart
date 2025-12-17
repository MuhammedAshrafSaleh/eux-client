import 'package:eux_client/resources/app_color.dart';
import 'package:eux_client/resources/font_manager.dart';
import 'package:eux_client/resources/styles_manager.dart';
import 'package:eux_client/resources/app_values.dart';
import 'package:flutter/material.dart';

ThemeData getAppTheme() {
  return ThemeData(
    // main colors
    primaryColor: AppColor.primary,
    primaryColorDark: AppColor.simpleBlack,
    disabledColor: AppColor.grey1,
    splashColor: AppColor.simpleGrey,

    // Card Theme
    cardTheme: CardThemeData(
      color: AppColor.white,
      shadowColor: AppColor.grey,
      elevation: AppSize.s8,
    ),
    // AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.primary,
      centerTitle: true,
      elevation: AppSize.s4,
      shadowColor: AppColor.white,
      titleTextStyle: getSemiBoldStyle(
        color: AppColor.white,
        fontSize: FontSize.s18,
      ),
    ),

    // Button Theme
    buttonTheme: ButtonThemeData(
      shape: StadiumBorder(),
      disabledColor: AppColor.grey1,
      buttonColor: AppColor.primary,
      splashColor: AppColor.simpleGrey,
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getMediumStyle(
          color: AppColor.white,
          fontSize: FontSize.s16,
        ),
        backgroundColor: AppColor.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
      ),
    ),
    // Text theme
    // Here I should make the theme looks like each other
    // We Had Three Different Headings
    textTheme: TextTheme(
      displayLarge: getBlackStyle(
        color: AppColor.black,
        fontSize: FontSize.s32,
      ),
      headlineLarge: getBoldStyle(
        color: AppColor.black,
        fontSize: FontSize.s24,
      ),
      headlineMedium: getBoldStyle(
        color: AppColor.black,
        fontSize: FontSize.s16,
      ),
      // We Had Two Different body
      bodyLarge: getMediumStyle(color: AppColor.black, fontSize: FontSize.s24),
      bodyMedium: getMediumStyle(color: AppColor.black, fontSize: FontSize.s16),
      bodySmall: getRegularStyle(color: AppColor.black, fontSize: FontSize.s12),
    ),

    // input decoration theme (text form field)
    // inputDecorationTheme: InputDecorationTheme(
    //   contentPadding: EdgeInsets.all(AppPadding.p8),
    //   hintStyle: getRegularStyle(
    //     color: AppColor.grey,
    //     fontSize: FontSize.s14,
    //   ),
    //   labelStyle: getRegularStyle(
    //     color: AppColor.grey,
    //     fontSize: FontSize.s14,
    //   ),
    //   errorStyle: getRegularStyle(
    //     color: AppColor.error,
    //     fontSize: FontSize.s14,
    //   ),
    //   // Enable Border Style
    //   enabledBorder: OutlineInputBorder(
    //     borderSide: BorderSide(
    //       color: AppColor.primary,
    //       width: AppSize.s1_5,
    //     ),
    //     borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
    //   ),
    //   // Focus Border Style
    //   focusedBorder: OutlineInputBorder(
    //     borderSide: BorderSide(color: AppColor.grey, width: AppSize.s1_5),
    //     borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
    //   ),
    //   // Focus Error Border Style
    //   focusedErrorBorder: OutlineInputBorder(
    //     borderSide: BorderSide(
    //       color: AppColor.primary,
    //       width: AppSize.s1_5,
    //     ),
    //     borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
    //   ),
    //   // Error Border Style
    //   errorBorder: OutlineInputBorder(
    //     borderSide: BorderSide(color: AppColor.error, width: AppSize.s1_5),
    //     borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
    //   ),
    // ),
  );
}
