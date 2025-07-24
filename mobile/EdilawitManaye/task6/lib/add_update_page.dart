import 'package:flutter/material.dart';

class AddUpdatePage extends StatelessWidget {
  const AddUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        leading: Padding(
          // We add padding to make the circle look centered and not touch the edges.
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              // The icon color is black to match the design.
              icon: const Icon(Icons.arrow_back, color: Colors.blue),
              onPressed: () {
                // In a real app, this would be Navigator.pop(context);
              },
            ),
          ),
        ),
        // ==========================================================
        centerTitle: true, // This will center the "Add Product" title.
        title: const Text("Add Product", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- The Image Upload Box ---
            GestureDetector(
              onTap: () { /* Handle image upload */ },
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(12)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.image_outlined, size: 50, color: Colors.black54),
                    SizedBox(height: 12),
                    Text("upload image", style: TextStyle(color: Colors.black54)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // --- The Form Fields ---
            _buildTextField(label: "name"),
            const SizedBox(height: 16),
            _buildTextField(label: "category"),
            const SizedBox(height: 16),
            _buildTextField(label: "price", suffixIcon: const Icon(Icons.attach_money)),
            const SizedBox(height: 16),
            _buildTextField(label: "description",maxLines: 4),
            const SizedBox(height: 30),

            // --- The Action Buttons ---
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A4EFE),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("ADD", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("DELETE", style: TextStyle(fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }

  // A helper method to create styled text fields
  Widget _buildTextField({required String label, Icon? suffixIcon, int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
        const SizedBox(height: 8),
        TextFormField(
          maxLines: maxLines,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}