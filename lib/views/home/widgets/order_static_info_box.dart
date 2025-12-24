import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_chicken_restaurant/utils/exstation.dart';
import 'package:happy_chicken_restaurant/utils/styles.dart';

class OrderStaticInfoBox extends StatelessWidget {
  final String number;
  final String title;
  final VoidCallback? onTap; // Optional click action

  const OrderStaticInfoBox({
    super.key,
    required this.number,
    required this.title,
    this.onTap, // Allows custom tap functionality
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        splashColor: context.colorScheme.primary.withValues(alpha: 0.2),
        highlightColor: context.colorScheme.primary.withValues(alpha: 0.1),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: context.colorScheme.secondaryContainer.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: context.colorScheme.onSurface.withValues(alpha: 0.2),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: context.colorScheme.onSurface.withValues(alpha: 0.08),
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            children: [
              Text(
                number,
                style: Styles.styles16(context).copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
              Divider(
                thickness: 1,
                color: context.colorScheme.onSurface.withValues(alpha: 0.3),
                height: 10,
                indent: 20.w,
                endIndent: 20.w,
              ),
              Text(
                title,
                style: Styles.styles16(context).copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
