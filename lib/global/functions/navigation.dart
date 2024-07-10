import 'package:flutter/material.dart';

void navigateToNextScreen(context, widget) =>
    Navigator.of(context).push(SliderRight(page: widget));

void navigateAndFinishThisScreen(context, widget) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (Route<dynamic> route) => false,
    );
void navigateAndReplace(context, widget) =>
    Navigator.pushReplacementNamed(context, widget);

class SliderRight extends PageRouteBuilder {
  final page;
  SliderRight({required this.page})
      : super(
            pageBuilder: (context, animation, animationTwo) => page,
            transitionsBuilder: (context, animation, animationTwo, child) {
              var begin = const Offset(-1.0, 0.0);
              var end = Offset.zero;
              var curve = Curves.easeInOut;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            });
}
