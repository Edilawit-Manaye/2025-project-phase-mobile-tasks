import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/chat_repository.dart';
import 'package:equatable/equatable.dart';

class DeleteChatUsecase implements UseCase<void, DeleteChatParams> {
  final ChatRepository repository;

  DeleteChatUsecase(this.repository);

  @override
  Future<(Failure?, void)> call(DeleteChatParams params) async {
    return await repository.deleteChat(params.chatId);
  }
}

class DeleteChatParams extends Equatable {
  final String chatId;

  const DeleteChatParams({required this.chatId});

  @override
  List<Object?> get props => [chatId];
}