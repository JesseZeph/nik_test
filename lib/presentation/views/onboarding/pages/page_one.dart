import 'package:flutter/material.dart';
import 'package:niklaar/core/constants/constants.dart';
import 'package:niklaar/presentation/views/onboarding/components/onboard_text.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Image.asset('assets/images/page-one.png'),
        ),

        Positioned(
          top: height * 0.15,
          left: 0,
          right: 0,
          child: OnboardingTexts(
            title: 'Borderless Payments, Instant Transfers',
            subtitle:
                'Enjoy seamless money transfers and hassle-free transactions.',
          ),
        ),
      ],
    );
  }
}
