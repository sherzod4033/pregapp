import 'package:flutter/material.dart';

class NutritionTopic {
  final String title;
  final String subtitle;
  final String imagePath;
  final Color color;
  final String content;

  const NutritionTopic({
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.color,
    required this.content,
  });
}
