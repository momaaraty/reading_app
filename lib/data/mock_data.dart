import '../models/book.dart';

class MockData {
  static List<Book> books = [
    Book(
      id: "1",
      title: "Atomic Habits",
      author: "James Clear",
      coverImagePath:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpRLCMrwvEX8iBrELwwPi35qpYreJtL6-r2Q&s",
      rating: 4.5,
      pages: 320,
      category: "Self Development",
    ),
    Book(
      id: "2",
      title: "Psychology of Money",
      author: "Morgan Housel",
      coverImagePath:
          "https://s26162.pcdn.co/wp-content/uploads/2018/02/gatsby-original2.jpg",
      rating: 4.8,
      pages: 250,
      category: "Finance",
    ),
    Book(
      id: "3",
      title: "Psychology of Money",
      author: "Morgan Housel",
      coverImagePath:
          "https://s26162.pcdn.co/wp-content/uploads/2018/02/gatsby-original2.jpg",
      rating: 4.8,
      pages: 250,
      category: "Finance",
    ),
  ];
}
