import '../../../../core/error/failures.dart';
import '../entities/chat_entity.dart';
import '../entities/message_entity.dart';

abstract class ChatRepository {
  Future<(Failure?, List<ChatEntity>)> getChats();
  Future<(Failure?, List<MessageEntity>)> getChatMessages(String chatId);
  Future<(Failure?, ChatEntity?)> createChat(String userId);
  Future<(Failure?, void)> deleteChat(String chatId);
  Future<(Failure?, void)> sendMessage(String chatId, String content);
  Stream<(Failure?, MessageEntity?)> getMessagesStream();
}