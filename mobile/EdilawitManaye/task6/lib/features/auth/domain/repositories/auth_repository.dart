import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../usecases/signup_usecase.dart';

abstract class AuthRepository {
  Future<(Failure?, String)> login(String email, String password);
  Future<(Failure?, UserEntity?)> signup(SignupParams params);
  Future<(Failure?, void)> logout();
  Future<(Failure?, String?)> getAuthToken();
}