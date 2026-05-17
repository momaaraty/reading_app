import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/book.dart';
import '../providers/favorites_provider.dart';

class BookCard extends StatelessWidget {
  final Book book;

  const BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final isFavorite = context.watch<FavoritesProvider>().isFavorite(book);

    final imageUrl =
        (book.coverImagePath != null && book.coverImagePath!.trim().isNotEmpty)
        ? book.coverImagePath!
        : 'https://s26162.pcdn.co/wp-content/uploads/2018/02/gatsby-original2.jpg';

    final double? progress = book.readingProgress;
    final String category = book.category ?? 'غير مصنف';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.06),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: InkWell(
        borderRadius: BorderRadius.circular(24),

        onTap: () {
          Navigator.pushNamed(context, '/book-details', arguments: book);
        },

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// TOP SECTION
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                /// COVER
                Hero(
                  tag: book.id,

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),

                    child: Image.network(
                      imageUrl,
                      width: 88,
                      height: 125,
                      fit: BoxFit.cover,

                      errorBuilder: (_, __, ___) => Container(
                        width: 88,
                        height: 125,
                        color: Colors.grey.shade300,

                        child: const Icon(Icons.menu_book_rounded, size: 36),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                /// INFO
                Expanded(
                  child: SizedBox(
                    height: 125,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        /// TITLE + FAV
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                book.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,

                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff602234),
                                ),
                              ),
                            ),

                            GestureDetector(
                              onTap: () {
                                context
                                    .read<FavoritesProvider>()
                                    .toggleFavorite(book);
                              },

                              child: Container(
                                padding: const EdgeInsets.all(7),

                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,

                                  color: isFavorite
                                      ? const Color(0xff602234)
                                      : const Color(0xffF4ECEF),
                                ),

                                child: Icon(
                                  isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,

                                  size: 18,

                                  color: isFavorite
                                      ? Colors.white
                                      : const Color(0xff602234),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 4),

                        /// AUTHOR
                        Text(
                          book.author,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,

                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                        ),

                        const SizedBox(height: 10),

                        /// CATEGORY
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),

                          decoration: BoxDecoration(
                            color: const Color(0xffF6E8ED),

                            borderRadius: BorderRadius.circular(12),
                          ),

                          child: Text(
                            category,

                            style: const TextStyle(
                              color: Color(0xff602234),
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        const Spacer(),

                        /// RATING + PAGES
                        Row(
                          children: [
                            Icon(
                              Icons.star_rounded,
                              color: Colors.amber.shade700,
                              size: 18,
                            ),

                            const SizedBox(width: 4),

                            Text(
                              book.rating.toString(),

                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),

                            const SizedBox(width: 18),

                            Icon(
                              Icons.menu_book_rounded,
                              size: 17,
                              color: Colors.grey.shade600,
                            ),

                            const SizedBox(width: 4),

                            Text(
                              '${book.pages ?? 0} صفحة',

                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            /// PROGRESS
            if (progress != null) ...[
              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  const Text(
                    'تقدم القراءة',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),

                  Text(
                    '${(progress * 100).toInt()}%',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xff602234),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 6),

              ClipRRect(
                borderRadius: BorderRadius.circular(20),

                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 6,
                  backgroundColor: Colors.grey.shade200,
                  color: const Color(0xff602234),
                ),
              ),
            ],

            const SizedBox(height: 14),

            /// BUTTON
            SizedBox(
              width: double.infinity,
              height: 42,

              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/book-details',
                    arguments: book,
                  );
                },

                icon: const Icon(Icons.menu_book_rounded, size: 18),

                label: Text(progress != null ? 'أكمل القراءة' : 'إقرأ الآن'),

                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color(0xff602234),
                  foregroundColor: Colors.white,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
