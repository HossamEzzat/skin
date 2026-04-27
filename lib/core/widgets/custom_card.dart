import 'dart:ui';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final Color? color;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? height;
  final double? width;
  final BoxBorder? border;
  final bool isGlass;

  const CustomCard({
    super.key,
    required this.child,
    this.color,
    this.borderRadius,
    this.padding,
    this.margin,
    this.height,
    this.width,
    this.border,
    this.isGlass = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    Widget content = Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: isGlass 
            ? (color ?? Colors.white).withValues(alpha: 0.2)
            : (color ?? theme.cardColor),
        borderRadius: borderRadius ?? BorderRadius.circular(20),
        border: border ??
            Border.all(
              color: isGlass 
                  ? Colors.white.withValues(alpha: 0.3)
                  : theme.dividerColor.withValues(alpha: 0.1),
            ),
        boxShadow: isGlass ? null : [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );

    if (isGlass) {
      return ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: content,
        ),
      );
    }
    
    return content;
  }
}
