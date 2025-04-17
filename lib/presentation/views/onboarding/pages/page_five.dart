import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:niklaar/core/constants/constants.dart';
import 'package:niklaar/shared/widgets/buttons/animated_button.dart';
import 'package:niklaar/shared/widgets/buttons/roundedbutton.dart';
import 'package:niklaar/shared/widgets/custom_text.dart';

class PageFive extends StatelessWidget {
  const PageFive({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Image.asset('assets/images/page-four.png'),
        ),
        Positioned(
          bottom: height * 0.1,
          left: 0,
          right: 0,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              spacing: 30,
              children: [
                AnimatedButton(
                  onTap: () {
                    context.router.pushNamed('/select-country');
                  },
                  child: CustomButton(
                    title: 'Create an account',
                    color: Colors.white,
                    textColor: Colors.black,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: NikText(
                    text: 'Sign in',
                    size: 16,
                    color: Colors.white,
                    weight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: height * 0.2,
          left: 0,
          right: 0,
          child: Image.asset(
            'assets/images/logo-white.png',
            width: 100,
            height: 50,
          ),
        ),
      ],
    );
  }
}
