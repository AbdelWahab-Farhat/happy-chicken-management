import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageWithOverLay extends StatelessWidget {
  const ImageWithOverLay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.4.sh,
      child: Stack(
        children: [
          Image.asset(
            "lib/assets/images/login_background.png",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            color: Colors.black.withValues(alpha: 0.3),
          ),
        ],
      ),
    );
  }
}
