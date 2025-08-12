import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../domain/entities/product_entity.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';
import '../../../../core/usecases/usecase.dart'; // Import for NoParams
import '../../../chat/presentation/bloc/chat_bloc.dart';
import '../../../chat/presentation/bloc/chat_event.dart';
import '../../../chat/presentation/bloc/chat_bloc.dart';
import '../../../chat/presentation/bloc/chat_event.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Check initial auth state and load products if already authenticated
    if (context.read<AuthBloc>().state is Authenticated) {
      context.read<ProductBloc>().add(LoadAllProductEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: MultiBlocListener(
          listeners: [
            // Listens for Auth changes to trigger product loading
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is Authenticated) {
                  context.read<ProductBloc>().add(LoadAllProductEvent());
                }
              },
            ),
            // Listens for Product changes to show SnackBars and reload
            BlocListener<ProductBloc, ProductState>(
              listener: (context, state) {
                if (state is OperationSuccessState) {
                  context.read<ProductBloc>().add(LoadAllProductEvent());
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message), backgroundColor: Colors.green),
                  );
                } else if (state is ErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message), backgroundColor: Colors.red),
                  );
                }
              },
            ),
          ],
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is LoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is LoadedAllProductState) {
                if (state.products.isEmpty) {
                  return Column(children: [_buildHeader(context), _buildTitleBar(context), const Expanded(child: Center(child: Text('No products found. Add one!')))],);
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: state.products.length + 2,
                  itemBuilder: (context, index) {
                    if (index == 0) return _buildHeader(context);
                    if (index == 1) return _buildTitleBar(context);
                    final product = state.products[index - 2];
                    return Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/detail', arguments: product);
                        },
                        child: ProductCard(product: product),
                      ),
                    );
                  },
                );
              }
              return const Center(child: CircularProgressIndicator()); // Default loading state
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-update');
        },
        backgroundColor: const Color(0xFF4A4EFE),
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  // This is the complete and final helper method for your HomePage header.

  // Widget _buildHeader(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 24.0),
  //     child: Row(
  //       children: [
  //         // User Avatar Placeholder
  //         Container(
  //           width: 50,
  //           height: 50,
  //           decoration: BoxDecoration(
  //             color: Colors.grey[200],
  //             borderRadius: BorderRadius.circular(12),
  //           ),
  //         ),
  //         const SizedBox(width: 12),
  //
  //         // User Greeting Text
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             const Text('July 14, 2023', style: TextStyle(color: Colors.grey, fontSize: 12)),
  //             RichText(
  //               text: const TextSpan(
  //                 style: TextStyle(fontSize: 18, color: Colors.black),
  //                 children: [
  //                   TextSpan(text: 'Hello, '),
  //                   TextSpan(text: 'Yohannes', style: TextStyle(fontWeight: FontWeight.bold)),
  //                 ],
  //               ),
  //             )
  //           ],
  //         ),
  //
  //         // Spacer to push all buttons to the right
  //         const Spacer(),
  //
  //         // --- THIS IS THE CORRECTED PART WITH ALL THREE BUTTONS ---
  //
  //         // 1. The "New Chat / Find User" Button (Temporary)
  //         Container(
  //           decoration: BoxDecoration(
  //             border: Border.all(color: Colors.grey[300]!),
  //             borderRadius: BorderRadius.circular(12),
  //           ),
  //           child: IconButton(
  //             icon: const Icon(Icons.person_add_alt_1, color: Colors.blueAccent),
  //             // In _buildHeader in HomePage
  //             onPressed: () async { // <-- Make it async
  //               const otherUserId = "ID_OF_THE_OTHER_USER";
  //
  //               // Dispatch the event
  //               context.read<ChatBloc>().add(CreateChatEvent(userId: otherUserId));
  //
  //               // Give a feedback SnackBar
  //               ScaffoldMessenger.of(context).showSnackBar(
  //                 const SnackBar(content: Text('Starting new chat...')),
  //               );
  //
  //               // IMPORTANT: Wait a moment for the server to process, then go to the chat list
  //               await Future.delayed(const Duration(seconds: 2));
  //               Navigator.pushNamed(context, '/chat-list');
  //             },
  //           ),
  //         ),
  //         const SizedBox(width: 8),
  //
  //         // 2. The Chat List Button
  //         Container(
  //           decoration: BoxDecoration(
  //             border: Border.all(color: Colors.grey[300]!),
  //             borderRadius: BorderRadius.circular(12),
  //           ),
  //           child: IconButton(
  //             icon: const Icon(Icons.chat_bubble_outline, color: Colors.black54),
  //             onPressed: () {
  //               Navigator.pushNamed(context, '/chat-list');
  //             },
  //           ),
  //         ),
  //         const SizedBox(width: 8),
  //
  //         // 3. The Logout Button
  //         Container(
  //           decoration: BoxDecoration(
  //             border: Border.all(color: Colors.grey[300]!),
  //             borderRadius: BorderRadius.circular(12),
  //           ),
  //           child: IconButton(
  //             icon: const Icon(Icons.logout, color: Colors.red),
  //             onPressed: () {
  //               context.read<AuthBloc>().add(LogoutButtonPressed());
  //               Navigator.of(context).pushNamedAndRemoveUntil('/splash', (route) => false);
  //             },
  //           ),
  //         ),
  //         // --- END OF CORRECTED PART ---
  //       ],
  //     ),
  //   );
  // }

  // You will need to add these two imports at the top of your home_page.dart


// ... inside the _HomePageState class ...

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        children: [
          Container(width: 50, height: 50, decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(12))),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('July 14, 2023', style: TextStyle(color: Colors.grey, fontSize: 12)),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  children: [
                    TextSpan(text: 'Hello, '),
                    TextSpan(text: 'Yohannes', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              )
            ],
          ),
          const Spacer(),

          // --- THIS IS THE FINAL BUTTON SETUP FOR YOUR DEMO ---

          // 1. "New Chat" Shortcut Button
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(12)),
            child: IconButton(
              tooltip: 'Start Chat with a Specific User',
              icon: const Icon(Icons.person_add, color: Colors.blueAccent),
              onPressed: () {

                const otherUserId = "68984ee1325fc48b07cf29a7";


                context.read<ChatBloc>().add(CreateChatEvent(userId: otherUserId));

                // Show feedback and tell the user what to do next
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Chat created! Go to the chat list to see it.')),
                );
              },
            ),
          ),
          const SizedBox(width: 8),

          // 2. The Chat List Button
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(12)),
            child: IconButton(
              icon: const Icon(Icons.chat_bubble_outline, color: Colors.black54),
              onPressed: () {
                Navigator.pushNamed(context, '/chat-list');
              },
            ),
          ),
          const SizedBox(width: 8),

          // 3. The Logout Button
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(12)),
            child: IconButton(
              icon: const Icon(Icons.logout, color: Colors.red),
              onPressed: () {
                context.read<AuthBloc>().add(LogoutButtonPressed());
                Navigator.of(context).pushNamedAndRemoveUntil('/splash', (route) => false);
              },
            ),
          ),
        ],
      ),
    );
  }






  Widget _buildTitleBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Available Products', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black)),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(12)),
          child: IconButton(
            icon: const Icon(Icons.search, color: Colors.black54),
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
          ),
        ),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductEntity product;
  const ProductCard({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black12,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 180,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const SizedBox(height: 180, child: Center(child: CircularProgressIndicator()));
              },
              errorBuilder: (context, error, stackTrace) {
                return const SizedBox(height: 180, child: Icon(Icons.broken_image, size: 50, color: Colors.grey));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    Text('\$${product.price.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(product.category ?? 'General', style: const TextStyle(color: Colors.grey, fontSize: 14)),
                    if (product.rating != null)
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 18),
                          const SizedBox(width: 4),
                          Text('(${product.rating})', style: const TextStyle(color: Colors.grey, fontSize: 14)),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}