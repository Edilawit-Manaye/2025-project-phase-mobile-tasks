import '../../../auth/data/models/user_model.dart';
import '../../domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  const MessageModel({required super.id, required super.content, required super.sender, required super.chatId});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    final data = json.containsKey('data') ? json['data'] : json;
    return MessageModel(
      id: data['_id'],
      content: data['content'],
      sender: UserModel.fromJson(data['sender']),
      chatId: data['chat']['_id'],
    );
  }
}