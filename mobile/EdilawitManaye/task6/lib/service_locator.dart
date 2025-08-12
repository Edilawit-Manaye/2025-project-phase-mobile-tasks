import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'features/auth/domain/usecases/get_me_usecase.dart';

// Core
import 'core/network/network_info.dart';
import 'core/network/network_info_impl.dart';

// Auth Feature Dependencies
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/get_auth_token_usecase.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/domain/usecases/logout_usecase.dart';
import 'features/auth/domain/usecases/signup_usecase.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

// Product Feature Dependencies
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

// Chat Feature Dependencies
import 'features/chat/data/datasources/chat_remote_data_source.dart';
import 'features/chat/data/repositories/chat_repository_impl.dart';
import 'features/chat/domain/repositories/chat_repository.dart';
import 'features/chat/domain/usecases/create_chat_usecase.dart';
import 'features/chat/domain/usecases/delete_chat_usecase.dart';
import 'features/chat/domain/usecases/get_chats_usecase.dart';
import 'features/chat/domain/usecases/get_messages_stream_usecase.dart';
import 'features/chat/domain/usecases/send_message_usecase.dart';
import 'features/chat/domain/usecases/get_chat_messages_usecase.dart';
import 'features/chat/presentation/bloc/chat_bloc.dart';


// Create a global instance of GetIt
final sl = GetIt.instance;

void setupLocator() {
  // --- BLoCs ---
  sl.registerFactory(() => ProductBloc(
      viewAllProducts: sl(), viewProduct: sl(), createProduct: sl(),
      updateProduct: sl(), deleteProduct: sl()));

  sl.registerFactory(() => AuthBloc(
      loginUsecase: sl(), signupUsecase: sl(),
      logoutUsecase: sl(), getAuthTokenUsecase: sl(),getMeUsecase: sl(),));
  sl.registerFactory(() => ChatBloc(
    getChats: sl(),
    sendMessage: sl(),
    getMessagesStream: sl(),
    getChatMessages: sl(),
    createChat: sl(),// <-- ADD THIS LINE
  ));


  // --- Use Cases ---
  // Product
  sl.registerLazySingleton(() => ViewAllProductsUsecase(sl()));
  sl.registerLazySingleton(() => ViewProductUsecase(sl()));
  sl.registerLazySingleton(() => CreateProductUsecase(sl()));
  sl.registerLazySingleton(() => UpdateProductUsecase(sl()));
  sl.registerLazySingleton(() => DeleteProductUsecase(sl()));
  // Auth
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => SignupUsecase(sl()));
  sl.registerLazySingleton(() => LogoutUsecase(sl()));
  sl.registerLazySingleton(() => GetAuthTokenUsecase(sl()));
  // Chat
  sl.registerLazySingleton(() => GetChatsUsecase(sl()));
  sl.registerLazySingleton(() => CreateChatUsecase(sl()));
  sl.registerLazySingleton(() => DeleteChatUsecase(sl()));
  sl.registerLazySingleton(() => SendMessageUsecase(sl()));
  sl.registerLazySingleton(() => GetMessagesStreamUsecase(sl()));
  sl.registerLazySingleton(() => GetChatMessagesUsecase(sl()));
  sl.registerLazySingleton(() => GetMeUsecase(sl()));

  // --- Repositories ---
  sl.registerLazySingleton<ProductRepository>(
        () => ProductRepositoryImpl(remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()),
  );
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(dataSource: sl(), networkInfo: sl()),
  );
  sl.registerLazySingleton<ChatRepository>(
        () => ChatRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  // --- Data Sources ---
  sl.registerLazySingleton<ProductRemoteDataSource>(
        () => ProductRemoteDataSourceImpl(client: sl(), secureStorage: sl()),
  );
  sl.registerLazySingleton<ProductLocalDataSource>(() => ProductLocalDataSourceImpl());
  sl.registerLazySingleton<AuthDataSource>(
        () => AuthDataSourceImpl(client: sl(), secureStorage: sl()),
  );
  sl.registerLazySingleton<ChatRemoteDataSource>(
        () => ChatRemoteDataSourceImpl(client: sl(), secureStorage: sl()),
  );

  // --- Core ---
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // --- External Packages ---
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
  sl.registerLazySingleton(() => const FlutterSecureStorage());
}