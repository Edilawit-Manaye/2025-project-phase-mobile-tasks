import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class GetMeUsecase implements UseCase<UserEntity?, NoParams> {
  final AuthRepository repository;

  GetMeUsecase(this.repository);

  @override
  Future<(Failure?, UserEntity?)> call(NoParams params) async {
    return await repository.getMe();
  }
}