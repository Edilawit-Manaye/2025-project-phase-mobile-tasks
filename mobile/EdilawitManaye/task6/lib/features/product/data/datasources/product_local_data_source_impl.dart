import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../models/product_model.dart';
import 'product_local_data_source.dart';

const CACHED_PRODUCTS_KEY = 'CACHED_PRODUCTS';

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  // The constructor is now empty.

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    final prefs = await SharedPreferences.getInstance();
    final productListJson = products.map((product) => product.toJson()).toList();
    final jsonString = json.encode(productListJson);
    await prefs.setString(CACHED_PRODUCTS_KEY, jsonString);
  }

  @override
  Future<List<ProductModel>> getLastProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(CACHED_PRODUCTS_KEY);
    if (jsonString != null) {
      final productList = json.decode(jsonString) as List<dynamic>;
      final products = productList.map((json) => ProductModel.fromJson(json)).toList();
      return products;
    } else {
      throw CacheException();
    }
  }
}