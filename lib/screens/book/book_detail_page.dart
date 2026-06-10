import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/book.dart';
import '../../providers/favorites_provider.dart';
import '../../providers/books_provider.dart';

class BookDetailPage extends StatefulWidget {
  const BookDetailPage({super.key});

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  bool isDescriptionExpanded = false;
  int selectedRating = 0;
  double readingProgress = 0.35;

  @override
  Widget build(BuildContext context) {
    final Book book = ModalRoute.of(context)!.settings.arguments as Book;

    final favoritesProvider = context.watch<FavoritesProvider>();
    final booksProvider = context.watch<BooksProvider>();

    final isFavorite = favoritesProvider.isFavorite(book);

    final suggestedBooks = booksProvider.books
        .where(
          (b) =>
              b.id != book.id &&
              (b.category == book.category || b.author == book.author),
        )
        .take(3)
        .toList();

    final imageUrl =
        (book.coverImagePath != null && book.coverImagePath!.trim().isNotEmpty)
        ? book.coverImagePath!
        : 'https://via.placeholder.com/300x450';
    return Directionality(
      textDirection: TextDirection.rtl,

      child: Scaffold(
        // return Scaffold(
        backgroundColor: const Color(0xffF5F5F7),

        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 360,
              pinned: true,
              backgroundColor: const Color(0xff602234),

              actions: [
                IconButton(
                  onPressed: () {
                    favoritesProvider.toggleFavorite(book);
                  },

                  icon: Icon(
                    isFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,

                    color: isFavorite ? Colors.red : Colors.white,
                  ),
                ),
              ],

              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(imageUrl, fit: BoxFit.cover),

                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.1),
                            Colors.black.withOpacity(0.75),
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom: 40,
                      ),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            book.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,

                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            book.author,

                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          const SizedBox(height: 16),

                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 7,
                                ),

                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(30),
                                ),

                                child: Text(
                                  book.category,

                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),

                              const SizedBox(width: 12),

                              const Icon(
                                Icons.star_rounded,
                                color: Colors.amber,
                              ),

                              const SizedBox(width: 4),

                              Text(
                                book.rating.toString(),

                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Read Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,

                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/reading',
                            arguments: book,
                          );
                        },

                        icon: const Icon(Icons.menu_book_rounded),

                        label: const Text(
                          'ابدأ القراءة',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff602234),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Reading Progress
                    const Text(
                      'تقدم القراءة',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 14),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),

                      child: LinearProgressIndicator(
                        value: readingProgress,
                        minHeight: 10,
                        backgroundColor: Colors.grey.shade300,
                        valueColor: const AlwaysStoppedAnimation(
                          Color(0xff602234),
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      '${(readingProgress * 100).toInt()}% مكتمل',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // User Rating
                    const Text(
                      'تقييمك',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: List.generate(5, (index) {
                        return IconButton(
                          onPressed: () {
                            setState(() {
                              selectedRating = index + 1;
                            });
                          },

                          icon: Icon(
                            index < selectedRating
                                ? Icons.star_rounded
                                : Icons.star_border_rounded,

                            color: Colors.amber,
                            size: 34,
                          ),
                        );
                      }),
                    ),

                    const SizedBox(height: 30),

                    // Description
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'لمحة عن الكتاب',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        IconButton(
                          onPressed: () {
                            setState(() {
                              isDescriptionExpanded = !isDescriptionExpanded;
                            });
                          },

                          icon: Icon(
                            isDescriptionExpanded
                                ? Icons.keyboard_arrow_up_rounded
                                : Icons.keyboard_arrow_down_rounded,
                          ),
                        ),
                      ],
                    ),

                    AnimatedCrossFade(
                      firstChild: const SizedBox(),

                      secondChild: Padding(
                        padding: const EdgeInsets.only(top: 10),

                        child: Text(
                          book.description ?? 'لا يوجد وصف متاح.',

                          style: TextStyle(
                            color: Colors.grey.shade700,
                            height: 1.7,
                            fontSize: 15,
                          ),
                        ),
                      ),

                      crossFadeState: isDescriptionExpanded
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,

                      duration: const Duration(milliseconds: 250),
                    ),

                    const SizedBox(height: 35),

                    // Suggestions
                    const Text(
                      'قد يعجبك أيضاً',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 18),

                    SizedBox(
                      height: 250,

                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: suggestedBooks.length,

                        itemBuilder: (context, index) {
                          final suggestedBook = suggestedBooks[index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/book-details',
                                arguments: suggestedBook,
                              );
                            },

                            child: Container(
                              width: 150,
                              margin: const EdgeInsets.only(right: 16),

                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.06),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),

                                    child: Image.network(
                                      suggestedBook.coverImagePath ??
                                          'https://via.placeholder.com/200x300',

                                      height: 170,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.all(12),

                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,

                                      children: [
                                        Text(
                                          suggestedBook.title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,

                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),

                                        const SizedBox(height: 4),

                                        Text(
                                          suggestedBook.author,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,

                                          style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
