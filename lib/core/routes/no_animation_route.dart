import 'package:flutter/material.dart';

class NoAnimationPageRoute<T> extends PageRouteBuilder<T> {
  NoAnimationPageRoute({
    required WidgetBuilder builder,
    super.settings,
    this.withFade = false,
  }) : super(
         pageBuilder: (context, animation, secondaryAnimation) =>
             builder(context),
         transitionDuration: Duration.zero,
         reverseTransitionDuration: Duration.zero,
         transitionsBuilder: (context, animation, secondaryAnimation, child) {
           if (withFade) {
             return FadeTransition(opacity: animation, child: child);
           }
           return child;
         },
       );

  /// Optional fade instead of instant switch
  final bool withFade;
}
