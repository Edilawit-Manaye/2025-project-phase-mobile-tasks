import 'package:equatable/equatable.dart';
import '../../../auth/domain/entities/user_entity.dart';

class MessageEntity extends Equatable {
  final String id;
  final String content;
  final UserEntity sender;
  final String chatId;

  const MessageEntity({required this.id, required this.content, required this.sender, required this.chatId});

  @override
  List<Object?> get props => [id, content, sender, chatId];
}