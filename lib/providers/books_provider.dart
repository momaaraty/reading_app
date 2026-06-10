import 'package:flutter/material.dart';
import '../models/book.dart';
import '../data/mock_data.dart';

class BooksProvider extends ChangeNotifier {
  List<Book> _books = [];
  List<Book> _filteredBooks = [];

  // =========================
  // STATE
  // =========================
  bool _initialized = false;
  bool get initialized => _initialized;

  String _status = "Idle";
  String get status => _status;

  List<Book> get books => _books;

  List<Book> get filteredBooks =>
      _filteredBooks.isEmpty ? _books : _filteredBooks;

  void _setStatus(String value) {
    _status = value;
    notifyListeners();
  }

  // =========================
  // LOAD BOOKS (SMART SPLASH SUPPORT)
  // =========================
  Future<void> loadBooks() async {
    _setStatus("Loading books...");

    await Future.delayed(const Duration(milliseconds: 800));

    _books = MockData.books;

    _setStatus("Preparing library...");

    await Future.delayed(const Duration(milliseconds: 400));

    _initialized = true;

    _setStatus("Books ready");

    notifyListeners();
  }

  // =========================
  // FILTER
  // =========================
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

  // =========================
  // ADD BOOK
  // =========================
  void addBook(Book book) {
    _books.add(book);
    notifyListeners();
  }

  // =========================
  // REMOVE BOOK
  // =========================
  void removeBook(String id) {
    _books.removeWhere((book) => book.id == id);
    notifyListeners();
  }

  // =========================
  // GET BOOK
  // =========================
  Book? getBookById(String id) {
    try {
      return _books.firstWhere((book) => book.id == id);
    } catch (_) {
      return null;
    }
  }

  // =========================
  // PROGRESS UPDATE
  // =========================
  void updateReadingProgress(String bookId, double progress) {
    final index = _books.indexWhere((book) => book.id == bookId);

    if (index == -1) return;

    _books[index] = _books[index].copyWith(readingProgress: progress);

    notifyListeners();
  }
}
