import 'package:flutter/material.dart';
import 'package:happy_chicken_restaurant/utils/exstation.dart';

import '../../../utils/styles.dart';


class TextWithValue extends StatelessWidget {
  final String title;
  final String value;
  final Color? titleColor;
  final Color? valueColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  const TextWithValue({
    super.key,
    required this.title,
    required this.value, this.titleColor, this.valueColor, this.fontSize, this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: title, // Second part (styled differently)
            style:Styles.styles16(context)
                .copyWith(color:titleColor ??  context.colorScheme.primary,fontWeight: fontWeight,fontSize: fontSize),
          ),
          TextSpan(
            text: value, // Second part (styled differently)
            style:  Styles.styles16(context).copyWith(color: valueColor),
          ),
        ],
      ),
    );
  }
}
