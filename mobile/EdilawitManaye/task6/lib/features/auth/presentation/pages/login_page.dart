import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Controllers to get the text from the input fields
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    // Set default credentials for easy testing, as per the documentation
    emailController.text = 'user@gmail.com';
    passwordController.text = 'userpassword';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              // If login is successful, go to the home page and remove all previous pages.
              Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
            } else if (state is AuthFailure) {
              // If login fails, show an error message.
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message), backgroundColor: Colors.red),
              );
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch, // Make buttons stretch to full width
              children: [
                const SizedBox(height: 80),
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300, width: 2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text('ECOM', style: TextStyle(color: Color(0xFF4258F8), fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                  ),
                ),
                const SizedBox(height: 80),
                const Text('Sign into your account', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(height: 40),

                // --- THIS IS THE MISSING PART ---
                _buildTextField(label: 'Email', controller: emailController, hint: 'ex: jon.smith@email.com', keyboardType: TextInputType.emailAddress),
                const SizedBox(height: 20),
                _buildTextField(label: 'Password', controller: passwordController, hint: '**********', obscureText: true),
                // --- END OF MISSING PART ---

                const SizedBox(height: 40),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    // Show a loading indicator while the app is logging in
                    if (state is AuthLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ElevatedButton(
                      onPressed: () {
                        // When the button is pressed, dispatch the event to the BLoC
                        context.read<AuthBloc>().add(LoginButtonPressed(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        ));
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: const Color(0xFF4A4EFE),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('SIGN IN', style: TextStyle(fontWeight: FontWeight.bold)),
                    );
                  },
                ),

                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/signup'),
                      child: const Text('SIGN UP'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // A reusable helper method to avoid duplicating text field code
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hint,
    bool obscureText = false,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            filled: true,
            fillColor: Colors.grey.shade100,
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}