import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';
import 'home_page.dart'; // Import to access ProductCard

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  RangeValues _currentRangeValues = const RangeValues(40, 150);

  final sampleProduct = Product(id: 1, imagePath: 'images/bestShoes.jpg', title: 'Derby Leather Shoes', category: 'Men\'s shoe', price: 120, rating: 4.0, description: "A derby leather shoe is a classic...");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Color(0xFF4A4EFE)), onPressed: () => Navigator.pop(context)),
        title: const Text("Search Product", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: "Leather",
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.arrow_forward, color: Color(0xFF4A4EFE)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => _showFilterSheet(context),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4A4EFE), foregroundColor: Colors.white, minimumSize: const Size(60, 60), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: const Icon(Icons.filter_list),
              ),
            ],
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/detail', arguments: sampleProduct);
            },
            child: ProductCard(product: sampleProduct),
          ),
        ],
      ),
    );
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Category", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(filled: true, fillColor: Colors.grey[200], border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)),
                  ),
                  const SizedBox(height: 20),
                  const Text("Price", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  RangeSlider(
                    values: _currentRangeValues,
                    min: 0, max: 200,
                    activeColor: const Color(0xFF4A4EFE),
                    onChanged: (RangeValues values) {
                      setModalState(() { _currentRangeValues = values; });
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4A4EFE), foregroundColor: Colors.white, minimumSize: const Size(double.infinity, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
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