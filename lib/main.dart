import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/app_state_provider.dart';
import 'providers/auth_provider.dart';
import 'screens/login_page.dart';
import 'screens/signup_page.dart';
import 'screens/homepage.dart';
import 'screens/reset_pass.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => AppStateProvider()),
      ],
      child: Consumer<AppStateProvider>(
        builder: (context, appState, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: LoginPage(),
            title: 'Reading App',
            theme: ThemeData(
              scaffoldBackgroundColor: const Color(0xffe3ded0),
              colorScheme: const ColorScheme(
                brightness: Brightness.light,
                primary: Color(0xff602234),
                onPrimary: Color(0xffe3ded0),
                secondary: Color(0xff602234),
                onSecondary: Color(0xffe3ded0),
                surface: Color(0xffe3ded0),
                onSurface: Color(0xff602234),
                error: Colors.red,
                onError: Colors.white,
              ),
              inputDecorationTheme: const InputDecorationTheme(
                labelStyle: TextStyle(color: Color(0xff602234)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff602234)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff602234)),
                ),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff602234),
                  foregroundColor: const Color(0xffe3ded0),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
              outlinedButtonTheme: OutlinedButtonThemeData(
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xff602234),
                  side: const BorderSide(color: Color(0xff602234), width: 1.5),
                ),
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xff602234),
                ),
              ),
              iconTheme: const IconThemeData(color: Color(0xff602234)),
              textTheme: ThemeData.light().textTheme.apply(
                bodyColor: const Color(0xff602234),
                displayColor: const Color(0xff602234),
              ),
              primaryTextTheme: ThemeData.light().primaryTextTheme.apply(
                bodyColor: const Color(0xff602234),
                displayColor: const Color(0xff602234),
              ),
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xffe3ded0),
                foregroundColor: Color(0xff602234),
                iconTheme: IconThemeData(color: Color(0xff602234)),
                titleTextStyle: TextStyle(
                  color: Color(0xff602234),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              primaryColor: const Color(0xff602234),
              brightness: Brightness.light,
            ),
            darkTheme: ThemeData(
              scaffoldBackgroundColor: const Color(0xff602234),
              colorScheme: const ColorScheme(
                brightness: Brightness.dark,
                primary: Color(0xffe3ded0),
                onPrimary: Color(0xff602234),
                secondary: Color(0xffe3ded0),
                onSecondary: Color(0xff602234),
                surface: Color(0xff602234),
                onSurface: Color(0xffe3ded0),
                error: Colors.red,
                onError: Colors.white,
              ),
              inputDecorationTheme: const InputDecorationTheme(
                labelStyle: TextStyle(color: Color(0xffe3ded0)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffe3ded0)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffe3ded0)),
                ),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffe3ded0),
                  foregroundColor: const Color(0xff602234),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
              outlinedButtonTheme: OutlinedButtonThemeData(
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xffe3ded0),
                  side: const BorderSide(color: Color(0xffe3ded0), width: 1.5),
                ),
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xffe3ded0),
                ),
              ),
              iconTheme: const IconThemeData(color: Color(0xffe3ded0)),
              primaryColor: const Color(0xffe3ded0),
              brightness: Brightness.dark,
            ),
            themeMode: appState.themeMode,
            initialRoute: '/login',
            routes: {
              '/login': (_) => const LoginPage(),
              '/signup': (_) => const SignupPage(),
              '/reset-password': (_) => const ResetPasswordScreen(),
              '/home': (_) => const HomePage(),
            },
          );
        },
      ),
    );
  }
}
