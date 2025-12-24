import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/styles.dart';


class CustomFormField extends StatelessWidget {
  final String hint;
  final String? Function(String?)? validator;
  final bool isPassword;
  final Function(String?)? onSaved;
  const CustomFormField({
    super.key,
    required this.hint,
    this.validator,
    this.onSaved,  this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      validator: validator,
      style: Styles.styles16(context),
      obscureText: isPassword,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            gapPadding: 12,
            borderRadius: BorderRadius.circular(12.r),
          ),
          hintText: hint,
          hintStyle: Styles.styles16(context).copyWith(color: Colors.grey)),
    );
  }
}
