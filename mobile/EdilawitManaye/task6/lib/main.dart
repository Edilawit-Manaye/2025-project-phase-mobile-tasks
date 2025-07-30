// import 'package:task6/home_page.dart';
// import 'package:flutter/material.dart';
// import 'package:task6/detail_page.dart';
// import 'package:task6/add_update_page.dart';
// import 'package:task6/search_page.dart';
//
// // The main() function stays the same. It's the entry point.
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//
//       // STEP 2: Change the home property.
//       // Instead of the old MyHomePage, we now tell the app to start with your HomePage.
//       home: SearchPage(),
//     );
//   }
// }

// Add Navigation
// lib/main.dart

// lib/main.dart

// 1. Import all the necessary pages and the product model.
import 'package:flutter/material.dart';
import 'package:task6/add_update_page.dart';
import 'package:task6/detail_page.dart';
import 'package:task6/home_page.dart';
import 'package:task6/product_model.dart';
import 'package:task6/search_page.dart';

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