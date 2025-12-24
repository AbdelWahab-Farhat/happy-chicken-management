import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_chicken_restaurant/utils/exstation.dart';

import '../utils/styles.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final double? width;
  final double? height;
  final Color? textColor;
  final Color? backgroundColor;
  final Function()? onPressed;
  const CustomButton({
    super.key,
    required this.title,
    this.width,
    this.height,
    this.onPressed, this.textColor, this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        overlayColor: Colors.black.withValues(alpha: 0.1),
        backgroundColor: backgroundColor ??  context.colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        minimumSize: Size(width?.w ?? double.infinity, height?.h ?? 40.h),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: Styles.styles20(context)
            .copyWith(color: textColor ??  context.colorScheme.surface),
      ),
    );
  }
}
