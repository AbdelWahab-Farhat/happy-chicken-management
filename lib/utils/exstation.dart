import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}

extension NavigationExtension on BuildContext {
  void push(Widget page) {
    Navigator.of(this).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return page;
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
      ),
    );
  }

  void pushFade(Widget page) {
    Navigator.of(this).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return page;
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeScaleTransition(
            animation: animation,
            child: child,
          );
        },
      ),
    );
  }

  void pushSlide(
      {required Widget page, AxisDirection direction = AxisDirection.right}) {
    Navigator.of(this).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return page;
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final offsetAnimation = Tween<Offset>(
            begin: _getSlideOffset(direction, Directionality.of(context)),
            end: Offset.zero,
          ).animate(animation);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  void pushReplacement(Widget page) {
    Navigator.of(this).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return page;
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
      ),
    );
  }

  // استبدال كل الصفحات السابقة
  void pushAndRemoveUntil(Widget page, [RoutePredicate? predicate]) {
    Navigator.of(this).pushAndRemoveUntil(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return page;
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
      ),
      predicate ?? (route) => false,
    );
  }

  void pop([dynamic result]) {
    Navigator.of(this).pop(result);
  }

  Offset _getSlideOffset(AxisDirection direction, TextDirection textDirection) {
    switch (direction) {
      case AxisDirection.up:
        return const Offset(0, 1);
      case AxisDirection.down:
        return const Offset(0, -1);
      case AxisDirection.left:
        return textDirection == TextDirection.rtl
            ? const Offset(-1, 0)
            : const Offset(1, 0);
      case AxisDirection.right:
        return textDirection == TextDirection.rtl
            ? const Offset(1, 0)
            : const Offset(-1, 0);
    }
  }
}


extension DateFormat on DateTime {
  String format() {
    return "$year-$month-$day";
  }
}