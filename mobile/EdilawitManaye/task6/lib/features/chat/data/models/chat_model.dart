import '../../../auth/data/models/user_model.dart';
import '../../domain/entities/chat_entity.dart';

class ChatModel extends ChatEntity {
  const ChatModel({required super.id, required super.user1, required super.user2});

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    final data = json.containsKey('data') ? json['data'] : json;
    return ChatModel(
      id: data['_id'],
      user1: UserModel.fromJson(data['user1']),
      user2: UserModel.fromJson(data['user2']),
    );
  }
}