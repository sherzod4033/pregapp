import 'package:flutter/material.dart';

/// App color palette - Soft Glassmorphism theme
/// Pastel gradients with warm peach, soft cream, and dusty pink
class AppColors {
  AppColors._();

  // Primary gradient colors
  static const Color peach = Color(0xFFFECBBA);
  static const Color cream = Color(0xFFFFF5EB);
  static const Color dustyPink = Color(0xFFF8C8DC);
  static const Color softRose = Color(0xFFFFE4EC);
  static const Color warmWhite = Color(0xFFFFFBF8);

  // Accent colors
  static const Color coral = Color(0xFFFF8C7C);
  static const Color salmonPink = Color(0xFFFF9A9E);
  static const Color lightPink = Color(0xFFFAD0C4);

  // Glass effect colors
  static const Color glassWhite = Color(0xB3FFFFFF); // 70% opacity
  static const Color glassBorder = Color(0x4DFFFFFF); // 30% opacity
  static const Color glassOverlay = Color(0x1AFFFFFF); // 10% opacity

  // Text colors
  static const Color textDark = Color(0xFF4A3F35);
  static const Color textMedium = Color(0xFF7D6E5D);
  static const Color textLight = Color(0xFFA99B8A);

  // Status colors
  static const Color success = Color(0xFF7DD3A7);
  static const Color warning = Color(0xFFFFB347);
  static const Color danger = Color(0xFFFF7B7B);

  // Background gradient
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      peach,
      cream,
      dustyPink,
      softRose,
    ],
    stops: [0.0, 0.35, 0.7, 1.0],
  );

  // Primary button gradient
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      salmonPink,
      coral,
    ],
  );

  // Hero card gradient
  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFFFE4E9),
      Color(0xFFFFC7D8),
    ],
  );
}
