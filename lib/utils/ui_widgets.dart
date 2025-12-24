import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_chicken_restaurant/utils/styles.dart';


import '../widgets/custom_button.dart';

void showCustomSnackBar(BuildContext context, String message,
    {int durationInSeconds = 2 , void Function()? functionAfterDelay , double? bottomPosition}) {
  // Create an overlay entry
  OverlayEntry overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: bottomPosition,
      top: bottomPosition == null ?  70.h  : null,
      left: 20.w,
      right: 20.w,
      child: Material(
        color: Colors.transparent,
        child: Opacity(
          opacity: 0.7,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurface,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.surface),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    ),
  );

  // Insert the overlay entry into the overlay
  Overlay.of(context).insert(overlayEntry);

  // Remove the overlay entry after the specified duration
  Future.delayed(Duration(seconds: durationInSeconds), () {
    functionAfterDelay;
    overlayEntry.remove();
  });
}

void showCustomDialog({
  required BuildContext context,
  required String title,
  required String description,
  required String image,
  String? confirmButtonTitle,
  void Function()? onConfirm,
  void Function()? onOtherOption,
  isDismissible = true,
  final String? otherOptionButtonTitle,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return _AnimatedDialog(
        title: title,
        description: description,
        image: image,
        onConfirm: onConfirm,
        onOtherOption: onOtherOption,
        otherOptionButtonTitle: otherOptionButtonTitle,
        confirmButtonTitle: confirmButtonTitle,
      );
    },
  );
}

class _AnimatedDialog extends StatefulWidget {
  final String title;
  final String description;
  final String image;
  final void Function()? onConfirm;
  final void Function()? onOtherOption;
  final String? confirmButtonTitle;
  final String? otherOptionButtonTitle;


  const _AnimatedDialog({
    required this.title,
    required this.description,
    required this.image,
    this.onConfirm,
    this.onOtherOption,
    this.otherOptionButtonTitle, this.confirmButtonTitle,
  });

  @override
  State<_AnimatedDialog> createState() => _AnimatedDialogState();
}

class _AnimatedDialogState extends State<_AnimatedDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.forward(); // Start the animation when the dialog opens
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        contentPadding: EdgeInsets.all(16.0),
        content: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            spacing: 16.h,
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.image.isNotEmpty ? AspectRatio(
                aspectRatio: 1 / 0.85,
                child:  Image.asset(
                  widget.image,
                  fit: BoxFit.cover,
                ),
              ) : SizedBox(),
              Text(
                widget.title,
                style: Styles.styles20(context),
                textAlign: TextAlign.center,
              ),
              Text(
                widget.description,
                style: Styles.styles16(context).copyWith(fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        actions: [
          Center(
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                widget.onConfirm != null ? CustomButton(
                  title: widget.confirmButtonTitle ?? 'تأكيد',
                  onPressed: widget.onConfirm,
                ) : Container(),

                CustomButton(
                  title: widget.otherOptionButtonTitle == null ? 'اغلاق' : widget.otherOptionButtonTitle!,
                  onPressed: () {
                    if (widget.onOtherOption == null) {
                      Navigator.pop(context);
                    } else {
                      widget.onOtherOption!();
                    }
                  },
                ) ,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void showLogoutBottomSheet(BuildContext context, void Function()? onConfirm,
    void Function()? onCancel) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: 0.25.sh,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min, // Minimize the height
            children: [
              Text(
                'تسجيل خروج',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 10),
              Text('هل أنت متأكد من رغبتك في تسجيل الخروج؟',
                  textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButton(
                    title: 'خروج',
                    width: 0.35.sw,
                    height: 45,
                    onPressed: onConfirm,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CustomButton(
                    title: 'الغاء',
                    width: 0.35.sw,
                    height: 45,
                    onPressed: onCancel,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
