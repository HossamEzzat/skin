import 'dart:ui';

import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: Stack(
        children: [
          // 1. Base Layer: Subtle Linear Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  colorScheme.surface,
                  Color.lerp(colorScheme.surface, colorScheme.primary, 0.05)!,
                ],
              ),
            ),
          ),

          // 2. Decorative Layer: Blurred "Blobs"
          Positioned.fill(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    // Top Left Primary Glow
                    _AnimatedBlob(
                      width: constraints.maxWidth * 0.8,
                      height: constraints.maxWidth * 0.8,
                      top: -constraints.maxWidth * 0.2,
                      left: -constraints.maxWidth * 0.2,
                      color: colorScheme.primary.withOpacity(0.15),
                    ),
                    // Bottom Right Secondary Glow
                    _AnimatedBlob(
                      width: constraints.maxWidth * 0.9,
                      height: constraints.maxWidth * 0.9,
                      bottom: -constraints.maxWidth * 0.3,
                      right: -constraints.maxWidth * 0.3,
                      color: colorScheme.secondary.withOpacity(0.12),
                    ),
                  ],
                );
              },
            ),
          ),

          // 3. Glassmorphism Blur Overlay
          // This blends the blobs together into a smooth "mesh"
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
              child: Container(color: Colors.transparent),
            ),
          ),

          // 4. Content Layer
          SafeArea(child: child),
        ],
      ),
    );
  }
}

class _AnimatedBlob extends StatelessWidget {
  final double width, height;
  final double? top, left, bottom, right;
  final Color color;

  const _AnimatedBlob({
    required this.width,
    required this.height,
    required this.color,
    this.top,
    this.left,
    this.bottom,
    this.right,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      bottom: bottom,
      right: right,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      ),
    );
  }
}
