import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xyz/models/category.dart';

class CategoryProvider extends ChangeNotifier {
  CategoryProvider() {
    init();
  }

  List<Category> category = [];

  Future<void> init() async {
    String file = await rootBundle.loadString('assets/json/category.json');
    List<Category> jsonData = jsonDecode(file);
    category = jsonData
        .map((e) => Category.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  notifyListeners();
}

// Future<void> getCategories() async {
//   final String jsonString =
//       await rootBundle.loadString('assets/json/category.json');
//   final Map<String, dynamic> jsonData = json.decode(jsonString);
//   category = jsonData
//       .map((jsonCategory) => Category.fromJson(jsonCategory))
//       .toList();
