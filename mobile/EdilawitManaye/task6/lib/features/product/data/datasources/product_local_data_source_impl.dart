import '../models/product_model.dart';
import 'product_local_data_source.dart';

// For this task, the local cache does nothing, so the methods are empty.
class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    return;
  }

  @override
  Future<List<ProductModel>> getLastProducts() async {
    return [];
  }
}