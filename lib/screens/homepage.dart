import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/book_card.dart';
import '../../widgets/category_chip.dart';
import '../../providers/books_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BooksProvider>().loadBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final books = context.watch<BooksProvider>().filteredBooks;

    return Scaffold(
      appBar: AppBar(title: const Text("الرئيسية")),

      body: Column(
        children: [
          const SizedBox(height: 10),

          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CategoryChip(label: "All"),
                CategoryChip(label: "Finance"),
                CategoryChip(label: "Self Development"),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 6, bottom: 20),

              itemCount: books.length,

              itemBuilder: (context, i) {
                return BookCard(book: books[i]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
