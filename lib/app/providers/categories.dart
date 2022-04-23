import 'package:dionys/app/models/category.dart';
import 'package:flutter/material.dart';

class Categories with ChangeNotifier {
  List<Category> _categories = [];
  List<Category> get categories {
    return [..._categories];
  }

  void initializeCategories(List<Category> categories) {
    _categories.addAll(categories);
    notifyListeners();
  }
}
