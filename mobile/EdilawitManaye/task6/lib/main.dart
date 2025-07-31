import 'package:flutter/material.dart';
import 'presentation/pages/add_update_page.dart';
import 'presentation/pages/detail_page.dart';
import 'presentation/pages/home_page.dart';
import 'domain/entities/product.dart';
import 'presentation/pages/search_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter E-commerce App',
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => const HomePage());
          case '/detail':
            final product = settings.arguments as Product;
            return MaterialPageRoute(builder: (_) => DetailPage(product: product));
          case '/add-update':
            final product = settings.arguments as Product?;
            return MaterialPageRoute(builder: (_) => AddUpdatePage(product: product));
          case '/search':
            return MaterialPageRoute(builder: (_) => const SearchPage());
          default:
            return MaterialPageRoute(builder: (_) => const HomePage());
        }
      },
    );
  }
}