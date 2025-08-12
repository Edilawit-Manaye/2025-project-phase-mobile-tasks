import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/message_entity.dart';
import '../repositories/chat_repository.dart';

class GetMessagesStreamUsecase implements UseCase<Stream<(Failure?, MessageEntity?)>, NoParams> {
  final ChatRepository repository;

  GetMessagesStreamUsecase(this.repository);

  // Note: This call method is not async because it returns a Stream directly.
  @override
  Future<(Failure?, Stream<(Failure?, MessageEntity?)>)> call(NoParams params) async {
    return (null, repository.getMessagesStream());
  }
}