import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/book.dart';
import '../../providers/books_provider.dart';

class ReadingPage extends StatefulWidget {
  final Book book;

  const ReadingPage({
    super.key,
    required this.book,
  });

  @override
  State<ReadingPage> createState() =>
      _ReadingPageState();
}

class _ReadingPageState
    extends State<ReadingPage> {
  late double progress;

  @override
  void initState() {
    super.initState();

    progress =
        widget.book.readingProgress;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.title),
        centerTitle: true,
      ),

      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.all(20),

              child: Text(
                widget.book.content ??
                    "لا يوجد محتوى لهذا الكتاب",

                textAlign:
                    TextAlign.justify,

                style: const TextStyle(
                  fontSize: 18,
                  height: 1.8,
                ),
              ),
            ),
          ),

          Container(
            padding:
                const EdgeInsets.all(16),

            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                ),
              ],
            ),

            child: Column(
              children: [
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,

                  children: [
                    const Text(
                      "تقدم القراءة",
                    ),

                    Text(
                      "${(progress * 100).toInt()}%",
                    ),
                  ],
                ),

                Slider(
                  value: progress,

                  min: 0,
                  max: 1,

                  onChanged: (value) {
                    setState(() {
                      progress = value;
                    });

                    context
                        .read<
                          BooksProvider
                        >()
                        .updateReadingProgress(
                          widget.book.id,
                          value,
                        );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}