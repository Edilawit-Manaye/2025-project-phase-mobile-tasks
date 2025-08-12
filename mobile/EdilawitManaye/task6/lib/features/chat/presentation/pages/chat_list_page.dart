// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../auth/presentation/bloc/auth_bloc.dart'; // Import AuthBloc
// import '../../../auth/presentation/bloc/auth_state.dart'; // Import AuthState
// import '../../domain/entities/chat_entity.dart';
// // CORRECT
// import '../../../auth/domain/entities/user_entity.dart';
// import '../bloc/chat_bloc.dart';
// import '../bloc/chat_event.dart';
// import '../bloc/chat_state.dart';
//
// class ChatListPage extends StatefulWidget {
//   const ChatListPage({super.key});
//   @override
//   State<ChatListPage> createState() => _ChatListPageState();
// }
//
// class _ChatListPageState extends State<ChatListPage> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<ChatBloc>().add(LoadChatsEvent());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Get the current authenticated user's state
//     final authState = context.watch<AuthBloc>().state;
//     UserEntity? currentUser;
//     if (authState is Authenticated) {
//       // In a real app, the Authenticated state would hold the UserEntity
//       // For now, we'll need to fetch it or pass it. This is a simplification.
//       // Let's assume the AuthBloc can provide the current user.
//     }
//
//
//     return Scaffold(
//       backgroundColor: const Color(0xFF4A4EFE),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent, elevation: 0,
//         title: const Text('Chats', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//         leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
//         actions: [IconButton(icon: const Icon(Icons.search, color: Colors.white), onPressed: () {})],
//       ),
//       body: Column(
//         children: [
//           const SizedBox(height: 120, child: Center(child: Text('Statuses Section', style: TextStyle(color: Colors.white54)))),
//           Expanded(
//             child: Container(
//               decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
//               child: BlocBuilder<ChatBloc, ChatState>(
//                 builder: (context, state) {
//                   if (state is ChatLoading) {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//                   if (state is ChatsLoaded) {
//                     if (state.chats.isEmpty) {
//                       return const Center(child: Text('No active chats.'));
//                     }
//                     return ListView.builder(
//                       padding: const EdgeInsets.only(top: 16),
//                       itemCount: state.chats.length,
//                       itemBuilder: (context, index) {
//                         final chat = state.chats[index];
//
//                         // --- THIS IS THE FINAL, CORRECTED LOGIC ---
//                         // We need to know our own ID to find the other user.
//                         // This is a placeholder. In a real app, you would get this
//                         // from your AuthBloc's state.
//                         const myUserId = "YOUR_LOGGED_IN_USER_ID"; // <-- You need to get this ID
//
//                         // Check which user in the chat is NOT me.
//                         final otherUser = chat.user1.id == myUserId ? chat.user2 : chat.user1;
//
//                         return _buildChatListItem(context, chat, otherUser.name, 'Last message...', '2 min ago', 0);
//                       },
//                     );
//                   }
//                   if (state is ChatError) {
//                     return Center(child: Text(state.message));
//                   }
//                   return const Center(child: Text('Loading your chats...'));
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildChatListItem(BuildContext context, ChatEntity chat, String name, String message, String time, int unreadCount) {
//     return ListTile(
//       leading: const CircleAvatar(radius: 28, backgroundColor: Colors.grey),
//       title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
//       subtitle: Text(message, maxLines: 1, overflow: TextOverflow.ellipsis),
//       trailing: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
//           const SizedBox(height: 4),
//           if (unreadCount > 0)
//             CircleAvatar(radius: 12, backgroundColor: const Color(0xFF4A4EFE), child: Text(unreadCount.toString(), style: const TextStyle(color: Colors.white, fontSize: 12))),
//         ],
//       ),
//       onTap: () => Navigator.pushNamed(context, '/chat', arguments: chat),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// --- THIS IS THE CORRECTED IMPORT PATH ---
import '../../../auth/domain/entities/user_entity.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../domain/entities/chat_entity.dart';
import '../bloc/chat_bloc.dart';
import '../bloc/chat_event.dart';
import '../bloc/chat_state.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});
  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(LoadChatsEvent());
  }

  @override
  Widget build(BuildContext context) {
    // Get the current authenticated user's state to find our own ID
    final authState = context.watch<AuthBloc>().state;

    return Scaffold(
      backgroundColor: const Color(0xFF4A4EFE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Chats', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
        actions: [IconButton(icon: const Icon(Icons.search, color: Colors.white), onPressed: () {})],
      ),
      body: Column(
        children: [
          const SizedBox(height: 120, child: Center(child: Text('Statuses Section', style: TextStyle(color: Colors.white54)))),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              ),
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  if (state is ChatLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is ChatsLoaded) {
                    if (state.chats.isEmpty) {
                      return const Center(child: Text('No active chats.'));
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.only(top: 16),
                      itemCount: state.chats.length,
                      itemBuilder: (context, index) {
                        final chat = state.chats[index];

                        // --- THIS IS THE FINAL, CORRECTED LOGIC ---
                        if (authState is Authenticated) {
                          final currentUser = authState.user;
                          // Check which user in the chat is NOT me.
                          final otherUser = chat.user1.id == currentUser.id ? chat.user2 : chat.user1;

                          return _buildChatListItem(context, chat, otherUser.name, 'Last message...', '2 min ago', 0);
                        }
                        // Return an empty container if we are not authenticated for some reason
                        return const SizedBox.shrink();
                      },
                    );
                  }
                  if (state is ChatError) {
                    return Center(child: Text(state.message));
                  }
                  return const Center(child: Text('Loading your chats...'));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatListItem(BuildContext context, ChatEntity chat, String name, String message, String time, int unreadCount) {
    return ListTile(
      leading: const CircleAvatar(radius: 28, backgroundColor: Colors.grey),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(message, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 4),
          if (unreadCount > 0)
            CircleAvatar(radius: 12, backgroundColor: const Color(0xFF4A4EFE), child: Text(unreadCount.toString(), style: const TextStyle(color: Colors.white, fontSize: 12))),
        ],
      ),
      onTap: () => Navigator.pushNamed(context, '/chat', arguments: chat),
    );
  }
}