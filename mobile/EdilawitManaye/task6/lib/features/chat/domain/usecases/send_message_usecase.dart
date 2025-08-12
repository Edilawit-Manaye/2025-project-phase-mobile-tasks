import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/chat_repository.dart';
import 'package:equatable/equatable.dart';

class SendMessageUsecase implements UseCase<void, SendMessageParams> {
  final ChatRepository repository;

  SendMessageUsecase(this.repository);

  @override
  Future<(Failure?, void)> call(SendMessageParams params) async {
    return await repository.sendMessage(params.chatId, params.content);
  }
}

class SendMessageParams extends Equatable {
  final String chatId;
  final String content;

  const SendMessageParams({required this.chatId, required this.content});

  @override
  List<Object?> get props => [chatId, content];
}