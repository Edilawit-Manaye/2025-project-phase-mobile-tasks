import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

import '../../domain/usecases/signup_usecase.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource dataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.dataSource,
    required this.networkInfo,
  });

  @override
  Future<(Failure?, String)> login(String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await dataSource.login(email, password);
        return (null, token);
      } on ServerException {
        return (ServerFailure(), '');
      }
    } else {
      // You could define a specific NetworkFailure if you wanted
      return (ServerFailure(), '');
    }
  }

  @override
  Future<(Failure?, UserEntity?)> getMe() async {
    if (await networkInfo.isConnected) {
      try {
        final user = await dataSource.getMe();
        return (null, user);
      } on ServerException {
        return (ServerFailure(), null);
      }
    } else {
      return (ServerFailure(), null); // Or NetworkFailure
    }
  }
// ... other methods


  @override
  Future<(Failure?, UserEntity?)> signup(SignupParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final user = await dataSource.signup(params.name, params.email, params.password);
        return (null, user);
      } on ServerException {
        return (ServerFailure(), UserEntity(id: '', name: '', email: '')); // Return an empty entity on failure
      }
    } else {
      return (ServerFailure(), UserEntity(id: '', name: '', email: ''));
    }
  }

  @override
  Future<(Failure?, void)> logout() async {
    try {
      await dataSource.logout();
      return (null, null);
    } on CacheException {
      // Deleting from secure storage could fail, which we'd model as a CacheException
      return (CacheFailure(), null);
    }
  }

  @override
  Future<(Failure?, String?)> getAuthToken() async {
    try {
      final token = await dataSource.getAuthToken();
      return (null, token);
    } on CacheException {
      return (CacheFailure(), null);
    }
  }
}