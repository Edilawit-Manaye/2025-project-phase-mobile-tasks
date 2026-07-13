import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/product_entity.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';

class AddUpdatePage extends StatefulWidget {
  final ProductEntity? product;
  const AddUpdatePage({super.key, this.product});
  @override
  State<AddUpdatePage> createState() => _AddUpdatePageState();
}

class _AddUpdatePageState extends State<AddUpdatePage> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();
  final _priceController = TextEditingController();

  bool get isEditing => widget.product != null;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      _nameController.text = widget.product!.name;
      _descriptionController.text = widget.product!.description;
      // Handle the case where the category might be null
      _categoryController.text = widget.product!.category ?? '';
      _priceController.text = widget.product!.price.toString();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product name cannot be empty.'), backgroundColor: Colors.red),
      );
      return;
    }

    final productToSave = ProductEntity(
      // The ID is now a String
      id: isEditing ? widget.product!.id : '', // Let the backend create the ID
      name: _nameController.text,
      description: _descriptionController.text,
      category: _categoryController.text.isNotEmpty ? _categoryController.text : null,
      price: double.tryParse(_priceController.text) ?? 0.0,
      imageUrl: isEditing ? widget.product!.imageUrl : 'https://i.imgur.com/example.png', // Placeholder
      rating: isEditing ? widget.product!.rating : null,
    );

    if (isEditing) {
      context.read<ProductBloc>().add(UpdateProductEvent(productToSave));
    } else {
      context.read<ProductBloc>().add(CreateProductEvent(productToSave));
    }
    Navigator.pop(context);
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
              onTap: () { /* Image picking logic would go here */ },
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
            if (isEditing) ...[
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () {
                  // The ID is now a String, so we must also update the event.
                  // We will fix the event in the next step.
                  context.read<ProductBloc>().add(DeleteProductEvent(widget.product!.id));
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                style: OutlinedButton.styleFrom(foregroundColor: Colors.red, side: const BorderSide(color: Colors.red), minimumSize: const Size(double.infinity, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: const Text("DELETE", style: TextStyle(fontWeight: FontWeight.bold)),
              )
            ]
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
          controller: controller, maxLines: maxLines, keyboardType: keyboardType,
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
// INCORRECT
class DeleteProductEvent extends ProductEvent {
final String id; // <-- Expects an int
const DeleteProductEvent(this.id);

@override
List<Object?> get props => [id];
}