import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_data_source.dart';
import '../datasources/product_remote_data_source.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<(Failure?, List<ProductEntity>)> getProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.getProducts();
        await localDataSource.cacheProducts(remoteProducts);
        return (null, remoteProducts);
      } on ServerException {
        // Corrected: Explicitly type the empty list
        return (ServerFailure(), <ProductEntity>[]);
      }
    } else {
      try {
        final localProducts = await localDataSource.getLastProducts();
        return (null, localProducts);
      } on CacheException {
        // Corrected: Explicitly type the empty list
        return (CacheFailure(), <ProductEntity>[]);
      }
    }
  }

  @override
  Future<(Failure?, void)> createProduct(ProductEntity product) async {
    if (await networkInfo.isConnected) {
      try {
        final productModel = ProductModel.fromEntity(product);
        await remoteDataSource.createProduct(productModel);
        return (null, null);
      } on ServerException {
        return (ServerFailure(), null);
      }
    } else {
      return (ServerFailure(), null);
    }
  }

  @override
  Future<(Failure?, void)> deleteProduct(int id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteProduct(id);
        return (null, null);
      } on ServerException {
        return (ServerFailure(), null);
      }
    } else {
      return (ServerFailure(), null);
    }
  }

  @override
  Future<(Failure?, ProductEntity?)> getProductById(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final product = await remoteDataSource.getProductById(id);
        return (null, product);
      } on ServerException {
        return (ServerFailure(), null);
      }
    } else {
      return (ServerFailure(), null);
    }
  }

  @override
  Future<(Failure?, void)> updateProduct(ProductEntity product) async {
    if (await networkInfo.isConnected) {
      try {
        final productModel = ProductModel.fromEntity(product);
        await remoteDataSource.updateProduct(productModel);
        return (null, null);
      } on ServerException {
        return (ServerFailure(), null);
      }
    } else {
      return (ServerFailure(), null);
    }
  }
}