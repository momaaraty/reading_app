import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../providers/books_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _bookController;

  late Animation<double> _scale;
  late Animation<double> _rotate;

  bool _done = false;

  final Color maroon = const Color(0xFF602234);
  final Color cream = const Color(0xFFF0ECE2);
  final Color beige = const Color(0xFFE3DED0);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);

    _bookController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _scale = Tween<double>(begin: 0.95, end: 1.08).animate(
      CurvedAnimation(parent: _bookController, curve: Curves.easeInOut),
    );

    _rotate = Tween<double>(begin: -0.05, end: 0.05).animate(
      CurvedAnimation(parent: _bookController, curve: Curves.easeInOut),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _boot();
    });
  }

  Future<void> _boot() async {
    final auth = context.read<AuthProvider>();
    final books = context.read<BooksProvider>();

    await auth.initAuth();
    await books.loadBooks();

    if (!mounted || _done) return;
    _done = true;

    if (auth.isLoggedIn) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _bookController.dispose();
    super.dispose();
  }

  Widget _buildBackground() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return CustomPaint(
          painter: _ColorBlobPainter(_controller.value),
          child: Container(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),

          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 📚 FLOATING BOOK (core idea)
                AnimatedBuilder(
                  animation: _bookController,
                  builder: (context, child) {
                    return Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..translate(
                          0.0,
                          -10 * sin(_bookController.value * pi * 2),
                        )
                        ..rotateZ(_rotate.value),
                      child: Transform.scale(
                        scale: _scale.value,
                        child: Container(
                          padding: const EdgeInsets.all(22),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            gradient: LinearGradient(
                              colors: [maroon, maroon.withOpacity(0.6)],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: maroon.withOpacity(0.4),
                                blurRadius: 40,
                                spreadRadius: 4,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.menu_book_rounded,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 25),

                Text(
                  "مكتبتك الذكية",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: maroon,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "نُحضّر عالم القراءة الخاص بك...",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),

                const SizedBox(height: 18),

                CircularProgressIndicator(color: maroon, strokeWidth: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ColorBlobPainter extends CustomPainter {
  final double t;

  _ColorBlobPainter(this.t);

  final Color maroon = const Color(0xFF602234);
  final Color cream = const Color(0xFFF0ECE2);
  final Color beige = const Color(0xFFE3DED0);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    paint.color = maroon.withOpacity(0.35);
    canvas.drawCircle(
      Offset(
        size.width * (0.3 + 0.2 * sin(t * 2 * pi)),
        size.height * (0.25 + 0.1 * cos(t * 2 * pi)),
      ),
      180,
      paint,
    );

    // 🟡 cream light blob
    paint.color = cream.withOpacity(0.9);
    canvas.drawCircle(
      Offset(
        size.width * (0.7 + 0.2 * cos(t * 2 * pi)),
        size.height * (0.4 + 0.2 * sin(t * 2 * pi)),
      ),
      220,
      paint,
    );

    paint.color = beige.withOpacity(0.8);
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * (0.7 + 0.15 * sin(t * 3 * pi))),
      250,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
