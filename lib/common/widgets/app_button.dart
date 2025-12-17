import 'package:eux_client/resources/app_color.dart';
import 'package:eux_client/resources/app_values.dart';
import 'package:eux_client/resources/font_manager.dart';
import 'package:flutter/material.dart';

class CustomAppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Widget? content;
  final double? height;
  final double? width;
  final double borderRadiusSize;
  final Color? bgColor;
  final Color? textColor;
  const CustomAppButton({
    required this.onPressed,
    this.title = '',
    this.height,
    this.width,
    this.content,
    this.borderRadiusSize = AppSize.s25,
    this.bgColor,
    this.textColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(
          width ?? MediaQuery.of(context).size.width,
          height ?? AppSize.s50,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadiusSize),
        ),
        backgroundColor: bgColor ?? AppColor.primary,
      ),
      child:
          content ??
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: textColor ?? AppColor.white,
              fontSize: FontSize.s14,
            ),
          ),
    );
  }
}
