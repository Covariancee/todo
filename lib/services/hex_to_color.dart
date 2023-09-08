import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

IconData? getIconFromJson(String iconName) {
  switch (iconName) {
    case "Icons.shopping_cart":
      return Icons.shopping_cart;
    case "Icons.work":
      return Icons.work;
    case "Icons.home":
      return Icons.home;
    case "Icons.person":
      return Icons.person;
    case "Icons.favorite":
      return Icons.favorite;
    case "Icons.school":
      return Icons.school;
    case "Icons.fitness_center":
      return Icons.fitness_center;
    case "Icons.attach_money":
      return Icons.money;
    case "Icons.category":
      return Icons.category;
    default:
      return Icons.add;
  }
}

String getPriorityFromNumber(int priority) {
  switch (priority) {
    case 1:
      return '1';
    case 2:
      return '2';
    case 3:
      return '3';
    case 4:
      return '4';
    case 5:
      return '5';
    case 6:
      return '6';

    default:
      return 'not at all';
  }
}
