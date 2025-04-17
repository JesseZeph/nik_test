import 'dart:async';
import 'package:flutter/material.dart';

class OnboardingController {
  final PageController pageController = PageController();
  Timer? autoAnimateTimer;
  final List<Widget> pages;
  final int lastPageIndex;
  final ValueNotifier<int> currentPageNotifier = ValueNotifier<int>(0);

  OnboardingController({required this.pages})
    : lastPageIndex = pages.length - 1 {
    _setupPageController();
    startAutoAnimation();
  }

  void _setupPageController() {
    pageController.addListener(() {
      int page = pageController.page?.round() ?? 0;
      if (currentPageNotifier.value != page) {
        currentPageNotifier.value = page;
      }
    });
  }

  void startAutoAnimation() {
    autoAnimateTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (currentPageNotifier.value < pages.length - 1) {
        pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        autoAnimateTimer?.cancel();
      }
    });
  }

  void skipToLastPage() {
    pageController.animateToPage(
      lastPageIndex,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  bool get isLastPage => currentPageNotifier.value == lastPageIndex;

  void dispose() {
    autoAnimateTimer?.cancel();
    pageController.dispose();
    currentPageNotifier.dispose();
  }
}
