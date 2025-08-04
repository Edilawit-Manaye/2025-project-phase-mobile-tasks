import 'package:flutter/material.dart';
import 'features/product/domain/entities/product_entity.dart';
import 'features/product/presentation/pages/add_update_page.dart';
import 'features/product/presentation/pages/detail_page.dart';
import 'features/product/presentation/pages/home_page.dart';
import 'features/product/presentation/pages/search_page.dart';
import 'service_locator.dart'; // <-- Import the new file

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator(); // <-- Call this setup function before the app runs
  runApp(const MyApp());
}

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
            final product = settings.arguments as ProductEntity;
            return MaterialPageRoute(builder: (_) => DetailPage(product: product));
          case '/add-update':
            final product = settings.arguments as ProductEntity?;
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