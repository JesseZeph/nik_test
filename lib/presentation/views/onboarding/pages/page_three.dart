import 'package:flutter/material.dart';
import 'package:niklaar/core/constants/constants.dart';
import 'package:niklaar/presentation/views/onboarding/components/onboard_text.dart';

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Image.asset('assets/images/page-three.png'),
        ),
        Positioned(
          top: height * 0.15,
          left: 0,
          right: 0,
          child: OnboardingTexts(
            title: 'Unlock Exclusive Discounts',
            subtitle:
                'Get more visibility and increase sales by listing on influencer pages on the discount markert',
          ),
        ),
      ],
    );
  }
}
