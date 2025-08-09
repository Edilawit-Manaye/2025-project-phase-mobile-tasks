import 'package:bloc/bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_auth_token_usecase.dart';
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

  AuthBloc({
    required this.loginUsecase,
    required this.signupUsecase,
    required this.logoutUsecase,
    required this.getAuthTokenUsecase,
  }) : super(AuthInitial()) {
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<SignupButtonPressed>(_onSignupButtonPressed);
    on<LogoutButtonPressed>(_onLogoutButtonPressed);
  }

  Future<void> _onCheckAuthStatus(CheckAuthStatus event, Emitter<AuthState> emit) async {
    final (failure, token) = await getAuthTokenUsecase(NoParams());
    if (token != null && token.isNotEmpty) {
      emit(Authenticated());
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
      emit(Authenticated());
    }
  }

  Future<void> _onSignupButtonPressed(SignupButtonPressed event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final (failure, user) = await signupUsecase(
      SignupParams(name: event.name, email: event.email, password: event.password),
    );
    if (failure != null) {
      emit(const AuthFailure("Signup Failed: Please try again."));
    } else {
      // After a successful signup, we can treat them as logged in.
      // A more complex flow might require them to log in after signing up.
      emit(Authenticated());
    }
  }

  Future<void> _onLogoutButtonPressed(LogoutButtonPressed event, Emitter<AuthState> emit) async {
    await logoutUsecase(NoParams());
    emit(Unauthenticated());
  }
}