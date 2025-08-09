import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Use absolute package paths for all local project files to ensure resolution.
import 'package:task6/core/network/network_info.dart';
import 'package:task6/core/network/network_info_impl.dart';

// Auth Feature Dependencies
import 'package:task6/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:task6/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:task6/features/auth/domain/repositories/auth_repository.dart';
import 'package:task6/features/auth/domain/usecases/get_auth_token_usecase.dart';
import 'package:task6/features/auth/domain/usecases/login_usecase.dart';
import 'package:task6/features/auth/domain/usecases/logout_usecase.dart';
import 'package:task6/features/auth/domain/usecases/signup_usecase.dart';
import 'package:task6/features/auth/presentation/bloc/auth_bloc.dart';

// Product Feature Dependencies
import 'package:task6/features/product/data/datasources/product_local_data_source.dart';
import 'package:task6/features/product/data/datasources/product_local_data_source_impl.dart';
import 'package:task6/features/product/data/datasources/product_remote_data_source.dart';
import 'package:task6/features/product/data/datasources/product_remote_data_source_impl.dart';
import 'package:task6/features/product/data/repositories/product_repository_impl.dart';
import 'package:task6/features/product/domain/repositories/product_repository.dart';
import 'package:task6/features/product/domain/usecases/create_product_usecase.dart';
import 'package:task6/features/product/domain/usecases/delete_product_usecase.dart';
import 'package:task6/features/product/domain/usecases/update_product_usecase.dart';
import 'package:task6/features/product/domain/usecases/view_all_products_usecase.dart';
import 'package:task6/features/product/domain/usecases/view_product_usecase.dart';
import 'package:task6/features/product/presentation/bloc/product_bloc.dart';

// Create a global instance of GetIt
final sl = GetIt.instance;

void setupLocator() {
  // --- BLoCs ---
  // A new instance of a BLoC is created each time it's requested
  sl.registerFactory(() => ProductBloc(
      viewAllProducts: sl(), viewProduct: sl(), createProduct: sl(),
      updateProduct: sl(), deleteProduct: sl()));

  sl.registerFactory(() => AuthBloc(
      loginUsecase: sl(), signupUsecase: sl(),
      logoutUsecase: sl(), getAuthTokenUsecase: sl()));

  // --- Use Cases ---
  // A single instance is created when first requested and reused
  sl.registerLazySingleton(() => ViewAllProductsUsecase(sl()));
  sl.registerLazySingleton(() => ViewProductUsecase(sl()));
  sl.registerLazySingleton(() => CreateProductUsecase(sl()));
  sl.registerLazySingleton(() => UpdateProductUsecase(sl()));
  sl.registerLazySingleton(() => DeleteProductUsecase(sl()));
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => SignupUsecase(sl()));
  sl.registerLazySingleton(() => LogoutUsecase(sl()));
  sl.registerLazySingleton(() => GetAuthTokenUsecase(sl()));

  // --- Repositories ---
  sl.registerLazySingleton<ProductRepository>(
        () => ProductRepositoryImpl(
        remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()),
  );
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(dataSource: sl(), networkInfo: sl()),
  );

  // --- Data Sources ---
  sl.registerLazySingleton<ProductRemoteDataSource>(
        () => ProductRemoteDataSourceImpl(client: sl(), secureStorage: sl()),
  );
  sl.registerLazySingleton<ProductLocalDataSource>(
        () => ProductLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<AuthDataSource>(
        () => AuthDataSourceImpl(client: sl(), secureStorage: sl()),
  );

  // --- Core ---
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // --- External Packages ---
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
  sl.registerLazySingleton(() => const FlutterSecureStorage());
}