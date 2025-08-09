import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // After a delay, check the auth status
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        context.read<AuthBloc>().add(CheckAuthStatus());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Navigator.of(context).pushReplacementNamed('/');
        }
        if (state is Unauthenticated) {
          Navigator.of(context).pushReplacementNamed('/login');
        }
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/bestShoes.jpg"), // Add your background image
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            color: const Color.fromRGBO(66, 88, 248, 0.85),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text('ECOM', style: TextStyle(color: Color(0xFF4258F8), fontSize: 48, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 16),
                  const Text('ECOMMERCE APP', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600, letterSpacing: 3)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}