import '../screens/auth/login_page.dart';
import '../screens/auth/signup_page.dart';
import '../screens/auth/reset_pass.dart';
import '../screens/homepage.dart';
import '../screens/profile/edit_profile_page.dart';
import '../screens/suggestions_page.dart';
import '../screens/favorites_page.dart';
import '../screens/splash_screen.dart';

class AppRoutes {
  static final routes = {
    '/': (_) => const SplashScreen(),
    '/login': (_) => const LoginPage(),
    '/signup': (_) => const SignupPage(),
    '/reset': (_) => const ResetPasswordScreen(),
    '/home': (_) => const HomePage(),
    '/profile': (_) => const EditProfilePage(),
    '/suggestions': (_) => const SuggestionsPage(),
    '/favorites': (_) => const FavoritesPage(),
    // Removed '/book-details' from static routes
  };
}
