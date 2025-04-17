import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:niklaar/core/constants/constants.dart';
import 'package:niklaar/core/theme/app_colors.dart';
import 'package:niklaar/presentation/controllers/onboarding_controller.dart';
import 'package:niklaar/presentation/views/onboarding/pages/page_five.dart';
import 'package:niklaar/presentation/views/onboarding/pages/page_four.dart';
import 'package:niklaar/presentation/views/onboarding/pages/page_one.dart';
import 'package:niklaar/presentation/views/onboarding/pages/page_three.dart';
import 'package:niklaar/presentation/views/onboarding/pages/page_two.dart';
import 'package:niklaar/shared/widgets/custom_text.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

@RoutePage(name: 'OnboardingRoute')
class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  late OnboardingController _controller;

  @override
  void initState() {
    super.initState();
    final pages = [
      const PageOne(),
      const PageTwo(),
      const PageThree(),
      const PageFour(),
      const PageFive(),
    ];
    _controller = OnboardingController(pages: pages);

    _controller.currentPageNotifier.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLastPage = _controller.isLastPage;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColor.secondary, AppColor.primary],
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView.builder(
              controller: _controller.pageController,
              itemCount: _controller.pages.length,
              itemBuilder: (context, index) => _controller.pages[index],
            ),
            if (!isLastPage)
              Positioned(
                top: height * 0.08,
                right: width * 0.05,
                child: InkWell(
                  onTap: _controller.skipToLastPage,
                  child: NikText(
                    text: 'Skip',
                    size: 14,
                    color: Colors.white,
                    weight: FontWeight.w600,
                  ),
                ),
              ),
            if (!isLastPage)
              Positioned(
                bottom: height * 0.14,
                child: SmoothPageIndicator(
                  controller: _controller.pageController,
                  count: _controller.pages.length,
                  effect: ExpandingDotsEffect(
                    dotColor: AppColor.lightPrimary,
                    activeDotColor: AppColor.primary,
                    dotHeight: 8.h,
                    dotWidth: 8.w,
                    expansionFactor: 3,
                    spacing: 8.w,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
