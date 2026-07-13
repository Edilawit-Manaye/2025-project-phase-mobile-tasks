import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class GetAuthTokenUsecase implements UseCase<String?, NoParams> {
  final AuthRepository repository;

  GetAuthTokenUsecase(this.repository);

  @override
  Future<(Failure?, String?)> call(NoParams params) async {
    return await repository.getAuthToken();
  }
}