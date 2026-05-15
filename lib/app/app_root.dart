import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/app_state_provider.dart';
import '../providers/category_provider.dart';
import '../providers/books_provider.dart';
import '../providers/favorites_provider.dart';

import 'app_routes.dart';
import 'app_theme.dart';
import '../screens/book/book_detail_page.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => AppStateProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => BooksProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: Consumer<AppStateProvider>(
        builder: (context, appState, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: appState.themeMode,
            initialRoute: '/login',
            routes: AppRoutes.routes,
            onGenerateRoute: (settings) {
              if (settings.name == '/book-details') {
                return MaterialPageRoute(
                  builder: (_) => const BookDetailPage(),
                  settings: settings,
                );
              }
              return null;
            },
          );
        },
      ),
    );
  }
}
