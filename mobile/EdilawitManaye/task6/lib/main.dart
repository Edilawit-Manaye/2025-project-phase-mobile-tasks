import 'package:task6/home_page.dart';
import 'package:flutter/material.dart';
import 'package:task6/detail_page.dart';
import 'package:task6/add_update_page.dart';
import 'package:task6/search_page.dart';

// The main() function stays the same. It's the entry point.
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      // STEP 2: Change the home property.
      // Instead of the old MyHomePage, we now tell the app to start with your HomePage.
      home: SearchPage(),
    );
  }
}

// IMPORTANT: The old `MyHomePage` and `_MyHomePageState` classes are no longer
// used, so you can delete them from this file entirely. The code above
// is all you need in main.dart now.