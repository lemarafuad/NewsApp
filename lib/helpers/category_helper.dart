import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryHelper {
  static final List<String> categories = [
    "general",
    "science",
    "business",
    "health",
    "sports",
    "technology",
  ];

  static IconData getIconForCategory(String category) {
    switch (category) {
      case 'general':
        return Icons.home;
      case 'science':
        return Icons.science;
      case 'business':
        return Icons.business;
      case 'health':
        return Icons.health_and_safety;
      case 'sports':
        return Icons.sports;
      case 'technology':
        return Icons.computer;
      default:
        return Icons.category;
    }
  }

  static String getLabelForCategory(String category) {
    return category.capitalizeFirst!;
  }
}
