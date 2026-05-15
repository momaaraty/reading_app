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
        : "https://s26162.pcdn.co/wp-content/uploads/2018/02/gatsby-original2.jpg";

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/book-details', arguments: book);
      },

      child: SizedBox(
        width: 160,
        height: 270,

        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // صورة الكتاب
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),

                    child: Image.network(
                      imageUrl,
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.35),
                        shape: BoxShape.circle,
                      ),

                      child: IconButton(
                        constraints: const BoxConstraints(),
                        padding: const EdgeInsets.all(6),
                        splashRadius: 10,

                        icon: Icon(
                          isFavorite
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          size: 20,

                          color: isFavorite ? Colors.red : Colors.white,
                        ),

                        onPressed: () {
                          context.read<FavoritesProvider>().toggleFavorite(
                            book,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),

              // المعلومات
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(14),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        book.title,

                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textDirection: TextDirection.rtl,

                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff602234),
                          height: 1.3,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        book.author,

                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textDirection: TextDirection.rtl,

                        style: TextStyle(
                          fontSize: 13,
                          color: const Color(0xff602234).withOpacity(0.7),

                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          Icon(
                            Icons.star_rounded,
                            size: 18,
                            color: Colors.amber.shade700,
                          ),

                          const SizedBox(width: 4),

                          Text(
                            book.rating.toString(),

                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
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
        ),
      ),
    );
  }
}
