import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:niklaar/core/theme/app_colors.dart';
import 'package:niklaar/shared/widgets/custom_text.dart';

class AuthSteps extends StatelessWidget {
  final String text;
  final bool isActive;
  final bool showCheckmark;

  const AuthSteps({
    super.key,
    required this.text,
    required this.isActive,
    this.showCheckmark = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isActive ? AppColor.primaryText : Colors.transparent,
        border:
            !isActive
                ? Border.all(color: AppColor.nikGrey.withAlpha(60))
                : null,
        borderRadius: BorderRadius.circular(100.r),
      ),
      child: Row(
        spacing: 10,
        children: [
          NikText(
            text: text,
            size: 12,
            color: isActive ? Colors.white : AppColor.nikGrey,
            weight: FontWeight.w500,
          ),
          if (showCheckmark)
            Icon(Icons.check, size: 12, color: AppColor.secondary),
        ],
      ),
    );
  }
}
