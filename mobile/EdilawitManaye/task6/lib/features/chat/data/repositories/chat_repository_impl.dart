import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/chat_entity.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_remote_data_source.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ChatRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<(Failure?, List<ChatEntity>)> getChats() async {
    if (await networkInfo.isConnected) {
      try {
        final chats = await remoteDataSource.getChats();
        return (null, chats);
      } on ServerException {
        return (ServerFailure(), <ChatEntity>[]);
      }
    } else {
      return (ServerFailure(), <ChatEntity>[]);
    }
  }

  @override
  Future<(Failure?, ChatEntity?)> createChat(String userId) async {
    if (await networkInfo.isConnected) {
      try {
        final newChat = await remoteDataSource.createChat(userId);
        return (null, newChat);
      } on ServerException {
        return (ServerFailure(), null);
      }
    } else {
      return (ServerFailure(), null);
    }
  }

  @override
  Future<(Failure?, void)> deleteChat(String chatId) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteChat(chatId);
        return (null, null);
      } on ServerException {
        return (ServerFailure(), null);
      }
    } else {
      return (ServerFailure(), null);
    }
  }

  @override
  Future<(Failure?, void)> sendMessage(String chatId, String content) async {
    try {
      await remoteDataSource.sendMessage(chatId, content);
      return (null, null);
    } on ServerException {
      return (ServerFailure(), null);
    }
  }

  // THIS IS THE NEW, CORRECTLY PLACED METHOD
  @override
  Future<(Failure?, List<MessageEntity>)> getChatMessages(String chatId) async {
    if (await networkInfo.isConnected) {
      try {
        final messages = await remoteDataSource.getChatMessages(chatId);
        return (null, messages);
      } on ServerException {
        return (ServerFailure(), <MessageEntity>[]);
      }
    } else {
      return (ServerFailure(), <MessageEntity>[]);
    }
  }

  @override
  Stream<(Failure?, MessageEntity?)> getMessagesStream() {
    return remoteDataSource.getMessagesStream().map((message) => (null, message))
        .handleError((error) {
      return (ServerFailure(), null);
    });
  }
}