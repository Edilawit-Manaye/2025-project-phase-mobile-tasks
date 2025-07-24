import 'package:flutter/material.dart';
import 'package:task6/home_page.dart';
import 'package:task6/home_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // State for the price range slider in the filter
  RangeValues _currentRangeValues = const RangeValues(40, 150);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Color(0xFF4A4EFE)), onPressed: () {}),
        title: const Text("Search Product", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          // --- The Search Bar and Filter Button ---
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: "Leather",
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.arrow_forward, color: Color(0xFF4A4EFE)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => _showFilterSheet(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A4EFE),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(60, 60),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Icon(Icons.filter_list),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // --- The Search Results ---
          // In a real app, this list would be built based on search results.
          // We are reusing the ProductCard from home_page.dart
          const ProductCard(
            imagePath: 'images/bestShoes.jpg',
            title: 'Derby Leather Shoes',
            category: 'Men\'s shoe',
            price: 120,
            rating: 4.0,
          ),
          const ProductCard(
            imagePath: 'images/bestShoes.jpg',
            title: 'Derby Leather Shoes',
            category: 'Men\'s shoe',
            price: 120,
            rating: 4.0,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // This function shows the filter options in a sheet that slides up from the bottom.
  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      // Gives the sheet rounded top corners
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        // Use a stateful builder so the slider can update visually inside the sheet
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Makes the sheet only as tall as its content
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Category", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text("Price", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  RangeSlider(
                    values: _currentRangeValues,
                    min: 0,
                    max: 200,
                    activeColor: const Color(0xFF4A4EFE),
                    onChanged: (RangeValues values) {
                      setModalState(() {
                        _currentRangeValues = values;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context), // Close the sheet
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4A4EFE),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("APPLY", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}