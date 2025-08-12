import 'dart:async';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../../core/constants/strings.dart';
import '../../../../core/error/exceptions.dart';
import '../models/chat_model.dart';
import '../models/message_model.dart';

abstract class ChatRemoteDataSource {
  Future<List<ChatModel>> getChats();
  Future<ChatModel> createChat(String userId);
  Future<void> deleteChat(String chatId);
  Future<void> sendMessage(String chatId, String content);
  Future<List<MessageModel>> getChatMessages(String chatId);
  Stream<MessageModel> getMessagesStream();
  void initSocket(String token);
  void disposeSocket();
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final http.Client client;
  final FlutterSecureStorage secureStorage;
  IO.Socket? socket;
  final StreamController<MessageModel> _messageController = StreamController.broadcast();
  final String _baseUrl = 'https://g5-flutter-learning-path-be-tvum.onrender.com';
  final String _apiBase = '/api/v3';

  ChatRemoteDataSourceImpl({required this.client, required this.secureStorage});

  Future<Map<String, String>> _getHeaders() async {
    final token = await secureStorage.read(key: SECURE_STORAGE_TOKEN_KEY);
    return {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
  }

  // Inside the ChatRemoteDataSourceImpl class

  @override
  // This is the complete and corrected method.

  @override
  void initSocket(String token) {
    // If a socket connection already exists, dispose of it to prevent duplicates.
    // This is important if a user logs out and logs back in as someone else.
    if (socket != null && socket!.connected) {
      socket!.dispose();
    }

    // Create the socket instance with the necessary options.
    socket = IO.io(
      _baseUrl, // The base URL of your server (e.g., https://g5-...)
      <String, dynamic>{
        'transports': ['websocket'], // Force it to use WebSockets
        'autoConnect': false,        // We will connect manually after setting up listeners
        'auth': {'token': token}     // Pass the user's auth token for secure connection
      },
    );

    // --- Set up all event listeners BEFORE connecting ---

    // Listener for a successful connection
    socket!.onConnect((_) {
      // print('SUCCESS: Socket connected! ID: ${socket!.id}');
    });

    // Listener for general connection errors
    socket!.onConnectError((data) {
      // print('ERROR: Socket connection failed: $data');
    });

    // Listener for connection timeout errors
    socket!.on('connect_timeout', (data) {
      // print('ERROR: Socket connection timed out: $data');
    });

    // Listener for any other general socket errors
    socket!.onError((data) {
      // print('ERROR: A socket error occurred: $data');
    });

    // Listener for when the socket disconnects
    socket!.onDisconnect((_) {
      // print('Socket disconnected');
    });

    // Listener for the main event: receiving a new message from the server
    socket!.on('message:received', (data) {
      try {
        // When data is received, parse it into a MessageModel
        final message = MessageModel.fromJson(data);
        // Add the parsed message to our stream so the BLoC can hear it
        _messageController.add(message);
      } catch (e) {
        // In a real app, use a proper logger
        // print('Error parsing incoming message: $e');
      }
    });

    // Finally, after all listeners are set up, manually tell the socket to connect.
    socket!.connect();
  }

  @override
  Stream<MessageModel> getMessagesStream() => _messageController.stream;

  @override
  Future<List<ChatModel>> getChats() async {
    final response = await client.get(Uri.parse('$_baseUrl$_apiBase/chats'), headers: await _getHeaders());
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body)['data'];
      return jsonList.map((json) => ChatModel.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ChatModel> createChat(String userId) async {
    final response = await client.post(Uri.parse('$_baseUrl$_apiBase/chats'), headers: await _getHeaders(), body: json.encode({'userId': userId}));
    if (response.statusCode == 201) {
      return ChatModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteChat(String chatId) async {
    final response = await client.delete(Uri.parse('$_baseUrl$_apiBase/chats/$chatId'), headers: await _getHeaders());
    if (response.statusCode != 204 && response.statusCode != 200) {
      throw ServerException();
    }
  }

  @override
  Future<void> sendMessage(String chatId, String content) async {
    if (socket == null || !socket!.connected) throw ServerException();
    socket!.emit('message:send', {'chatId': chatId, 'content': content, 'type': 'text'});
  }

  @override
  Future<List<MessageModel>> getChatMessages(String chatId) async {
    final response = await client.get(
      Uri.parse('$_baseUrl$_apiBase/chats/$chatId/messages'),
      headers: await _getHeaders(),
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body)['data'];
      return jsonList.map((json) => MessageModel.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  void disposeSocket() {
    socket?.dispose();
    _messageController.close();
  }
}
