import 'package:budget_app/screen/category/view/add_category.dart';
import 'package:budget_app/screen/entry/view/entry_screen.dart';
import 'package:budget_app/screen/home/view/home_screen.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> screen = {
  '/': (context) => const HomeScreen(),
  'addCate': (context) => const AddCategoryScreen(),
  'cate': (context) => const EntryScreen(),
};
