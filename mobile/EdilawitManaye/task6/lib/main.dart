
import 'package:flutter/material.dart';
import '../add_update_page.dart';
import '../detail_page.dart';
import '../home_page.dart';
import '../product_model.dart';
import '../search_page.dart';

// 2. The main entry point of the entire application.
void main() {
  runApp(const MyApp());
}

// 3. The root widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter E-commerce App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4A4EFE)),
        useMaterial3: true,
        // This provides smooth, iOS-style slide animations on all platforms.
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      // 4. The router configuration starts here.
      initialRoute: '/', // The app will start at the HomePage.
      onGenerateRoute: (settings) {
        // This function is the app's "switchboard". It handles all navigation
        // requests and makes sure to pass the correct data to each page.
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => const HomePage());
          case '/detail':
            final product = settings.arguments as Product; // Expect a Product object.
            return MaterialPageRoute(builder: (_) => DetailPage(product: product));
          case '/add-update':
            final product = settings.arguments as Product?; // Expect an optional Product.
            return MaterialPageRoute(builder: (_) => AddUpdatePage(product: product));
          case '/search':
            return MaterialPageRoute(builder: (_) => const SearchPage());
          default:
          // A fallback route in case of an error.
            return MaterialPageRoute(builder: (_) => const HomePage());
        }
      },
    );
  }
}