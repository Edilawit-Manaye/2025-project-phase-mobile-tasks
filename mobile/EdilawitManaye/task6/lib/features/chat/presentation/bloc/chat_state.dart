import 'package:equatable/equatable.dart';
import '../../domain/entities/chat_entity.dart';
import '../../domain/entities/message_entity.dart';

abstract class ChatState extends Equatable {
  const ChatState();
  @override
  List<Object?> get props => [];
}

// The initial state before any chat data is loaded
class ChatInitial extends ChatState {}

// The state when chat data is being fetched
class ChatLoading extends ChatState {}

// The state when the list of chats has been successfully loaded
class ChatsLoaded extends ChatState {
  final List<ChatEntity> chats;
  const ChatsLoaded(this.chats);
  @override
  List<Object?> get props => [chats];
}

// The state when all messages for a single chat have been loaded and are being displayed
class MessagesLoaded extends ChatState {
  final List<MessageEntity> messages;
  const MessagesLoaded(this.messages);
  @override
  List<Object?> get props => [messages];
}

// The state when an error has occurred
class ChatError extends ChatState {
  final String message;
  const ChatError(this.message);
  @override
  List<Object?> get props => [message];
}