import 'package:flutter/material.dart';
import 'package:niklaar/core/constants/constants.dart';
import 'package:niklaar/presentation/views/onboarding/components/onboard_text.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Image.asset('assets/images/page-two.png'),
        ),
        Positioned(
          top: height * 0.15,
          left: 0,
          right: 0,
          child: OnboardingTexts(
            title: 'Discover & Share the Best Deals',
            subtitle:
                'Explore amazing deals or share your own with the community',
          ),
        ),
      ],
    );
  }
}
