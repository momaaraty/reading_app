import 'package:flutter/material.dart';
import '../models/book.dart';
import '../data/mock_data.dart';

class BooksProvider extends ChangeNotifier {
  List<Book> _books = MockData.books;
  List<Book> _filteredBooks = [];

  List<Book> get books => _books;
  List<Book> get filteredBooks =>
      _filteredBooks.isEmpty ? _books : _filteredBooks;

  void loadBooks() {
    _books = MockData.books;
    notifyListeners();
  }

  void filterByCategory(String category) {
    if (category == "All") {
      _filteredBooks = [];
    } else {
      _filteredBooks = _books
          .where((book) => book.category == category)
          .toList();
    }
    notifyListeners();
  }

  void addBook(Book book) {
    _books.add(book);
    notifyListeners();
  }

  void removeBook(String id) {
    _books.removeWhere((book) => book.id == id);
    notifyListeners();
  }

  Book? getBookById(String id) {
    return _books.firstWhere((book) => book.id == id);
  }
}
