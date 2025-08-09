import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

// Event to check if a user is already logged in when the app starts
class CheckAuthStatus extends AuthEvent {}

// Event triggered when the user taps the login button
class LoginButtonPressed extends AuthEvent {
  final String email;
  final String password;

  const LoginButtonPressed({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

// Event triggered when the user taps the sign-up button
class SignupButtonPressed extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const SignupButtonPressed({required this.name, required this.email, required this.password});

  @override
  List<Object> get props => [name, email, password];
}

// Event triggered when the user taps the logout button
class LogoutButtonPressed extends AuthEvent {}