import 'package:flutter/material.dart';
import 'package:niklaar/core/constants/constants.dart';
import 'package:niklaar/presentation/views/onboarding/components/onboard_text.dart';

class PageFour extends StatelessWidget {
  const PageFour({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Image.asset('assets/images/page-four.png'),
        ),
        Positioned(
          top: height * 0.15,
          left: 0,
          right: 0,
          child: OnboardingTexts(
            title: 'Build & Track Your Credit Score',
            subtitle:
                'Stay credible and trustworthy by shopping, reviewing, and engaging with deals.',
          ),
        ),
      ],
    );
  }
}
