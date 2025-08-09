import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/pages/signup_page.dart';
import 'features/auth/presentation/pages/splash_page.dart';
import 'features/product/domain/entities/product_entity.dart';
import 'features/product/presentation/bloc/product_bloc.dart';
import 'features/product/presentation/pages/add_update_page.dart';
import 'features/product/presentation/pages/detail_page.dart';
import 'features/product/presentation/pages/home_page.dart';
import 'features/product/presentation/pages/search_page.dart';
import 'service_locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator(); // Set up all dependencies
  runApp(
    // Use MultiBlocProvider to provide both BLoCs to the widget tree
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<AuthBloc>()),
        BlocProvider(create: (context) => sl<ProductBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter E-commerce BLoC App',
      debugShowCheckedModeBanner: false,
      // The app now starts at the splash screen to check auth status
      initialRoute: '/splash',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/splash':
            return MaterialPageRoute(builder: (_) => const SplashPage());
          case '/login':
            return MaterialPageRoute(builder: (_) => const LoginPage());
          case '/signup':
            return MaterialPageRoute(builder: (_) => const SignUpPage());
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
            return MaterialPageRoute(builder: (_) => const SplashPage());
        }
      },
    );
  }
}