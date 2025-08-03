import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../../../core/network/network_info_impl.dart';
import '../../data/datasources/product_local_data_source_impl.dart';
import '../../data/datasources/product_remote_data_source_impl.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/delete_product_usecase.dart';

class DetailPage extends StatefulWidget {
  final ProductEntity product;
  const DetailPage({super.key, required this.product});
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int _selectedSize = 41;
  final sizes = [39, 40, 41, 42, 43, 44];

  late final DeleteProductUsecase deleteUsecase;

  @override
  void initState() {
    super.initState();
    final repository = ProductRepositoryImpl(
      remoteDataSource: ProductRemoteDataSourceImpl.instance,
      localDataSource: ProductLocalDataSourceImpl(),
      // CORRECT
      networkInfo: NetworkInfoImpl(InternetConnectionChecker.createInstance()),
    );
    deleteUsecase = DeleteProductUsecase(repository);
  }

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
                  top: 40, left: 15,
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () async {
                  await deleteUsecase(DeleteProductParams(widget.product.id));
                  if (context.mounted) Navigator.pop(context);
                },
                style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 15), foregroundColor: Colors.red, side: const BorderSide(color: Colors.red), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: const Text("DELETE", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/add-update', arguments: widget.product);
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