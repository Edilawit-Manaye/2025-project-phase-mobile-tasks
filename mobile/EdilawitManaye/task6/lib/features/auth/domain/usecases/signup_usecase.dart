import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

// The UseCase now correctly specifies UserEntity? as its return type
class SignupUsecase implements UseCase<UserEntity?, SignupParams> {
  final AuthRepository repository;

  SignupUsecase(this.repository);

  // THIS IS THE FINAL, CORRECTED CALL METHOD
  @override
  Future<(Failure?, UserEntity?)> call(SignupParams params) async {
    // It simply passes the entire 'params' object directly to the repository.
    return await repository.signup(params);
  }
}

// The Params class is correct and unchanged
class SignupParams extends Equatable {
  final String name;
  final String email;
  final String password;

  const SignupParams({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [name, email, password];
}