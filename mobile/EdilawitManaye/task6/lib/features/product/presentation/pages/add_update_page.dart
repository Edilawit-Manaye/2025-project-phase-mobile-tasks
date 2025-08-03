import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../../../core/network/network_info_impl.dart';
import '../../data/datasources/product_local_data_source_impl.dart';
import '../../data/datasources/product_remote_data_source_impl.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/usecases/create_product_usecase.dart';
import '../../domain/usecases/update_product_usecase.dart';
import '../../domain/usecases/delete_product_usecase.dart';

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

  late final ProductRepository repository;
  late final CreateProductUsecase createUsecase;
  late final UpdateProductUsecase updateUsecase;
  late final DeleteProductUsecase deleteUsecase;

  @override
  void initState() {
    super.initState();
    repository = ProductRepositoryImpl(
      remoteDataSource: ProductRemoteDataSourceImpl.instance,
      localDataSource: ProductLocalDataSourceImpl(),
      // CORRECT
      networkInfo: NetworkInfoImpl(InternetConnectionChecker.createInstance()),
    );
    createUsecase = CreateProductUsecase(repository);
    updateUsecase = UpdateProductUsecase(repository);
    deleteUsecase = DeleteProductUsecase(repository);

    if (isEditing) {
      _nameController.text = widget.product!.title;
      _descriptionController.text = widget.product!.description;
      _categoryController.text = widget.product!.category;
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

  void _onSave() async {
    final productToSave = ProductEntity(
      id: isEditing ? widget.product!.id : 0,
      title: _nameController.text,
      description: _descriptionController.text,
      category: _categoryController.text,
      price: double.tryParse(_priceController.text) ?? 0.0,
      imagePath: isEditing ? widget.product!.imagePath : 'images/bestShoes.jpg',
      rating: isEditing ? widget.product!.rating : 0.0,
    );

    if (isEditing) {
      await updateUsecase(productToSave);
    } else {
      await createUsecase(productToSave);
    }

    if (context.mounted) Navigator.pop(context);
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
            if (isEditing) ...[
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () async {
                  await deleteUsecase(DeleteProductParams(widget.product!.id));
                  if (context.mounted) Navigator.popUntil(context, (route) => route.isFirst);
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