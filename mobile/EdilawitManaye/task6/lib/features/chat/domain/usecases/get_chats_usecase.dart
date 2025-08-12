import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/chat_entity.dart';
import '../repositories/chat_repository.dart';

class GetChatsUsecase implements UseCase<List<ChatEntity>, NoParams> {
  final ChatRepository repository;
  GetChatsUsecase(this.repository);

  @override
  Future<(Failure?, List<ChatEntity>)> call(NoParams params) async {
    return await repository.getChats();
  }
}