import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/book_card.dart';
import '../../providers/favorites_provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>().favorites;

    return Scaffold(
      appBar: AppBar(title: const Text("المفضلة")),
      body: favorites.isEmpty
          ? const Center(child: Text("لا توجد كتب مفضلة"))
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: favorites.length,
              itemBuilder: (context, i) {
                return BookCard(book: favorites[i]);
              },
            ),
    );
  }
}