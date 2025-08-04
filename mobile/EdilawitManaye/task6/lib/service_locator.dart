import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'core/network/network_info.dart';
import 'core/network/network_info_impl.dart';
import 'features/product/data/datasources/product_local_data_source.dart';
import 'features/product/data/datasources/product_local_data_source_impl.dart';
import 'features/product/data/datasources/product_remote_data_source.dart';
import 'features/product/data/datasources/product_remote_data_source_impl.dart';
import 'features/product/data/repositories/product_repository_impl.dart';
import 'features/product/domain/repositories/product_repository.dart';
import 'features/product/domain/usecases/create_product_usecase.dart';
import 'features/product/domain/usecases/delete_product_usecase.dart';
import 'features/product/domain/usecases/update_product_usecase.dart';
import 'features/product/domain/usecases/view_all_products_usecase.dart';
import 'features/product/domain/usecases/view_product_usecase.dart';
import 'features/product/presentation/bloc/product_bloc.dart';

// Create a global instance of GetIt for service locator
final sl = GetIt.instance;

void setupLocator() {
  //  BLoC
  // Register the ProductBloc as a factory, creating a new instance each time it's requested.
  sl.registerFactory(() => ProductBloc(
    viewAllProducts: sl(), // Dependency injection for use cases
    viewProduct: sl(),
    createProduct: sl(),
    updateProduct: sl(),
    deleteProduct: sl(),
  ));

  //  Use Cases
  // Register use case instances as lazy singletons, creating them only when needed.
  sl.registerLazySingleton(() => ViewAllProductsUsecase(sl()));
  sl.registerLazySingleton(() => ViewProductUsecase(sl()));
  sl.registerLazySingleton(() => CreateProductUsecase(sl()));
  sl.registerLazySingleton(() => UpdateProductUsecase(sl()));
  sl.registerLazySingleton(() => DeleteProductUsecase(sl()));

  //  Repository
  // Register the ProductRepository implementation, injecting remote and local data sources and network info.
  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(
    remoteDataSource: sl(),
    localDataSource: sl(),
    networkInfo: sl(),
  ));

  //  Data Sources
  // Register the remote and local data sources, which handle data retrieval.
  sl.registerLazySingleton<ProductRemoteDataSource>(() => ProductRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<ProductLocalDataSource>(() => ProductLocalDataSourceImpl());

  // Core
  // Register the NetworkInfo implementation, which checks network connectivity.
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //  External Packages
  // Register external dependencies such as the HTTP client and internet connection checker.
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());

  // Task 18: Dependency injection setup completed successfully for the e-commerce app.
}