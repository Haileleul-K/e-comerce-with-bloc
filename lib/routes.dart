import 'package:ecommerce_test/bottom_nav.dart';
import 'package:ecommerce_test/feature/presentation/page/auth/login.dart';
import 'package:ecommerce_test/feature/presentation/page/auth/splash.dart';
import 'package:ecommerce_test/feature/presentation/page/cart/cart_page.dart';
import 'package:ecommerce_test/feature/presentation/page/category/category_page.dart';
import 'package:ecommerce_test/feature/presentation/page/favourite/favourite_page.dart';
import 'package:ecommerce_test/feature/presentation/page/home/home_page.dart';
import 'package:ecommerce_test/feature/presentation/page/profile/profile_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FadeRoute extends PageRouteBuilder {
  FadeRoute({required this.page})
      : super(
            pageBuilder: (_, __, ___) => page,
            transitionsBuilder: (_, animation, __, child) => FadeTransition(
                  opacity: animation,
                  child: child,
                ),
            transitionDuration: Duration(microseconds: 500));

  final Widget page;
}

enum Routes {
  login,
  home,
  profile,
  category,
  cart,
  favourite,
  splash,
  navigation
}

class Paths {
  static const String login = '/login';
  static const String home = '/home';
  static const String splash = '/splash';
  static const String category = '/category';
  static const String cart = '/cart';
  static const String favourite = '/favourite';
  static const String profile = '/profile';

  static const String navigation = '/navigation';

  static const Map<Routes, String> _pathMap = {
    Routes.splash: Paths.splash,
    Routes.login: Paths.login,
    Routes.profile: Paths.profile,
    Routes.home: Paths.home,
    Routes.category: Paths.category,
    Routes.cart: Paths.cart,
    Routes.favourite: Paths.favourite,
    Routes.navigation: Paths.navigation
  };

  // static String of(Routes route) => _pathMap[route] ?? splash;
  static String of(Routes route) => _pathMap[route] ?? login;
}

class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Paths.home:
        return FadeRoute(page: HomePage());
      case Paths.navigation:
        return FadeRoute(
          page: const AppNavigationBar(
            selectedIndex: 0,
          ),
        );
      case Paths.cart:
        return FadeRoute(page: const CartView());
      case Paths.favourite:
        return FadeRoute(page: const FavouriteView());
      case Paths.category:
        return FadeRoute(page: const CategoryView());
      case Paths.profile:
        return FadeRoute(page: const ProfileView());
      case Paths.login:
        return FadeRoute(page: const LoginPage());
      case Paths.splash:
        return FadeRoute(page: const SplashPage());
    }
    return FadeRoute(page: const LoginPage());
  }

  static Future? push<T>(Routes route, [T? arguments]) =>
      state?.pushNamed(Paths.of(route), arguments: arguments);

  static Future? replaceWith<T>(Routes route, [T? arguments]) =>
      state?.pushReplacementNamed(Paths.of(route), arguments: arguments);

  static void pop() => state?.pop();

  static NavigatorState? get state => navigatorKey.currentState;
}
