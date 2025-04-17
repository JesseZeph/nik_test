import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:niklaar/shared/widgets/custom_text.dart';

class OnboardingTexts extends StatelessWidget {
  final String title;
  final String subtitle;
  const OnboardingTexts({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        spacing: 20,
        children: [
          NikText(
            text: title,
            size: 32,
            weight: FontWeight.w800,
            color: Colors.white,
          ),
          NikText(text: subtitle, size: 14, color: Colors.white),
        ],
      ),
    );
  }
}
