import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/chat_entity.dart';
import '../repositories/chat_repository.dart';
import 'package:equatable/equatable.dart';

class CreateChatUsecase implements UseCase<ChatEntity?, CreateChatParams> {
  final ChatRepository repository;

  CreateChatUsecase(this.repository);

  @override
  Future<(Failure?, ChatEntity?)> call(CreateChatParams params) async {
    return await repository.createChat(params.userId);
  }
}

class CreateChatParams extends Equatable {
  final String userId;

  const CreateChatParams({required this.userId});

  @override
  List<Object?> get props => [userId];
}