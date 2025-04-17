import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:niklaar/core/theme/app_colors.dart';

class PageLoader extends StatelessWidget {
  const PageLoader({super.key, required this.child, required this.isLoading});
  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      color: AppColor.nikGrey.withValues(alpha: 0.7),
      progressIndicator: const CircularProgressIndicator(),
      isLoading: isLoading,
      child: PopScope(canPop: !isLoading, child: child),
    );
  }
}
