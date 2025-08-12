// import 'package:bloc/bloc.dart';
// import '../../../../core/usecases/usecase.dart';
// import '../../domain/usecases/get_auth_token_usecase.dart';
// import '../../domain/usecases/login_usecase.dart';
// import '../../domain/usecases/logout_usecase.dart';
// import '../../domain/usecases/signup_usecase.dart';
// import 'auth_event.dart';
// import 'auth_state.dart';
//
// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final LoginUsecase loginUsecase;
//   final SignupUsecase signupUsecase;
//   final LogoutUsecase logoutUsecase;
//   final GetAuthTokenUsecase getAuthTokenUsecase;
//
//   AuthBloc({
//     required this.loginUsecase,
//     required this.signupUsecase,
//     required this.logoutUsecase,
//     required this.getAuthTokenUsecase,
//   }) : super(AuthInitial()) {
//     on<CheckAuthStatus>(_onCheckAuthStatus);
//     on<LoginButtonPressed>(_onLoginButtonPressed);
//     on<SignupButtonPressed>(_onSignupButtonPressed);
//     on<LogoutButtonPressed>(_onLogoutButtonPressed);
//   }
//
//   Future<void> _onCheckAuthStatus(CheckAuthStatus event, Emitter<AuthState> emit) async {
//     final (failure, token) = await getAuthTokenUsecase(NoParams());
//     if (token != null && token.isNotEmpty) {
//       emit(Authenticated());
//     } else {
//       emit(Unauthenticated());
//     }
//   }
//
//   Future<void> _onLoginButtonPressed(LoginButtonPressed event, Emitter<AuthState> emit) async {
//     emit(AuthLoading());
//     final (failure, token) = await loginUsecase(
//       LoginParams(email: event.email, password: event.password),
//     );
//     if (failure != null) {
//       emit(const AuthFailure("Login Failed: Invalid credentials."));
//     } else {
//       emit(Authenticated());
//     }
//   }
//
//   Future<void> _onSignupButtonPressed(SignupButtonPressed event, Emitter<AuthState> emit) async {
//     emit(AuthLoading());
//     final (failure, user) = await signupUsecase(
//       SignupParams(name: event.name, email: event.email, password: event.password),
//     );
//     if (failure != null) {
//       emit(const AuthFailure("Signup Failed: Please try again."));
//     } else {
//       // After a successful signup, we can treat them as logged in.
//       // A more complex flow might require them to log in after signing up.
//       emit(Authenticated());
//     }
//   }
//
//   Future<void> _onLogoutButtonPressed(LogoutButtonPressed event, Emitter<AuthState> emit) async {
//     await logoutUsecase(NoParams());
//     emit(Unauthenticated());
//   }
// }



import 'package:bloc/bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_auth_token_usecase.dart';
import '../../domain/usecases/get_me_usecase.dart'; // <-- Import the new use case
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/signup_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;
  final SignupUsecase signupUsecase;
  final LogoutUsecase logoutUsecase;
  final GetAuthTokenUsecase getAuthTokenUsecase;
  final GetMeUsecase getMeUsecase; // <-- Add the new use case

  AuthBloc({
    required this.loginUsecase,
    required this.signupUsecase,
    required this.logoutUsecase,
    required this.getAuthTokenUsecase,
    required this.getMeUsecase, // <-- Add to the constructor
  }) : super(AuthInitial()) {
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<SignupButtonPressed>(_onSignupButtonPressed);
    on<LogoutButtonPressed>(_onLogoutButtonPressed);
  }

  Future<void> _onCheckAuthStatus(CheckAuthStatus event, Emitter<AuthState> emit) async {
    final (failure, token) = await getAuthTokenUsecase(NoParams());
    if (token != null && token.isNotEmpty) {
      // If a token exists, also fetch the user profile
      final (meFailure, user) = await getMeUsecase(NoParams());
      if (meFailure == null && user != null) {
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> _onLoginButtonPressed(LoginButtonPressed event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final (failure, token) = await loginUsecase(
      LoginParams(email: event.email, password: event.password),
    );
    if (failure != null) {
      emit(const AuthFailure("Login Failed: Invalid credentials."));
    } else {
      // AFTER a successful login, we MUST get the user's details
      final (meFailure, user) = await getMeUsecase(NoParams());
      if (meFailure != null || user == null) {
        emit(const AuthFailure("Login successful, but could not fetch user profile."));
      } else {
        // Emit the state WITH the user object
        emit(Authenticated(user));
      }
    }
  }

  Future<void> _onSignupButtonPressed(SignupButtonPressed event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final (failure, user) = await signupUsecase(
      SignupParams(name: event.name, email: event.email, password: event.password),
    );
    if (failure != null || user == null) {
      emit(const AuthFailure("Signup Failed: Please try again."));
    } else {
      // After a successful signup, the API returns the user object, so we can use it directly.
      emit(Authenticated(user));
    }
  }

  Future<void> _onLogoutButtonPressed(LogoutButtonPressed event, Emitter<AuthState> emit) async {
    await logoutUsecase(NoParams());
    emit(Unauthenticated());
  }
}