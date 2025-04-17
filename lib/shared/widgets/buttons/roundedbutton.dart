import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:niklaar/core/theme/app_colors.dart';
import 'package:niklaar/shared/widgets/custom_text.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final double? size;
  final Function()? onTap;
  final Color? color, textColor;
  final Color? borderColor;
  final double? borderRadius;

  const CustomButton({
    super.key,
    required this.title,
    this.onTap,
    this.size,
    this.color,
    this.borderColor,
    this.textColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      material: (_, __) => _buildMaterialButton(context),
      cupertino: (_, __) => _buildCupertinoButton(context),
    );
  }

  Widget _buildMaterialButton(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 11.r),
          color: color ?? AppColor.primary,
          border:
              borderColor != null
                  ? Border.all(width: 1, color: borderColor!)
                  : null,
        ),
        child: Center(
          child: NikText(
            text: title,
            align: TextAlign.center,
            color: textColor ?? Colors.white,
            weight: FontWeight.w600,
            size: size ?? 16.spMin,
          ),
        ),
      ),
    );
  }

  Widget _buildCupertinoButton(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
          color: color ?? CupertinoColors.activeBlue,
          border:
              borderColor != null
                  ? Border.all(width: 1, color: borderColor!)
                  : null,
        ),
        child: Center(
          child: NikText(
            text: title,
            align: TextAlign.center,
            color: textColor ?? CupertinoColors.white,
            weight: FontWeight.w600,
            size: size ?? 16.spMin,
          ),
        ),
      ),
    );
  }
}
