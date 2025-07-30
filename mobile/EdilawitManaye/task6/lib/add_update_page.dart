

import 'package:flutter/material.dart';
import 'package:task6/product_model.dart';

class AddUpdatePage extends StatefulWidget {
  final Product? product; // Can receive a product for editing
  const AddUpdatePage({super.key, this.product});

  @override
  State<AddUpdatePage> createState() => _AddUpdatePageState();
}

class _AddUpdatePageState extends State<AddUpdatePage> {
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  // Check if we are in "edit" mode
  bool get isEditing => widget.product != null;

  @override
  void initState() {
    super.initState();
    // If we are editing, fill the form with the existing product's data
    if (isEditing) {
      _nameController.text = widget.product!.title;
      _categoryController.text = widget.product!.category;
      _priceController.text = widget.product!.price.toString();
      _descriptionController.text = widget.product!.description;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _onSave() {
    // Create a new product from the form data
    final newProduct = Product(
      id: isEditing ? widget.product!.id : DateTime.now().millisecondsSinceEpoch,
      title: _nameController.text,
      category: _categoryController.text,
      price: double.tryParse(_priceController.text) ?? 0.0,
      description: _descriptionController.text,
      imagePath: 'images/bestShoes.jpg', // Placeholder
      rating: isEditing ? widget.product!.rating : 4.0, // Placeholder
    );
    // Go back and pass the new/updated product as a result
    Navigator.pop(context, newProduct);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        centerTitle: true,
        title: Text(isEditing ? "Edit Product" : "Add Product", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 200, width: double.infinity,
                decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(12)),
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: const [Icon(Icons.image_outlined, size: 50, color: Colors.black54), SizedBox(height: 12), Text("upload image", style: TextStyle(color: Colors.black54))]),
              ),
            ),
            const SizedBox(height: 24),
            _buildTextField(label: "name", controller: _nameController),
            const SizedBox(height: 16),
            _buildTextField(label: "category", controller: _categoryController),
            const SizedBox(height: 16),
            _buildTextField(label: "price", controller: _priceController, suffixIcon: const Icon(Icons.attach_money), keyboardType: TextInputType.number),
            const SizedBox(height: 16),
            _buildTextField(label: "description", controller: _descriptionController, maxLines: 4),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _onSave,
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4A4EFE), foregroundColor: Colors.white, minimumSize: const Size(double.infinity, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              child: Text(isEditing ? "UPDATE" : "ADD", style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 12),
            if (isEditing) OutlinedButton(
              onPressed: () { /* Handle delete */ },
              style: OutlinedButton.styleFrom(foregroundColor: Colors.red, side: const BorderSide(color: Colors.red), minimumSize: const Size(double.infinity, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              child: const Text("DELETE", style: TextStyle(fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, required TextEditingController controller, Icon? suffixIcon, int maxLines = 1, TextInputType? keyboardType}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }
}