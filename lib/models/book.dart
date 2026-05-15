class Book {
  final String id;
  final String title;
  final String author;
  final String? description;
  final String? coverImagePath;
  final double rating;
  final int? pages;
  final DateTime? publishedDate;
  final String category;

  Book({
    required this.id,
    required this.title,
    required this.author,
    this.description,
    this.coverImagePath,
    this.rating = 0.0,
    this.pages,
    this.publishedDate,
    required this.category,
  });

  Book copyWith({
    String? id,
    String? title,
    String? author,
    String? description,
    String? coverImagePath,
    double? rating,
    int? pages,
    DateTime? publishedDate,
    String? category,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      description: description ?? this.description,
      coverImagePath: coverImagePath ?? this.coverImagePath,
      rating: rating ?? this.rating,
      pages: pages ?? this.pages,
      publishedDate: publishedDate ?? this.publishedDate,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'description': description,
      'coverImagePath': coverImagePath,
      'rating': rating,
      'pages': pages,
      'publishedDate': publishedDate?.toIso8601String(),
      'category': category,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'] as String,
      title: map['title'] as String,
      author: map['author'] as String,
      description: map['description'] as String?,
      coverImagePath: map['coverImagePath'] as String?,
      rating: (map['rating'] is int)
          ? (map['rating'] as int).toDouble()
          : (map['rating'] as double? ?? 0.0),
      pages: map['pages'] as int?,
      publishedDate: map['publishedDate'] != null
          ? DateTime.parse(map['publishedDate'] as String)
          : null,
      category: map['category'] as String,
    );
  }

  @override
  String toString() => 'Book(id: $id, title: $title, author: $author)';
}
