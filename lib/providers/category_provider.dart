import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'books_provider.dart';

class CategoryProvider extends ChangeNotifier {
  String _selected = "All";

  String get selected => _selected;

  void change(BuildContext context, String value) {
    if (_selected == value) return;
    _selected = value;
    final booksProvider = Provider.of<BooksProvider>(context, listen: false);
    booksProvider.filterByCategory(value);
    notifyListeners();
  }
}
