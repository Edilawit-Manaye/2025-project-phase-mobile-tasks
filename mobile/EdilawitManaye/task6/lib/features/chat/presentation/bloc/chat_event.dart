import 'package:equatable/equatable.dart';
import '../../domain/entities/message_entity.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
  @override
  List<Object?> get props => [];
}

// Event to fetch the list of all chat conversations
class LoadChatsEvent extends ChatEvent {}

// Event to send a new message in a specific chat
class SendMessageEvent extends ChatEvent {
  final String chatId;
  final String content;
  const SendMessageEvent({required this.chatId, required this.content});
  @override
  List<Object?> get props => [chatId, content];
}

// An internal event for when a new message is received from the socket stream
class MessageReceivedEvent extends ChatEvent {
  final MessageEntity message;
  const MessageReceivedEvent(this.message);
  @override
  List<Object?> get props => [message];
}
// ADD THIS CLASS TO YOUR chat_event.dart FILE

class CreateChatEvent extends ChatEvent {
  final String userId;
  const CreateChatEvent({required this.userId});

  @override
  List<Object?> get props => [userId];
}

// Event to fetch all messages for a specific chat
class LoadMessagesForChatEvent extends ChatEvent {
  final String chatId;
  const LoadMessagesForChatEvent({required this.chatId});
  @override
  List<Object?> get props => [chatId];
}