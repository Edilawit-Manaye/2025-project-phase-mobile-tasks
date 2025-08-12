// // ALL IMPORTS ARE CORRECTLY PLACED AT THE TOP OF THE FILE
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../domain/entities/chat_entity.dart';
// import '../bloc/chat_bloc.dart';
// import '../bloc/chat_event.dart';
// import '../bloc/chat_state.dart';
// import '../../domain/entities/message_entity.dart';
//
// class ChatPage extends StatefulWidget {
//   final ChatEntity chat;
//   const ChatPage({super.key, required this.chat});
//   @override
//   State<ChatPage> createState() => _ChatPageState();
// }
//
// class _ChatPageState extends State<ChatPage> {
//   final _messageController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     context.read<ChatBloc>().add(LoadMessagesForChatEvent(chatId: widget.chat.id));
//   }
//
//   @override
//   void dispose() {
//     _messageController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     const myUserId = "66bde36e9bbe07fc39034cdd"; // Placeholder for the current user's ID
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 1,
//         leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black), onPressed: () => Navigator.pop(context)),
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(widget.chat.user1.name, style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
//             const Text('Online', style: TextStyle(color: Colors.grey, fontSize: 12)),
//           ],
//         ),
//         actions: [
//           IconButton(icon: const Icon(Icons.call_outlined, color: Colors.black), onPressed: () {}),
//           IconButton(icon: const Icon(Icons.videocam_outlined, color: Colors.black), onPressed: () {}),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: BlocBuilder<ChatBloc, ChatState>(
//               builder: (context, state) {
//                 if (state is ChatLoading) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 if (state is MessagesLoaded) {
//                   return ListView.builder(
//                     reverse: true,
//                     padding: const EdgeInsets.all(16),
//                     itemCount: state.messages.length,
//                     itemBuilder: (context, index) {
//                       final message = state.messages[index];
//                       final isMe = message.sender.id == myUserId;
//                       return _buildMessageBubble(message.content, isMe);
//                     },
//                   );
//                 }
//                 return const Center(child: Text('No messages yet. Send one!'));
//               },
//             ),
//           ),
//           _buildMessageComposer(
//             controller: _messageController,
//             onSend: () {
//               if (_messageController.text.isNotEmpty) {
//                 context.read<ChatBloc>().add(SendMessageEvent(chatId: widget.chat.id, content: _messageController.text));
//                 _messageController.clear();
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   // --- THIS IS THE CORRECTED, FULLY IMPLEMENTED HELPER METHOD ---
//   Widget _buildMessageBubble(String text, bool isMe) {
//     return Align(
//       alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 4),
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//         decoration: BoxDecoration(
//           color: isMe ? const Color(0xFF4A4EFE) : Colors.grey.shade200,
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Text(text, style: TextStyle(color: isMe ? Colors.white : Colors.black)),
//       ),
//     );
//   }
//
//   // --- THIS IS THE CORRECTED, FULLY IMPLEMENTED HELPER METHOD ---
//   Widget _buildMessageComposer({required TextEditingController controller, required VoidCallback onSend}) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
//       color: Colors.white,
//       child: SafeArea(
//         child: Row(
//           children: [
//             IconButton(icon: const Icon(Icons.attach_file, color: Colors.grey), onPressed: () {}),
//             Expanded(
//               child: TextField(
//                 controller: controller,
//                 decoration: InputDecoration(
//                   hintText: 'Write your message',
//                   filled: true,
//                   fillColor: Colors.grey.shade100,
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
//                   contentPadding: const EdgeInsets.symmetric(horizontal: 16),
//                   suffixIcon: IconButton(
//                     icon: const Icon(Icons.send, color: Color(0xFF4A4EFE)),
//                     onPressed: onSend,
//                   ),
//                 ),
//               ),
//             ),
//             IconButton(icon: const Icon(Icons.camera_alt_outlined, color: Colors.grey), onPressed: () {}),
//             IconButton(icon: const Icon(Icons.mic_none_outlined, color: Colors.grey), onPressed: () {}),
//           ],
//         ),
//       ),
//     );
//   }
// }





import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/chat_entity.dart';
import '../bloc/chat_bloc.dart';
import '../bloc/chat_event.dart';
import '../bloc/chat_state.dart';
import '../../domain/entities/message_entity.dart';

class ChatPage extends StatefulWidget {
  final ChatEntity chat;
  const ChatPage({super.key, required this.chat});
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // When the page loads, tell the BLoC to fetch historical messages for this chat
    context.read<ChatBloc>().add(LoadMessagesForChatEvent(chatId: widget.chat.id));
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This is a placeholder. In a real app, you would get your own user's ID
    // from the AuthBloc's state to correctly determine which messages are "yours".
    const myUserId = "YOUR_CURRENTLY_LOGGED_IN_USER_ID_HERE";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black), onPressed: () => Navigator.pop(context)),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Conversation', style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
            Text('Online', style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.call_outlined, color: Colors.black), onPressed: () {}),
          IconButton(icon: const Icon(Icons.videocam_outlined, color: Colors.black), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is ChatLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is MessagesLoaded) {
                  return ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.all(16),
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final message = state.messages[index];
                      final isMe = message.sender.id == myUserId;
                      return _buildMessageBubble(message.content, isMe);
                    },
                  );
                }
                return const Center(child: Text('No messages yet. Send one!'));
              },
            ),
          ),
          _buildMessageComposer(
            controller: _messageController,
            onSend: () {
              if (_messageController.text.isNotEmpty) {
                context.read<ChatBloc>().add(SendMessageEvent(
                  chatId: widget.chat.id,
                  content: _messageController.text,
                ));
                _messageController.clear();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(String text, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFF4A4EFE) : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(text, style: TextStyle(color: isMe ? Colors.white : Colors.black)),
      ),
    );
  }

  Widget _buildMessageComposer({required TextEditingController controller, required VoidCallback onSend}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      color: Colors.white,
      child: SafeArea(
        child: Row(
          children: [
            IconButton(icon: const Icon(Icons.attach_file, color: Colors.grey), onPressed: () {}),
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Write your message',
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.send, color: Color(0xFF4A4EFE)),
                    onPressed: onSend,
                  ),
                ),
              ),
            ),
            IconButton(icon: const Icon(Icons.camera_alt_outlined, color: Colors.grey), onPressed: () {}),
            IconButton(icon: const Icon(Icons.mic_none_outlined, color: Colors.grey), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}