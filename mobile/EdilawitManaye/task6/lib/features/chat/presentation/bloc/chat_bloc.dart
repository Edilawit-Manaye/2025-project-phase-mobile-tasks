import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/usecases/create_chat_usecase.dart';
import '../../domain/usecases/get_chats_usecase.dart';
import '../../domain/usecases/get_messages_stream_usecase.dart';
import '../../domain/usecases/send_message_usecase.dart';
import '../../domain/usecases/get_chat_messages_usecase.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetChatsUsecase getChats;
  final SendMessageUsecase sendMessage;
  final GetMessagesStreamUsecase getMessagesStream;
  final GetChatMessagesUsecase getChatMessages;
  final CreateChatUsecase createChat; // Now included
  StreamSubscription? _messagesSubscription;

  ChatBloc({
    required this.getChats,
    required this.sendMessage,
    required this.getMessagesStream,
    required this.getChatMessages,
    required this.createChat, // Now included
  }) : super(ChatInitial()) {
    on<LoadChatsEvent>(_onLoadChats);
    on<LoadMessagesForChatEvent>(_onLoadMessagesForChat);
    on<SendMessageEvent>(_onSendMessage);
    on<MessageReceivedEvent>(_onMessageReceived);
    on<CreateChatEvent>(_onCreateChat); // Register the new event handler

    _listenToMessages();
  }

  void _listenToMessages() async {
    final (failure, stream) = await getMessagesStream(NoParams());
    if (failure == null && stream != null) {
      _messagesSubscription = stream.listen((messageData) {
        final (_, message) = messageData;
        if (message != null) {
          add(MessageReceivedEvent(message));
        }
      });
    }
  }

  Future<void> _onLoadChats(LoadChatsEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    final (failure, chats) = await getChats(NoParams());
    if (failure != null) {
      emit(const ChatError('Failed to load your chats.'));
    } else {
      emit(ChatsLoaded(chats));
    }
  }

  Future<void> _onLoadMessagesForChat(LoadMessagesForChatEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    final (failure, messages) = await getChatMessages(GetChatMessagesParams(chatId: event.chatId));
    if (failure != null) {
      emit(const ChatError('Failed to load messages for this chat.'));
    } else {
      emit(MessagesLoaded(messages));
    }
  }

  Future<void> _onSendMessage(SendMessageEvent event, Emitter<ChatState> emit) async {
    await sendMessage(SendMessageParams(chatId: event.chatId, content: event.content));
    // No new state is emitted here; the update comes from the socket.
  }

  // THIS IS THE NEW, CORRECTLY ADDED METHOD
  // Find this method in your ChatBloc
  // In ChatBloc

  Future<void> _onCreateChat(CreateChatEvent event, Emitter<ChatState> emit) async {
    // We don't need a loading state, we just perform the action
    final (failure, newChat) = await createChat(CreateChatParams(userId: event.userId));

    // We do NOT add a LoadChatsEvent here. The UI will do it when it navigates.
    if (failure != null) {
      // You could emit a specific failure state if you wanted
      print("Failed to create chat");
    } else {
      print("Chat created successfully");
    }
  }
  void _onMessageReceived(MessageReceivedEvent event, Emitter<ChatState> emit) {
    if (state is MessagesLoaded) {
      final currentState = state as MessagesLoaded;
      // Ensure the message belongs to the currently viewed chat
      if (currentState.messages.isNotEmpty && currentState.messages.first.chatId == event.message.chatId) {
        final updatedMessages = List<MessageEntity>.from(currentState.messages)..insert(0, event.message);
        emit(MessagesLoaded(updatedMessages));
      }
    }
    // A listener in ChatListPage could check event.message.chatId to show a notification
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}