import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

class LoginUsecase implements UseCase<String, LoginParams> {
  final AuthRepository repository;
  LoginUsecase(this.repository);

  @override
  Future<(Failure?, String)> call(LoginParams params) async {
    return await repository.login(params.email, params.password);
  }
}

class LoginParams extends Equatable {
  final String email;
  final String password;
  const LoginParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}