// These are the necessary imports to connect all the layers and contracts.
import '../../../../core/network/network_info.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_data_source.dart';
import '../datasources/product_remote_data_source.dart';
import '../models/product_model.dart';

// This class implements the repository contract from the Domain layer.
// Its job is to manage data sources.
class ProductRepositoryImpl implements ProductRepository {
  // It requires dependencies for remote, local, and network info.
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  // The constructor uses dependency injection to receive the required parts.
  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<List<ProductEntity>> getProducts() async {
    // In a real app, you would use the networkInfo like this:
    // if (await networkInfo.isConnected) { ... }
    // For this task, we assume we are always online and fetch from remote.

    final productModels = await remoteDataSource.getProducts();

    // The repository is responsible for converting the Data-layer Models
    // into Domain-layer Entities before returning them to the use case.
    // In our case, since ProductModel extends ProductEntity, they are already compatible.
    return productModels;
  }

  @override
  Future<void> createProduct(ProductEntity product) async {
    // Convert the Domain-layer Entity into a Data-layer Model before sending it
    // to the remote data source.
    final productModel = ProductModel.fromEntity(product);
    await remoteDataSource.createProduct(productModel);
  }

  @override
  Future<void> deleteProduct(int id) async {
    // Pass the request directly to the remote data source.
    await remoteDataSource.deleteProduct(id);
  }

  @override
  Future<ProductEntity> getProductById(int id) async {
    // Get the model from the data source and return it as an entity.
    final productModel = await remoteDataSource.getProductById(id);
    return productModel;
  }

  @override
  Future<void> updateProduct(ProductEntity product) async {
    // Convert the entity to a model before sending it to the data source.
    final productModel = ProductModel.fromEntity(product);
    await remoteDataSource.updateProduct(productModel);
  }
}