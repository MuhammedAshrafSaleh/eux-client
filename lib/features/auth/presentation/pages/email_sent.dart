import 'package:eux_client/common/widgets/app_button.dart';
import 'package:eux_client/resources/app_assets.dart';
import 'package:eux_client/resources/routes_manager.dart';
import 'package:eux_client/resources/app_strings.dart';
import 'package:eux_client/resources/app_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmailSentPage extends StatelessWidget {
  const EmailSentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(AppAssets.emailSend),
            CustomAppButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, Routes.signIn);
              },
              title: AppStrings.returnLogin,
            ),
          ],
        ),
      ),
    );
  }
}
