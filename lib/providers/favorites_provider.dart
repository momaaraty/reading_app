import 'package:flutter/material.dart';
import '../models/book.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<Book> _favorites = [];

  List<Book> get favorites => _favorites;

  bool isFavorite(Book book) {
    return _favorites.contains(book);
  }

  void addToFavorites(Book book) {
    if (!_favorites.contains(book)) {
      _favorites.add(book);
      notifyListeners();
    }
  }

  void removeFromFavorites(Book book) {
    _favorites.remove(book);
    notifyListeners();
  }

  void toggleFavorite(Book book) {
    if (isFavorite(book)) {
      removeFromFavorites(book);
    } else {
      addToFavorites(book);
    }
  }
}