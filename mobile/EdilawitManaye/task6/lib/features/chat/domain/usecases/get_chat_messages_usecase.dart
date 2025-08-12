import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/message_entity.dart';
import '../repositories/chat_repository.dart';

// This is the missing Use Case class
class GetChatMessagesUsecase implements UseCase<List<MessageEntity>, GetChatMessagesParams> {
  final ChatRepository repository;

  GetChatMessagesUsecase(this.repository);

  @override
  Future<(Failure?, List<MessageEntity>)> call(GetChatMessagesParams params) async {
    // Note: We need to add a 'getChatMessages' method to our repository contract.
    // We will do that in the next step.
    return (null, <MessageEntity>[]); // Placeholder
  }
}

// A specific Params class for this use case
class GetChatMessagesParams extends Equatable {
  final String chatId;
  const GetChatMessagesParams({required this.chatId});

  @override
  List<Object?> get props => [chatId];
}