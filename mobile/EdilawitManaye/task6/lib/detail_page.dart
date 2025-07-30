// import 'package:flutter/material.dart';
//
// class DetailPage extends StatefulWidget {
//   const DetailPage({super.key});
//
//   @override
//   State<DetailPage> createState() => _DetailPageState();
// }
//
// class _DetailPageState extends State<DetailPage> {
//   // To keep track of the selected size
//   int _selectedSize = 41;
//
//   @override
//   Widget build(BuildContext context) {
//     // List of available sizes to build the chips from
//     final sizes = [39, 40, 41, 42, 43, 44];
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // --- Image Header ---
//             Stack(
//               children: [
//                 Image.asset('images/bestShoes.jpg', width: double.infinity, height: 350, fit: BoxFit.cover),
//                 Positioned(
//                   top: 40,
//                   left: 15,
//                   child: CircleAvatar(
//                     backgroundColor: Colors.white,
//                     child: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {}),
//                   ),
//                 ),
//               ],
//             ),
//             // --- Main Content ---
//             Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text("Men's shoe", style: TextStyle(color: Colors.grey, fontSize: 16)),
//                       Row(
//                         children: const [
//                           Icon(Icons.star, color: Colors.amber, size: 20),
//                           SizedBox(width: 5),
//                           Text("(4.0)", style: TextStyle(color: Colors.grey, fontSize: 16)),
//                         ],
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 12),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: const [
//                       Text("Derby Leather", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
//                       Text("\$120", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
//                     ],
//                   ),
//                   const SizedBox(height: 24),
//                   const Text("Size:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
//                   const SizedBox(height: 12),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: sizes.map((size) {
//                       bool isSelected = _selectedSize == size;
//                       return GestureDetector(
//                         onTap: () => setState(() => _selectedSize = size),
//                         child: Container(
//                           width: 50,
//                           height: 50,
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                             color: isSelected ? const Color(0xFF4A4EFE) : Colors.grey[200],
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Text(
//                             size.toString(),
//                             style: TextStyle(color: isSelected ? Colors.white : Colors.black, fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                   const SizedBox(height: 24),
//                   const Text(
//                     "A derby leather shoe is a classic and versatile footwear option characterized by its open lacing system, where the shoelace eyelets are sewn on top of the vamp (the upper part of the shoe). This design feature provides a more relaxed and casual look compared to the closed lacing system of oxford shoes. Derby shoes are typically made of high-quality leather, known for its durability and elegance, making them suitable for both formal and casual occasions. With their timeless style and comfortable fit, derby leather shoes are a staple in any well-rounded wardrobe.",
//                     style: TextStyle(color: Colors.grey, fontSize: 15, height: 1.5),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       // --- Bottom Buttons ---
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Row(
//           children: [
//             Expanded(
//               child: OutlinedButton(
//                 onPressed: () {},
//                 style: OutlinedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 15),
//                     foregroundColor: Colors.red,
//                     side: const BorderSide(color: Colors.red),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
//                 child: const Text("DELETE", style: TextStyle(fontWeight: FontWeight.bold)),
//               ),
//             ),
//             const SizedBox(width: 20),
//             Expanded(
//               child: ElevatedButton(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 15),
//                     backgroundColor: const Color(0xFF4A4EFE),
//                     foregroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
//                 child: const Text("UPDATE", style: TextStyle(fontWeight: FontWeight.bold)),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// Add navigation
// lib/detail_page.dart

// lib/detail_page.dart

import 'package:flutter/material.dart';
import 'package:task6/product_model.dart';

class DetailPage extends StatefulWidget {
  final Product product;
  const DetailPage({super.key, required this.product});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int _selectedSize = 41;
  final sizes = [39, 40, 41, 42, 43, 44];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(widget.product.imagePath, width: double.infinity, height: 350, fit: BoxFit.cover),
                Positioned(
                  top: 40,
                  left: 15,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.product.category, style: const TextStyle(color: Colors.grey, fontSize: 16)),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          const SizedBox(width: 5),
                          Text("(${widget.product.rating})", style: const TextStyle(color: Colors.grey, fontSize: 16)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.product.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
                      Text("\$${widget.product.price.toStringAsFixed(2)}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text("Size:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: sizes.map((size) {
                      bool isSelected = _selectedSize == size;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedSize = size),
                        child: Container(
                          width: 50, height: 50, alignment: Alignment.center,
                          decoration: BoxDecoration(color: isSelected ? const Color(0xFF4A4EFE) : Colors.grey[200], borderRadius: BorderRadius.circular(12)),
                          child: Text(size.toString(), style: TextStyle(color: isSelected ? Colors.white : Colors.black, fontWeight: FontWeight.bold)),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  Text(widget.product.description, style: const TextStyle(color: Colors.grey, fontSize: 15, height: 1.5)),
                ],
              ),
            ),
          ],
        ),
      ),
      // ==========================================================
      // === THIS IS THE FULLY CORRECTED BOTTOM NAVIGATION BAR    ===
      // ==========================================================
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                },
                style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 15), foregroundColor: Colors.red, side: const BorderSide(color: Colors.red), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: const Text("DELETE", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  // Navigate to the edit page and wait for it to return the updated product.
                  final updatedProduct = await Navigator.pushNamed(
                    context,
                    '/add-update',
                    arguments: widget.product,
                  );

                  // If the user saved their edits, `updatedProduct` will not be null.
                  // We then pop this DetailPage and send the updated product back to the HomePage.
                  if (updatedProduct != null && updatedProduct is Product) {
                    Navigator.pop(context, updatedProduct);
                  }
                },
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 15), backgroundColor: const Color(0xFF4A4EFE), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: const Text("UPDATE", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}