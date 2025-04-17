import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niklaar/core/constants/constants.dart';
import 'package:niklaar/core/theme/app_colors.dart';
import 'package:niklaar/shared/widgets/custom_text.dart';

class CustomAuthHeader extends StatelessWidget {
  final bool showBackButton;
  final bool showSignInButton;
  final bool showImage;
  final Widget? widget;
  final Function()? onTap;
  const CustomAuthHeader({
    super.key,
    required this.context,
    this.showBackButton = true,
    this.showSignInButton = true,
    this.showImage = true,
    this.widget,
    this.onTap,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: height * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (showBackButton)
            InkWell(
              onTap: () => context.router.maybePop(),
              child: const Icon(Icons.arrow_back),
            )
          else
            const SizedBox(),

          if (showImage) Image.asset('assets/images/nik.png', height: 30),

          if (widget != null)
            widget!
          else if (showSignInButton)
            InkWell(
              onTap: onTap,
              child: NikText(
                text: 'Sign In',
                size: 16,
                color: AppColor.secondary,
              ),
            )
          else
            const SizedBox(),
        ],
      ),
    );
  }
}
