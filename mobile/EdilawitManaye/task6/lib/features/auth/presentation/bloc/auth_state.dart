import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

// The initial state, before we have checked for an existing login
class AuthInitial extends AuthState {}

// The state when an authentication action is in progress (e.g., calling the API)
class AuthLoading extends AuthState {}

// The state when the user is successfully logged in
class Authenticated extends AuthState {}

// The state when the user is not logged in
class Unauthenticated extends AuthState {}

// The state when an authentication action has failed (e.g., wrong password)
class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object> get props => [message];
}