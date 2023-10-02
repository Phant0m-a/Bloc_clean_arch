import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:inbloc_clean/features/auth/data/models/cache_data_response_modal.dart';
import '../../../data/models/login_user_request_model.dart';
import '../../../domain/usecases/cache_user_usecase.dart';
import '../../../domain/usecases/get_catched_user_usecase.dart';
import '../../../domain/usecases/login_user_usecase.dart';
import '../../../domain/usecases/logout_user_usecase.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final GetCachedUserUsecase getUser;
  final CacheUserUsecase cacheUser;
  final LoginUsecase login;
  final LogoutUserUsecase logout;
  AuthenticationBloc({
    required this.getUser,
    required this.cacheUser,
    required this.login,
    required this.logout,
  }) : super(AuthenticationInitial()) {
    on<GetCachedUserEvent>(_getCachedUserHandler);
    on<CacheUserEvent>(_cacheUserHandler);
    on<LoginUserEvent>(_loginUserHandler);
    on<LogoutUserEvent>(_logoutUserHandler);
  }

  Future<void> _getCachedUserHandler(
      GetCachedUserEvent event, Emitter<AuthenticationState> emit) async {
    emit(const LoadingState('Loading data'));

    final result = await getUser();

    result.fold((failure) => emit(GetCachedUserErrorState()),
        (user) => emit(UserLoadedState(user)));
  }

  FutureOr<void> _cacheUserHandler(
      CacheUserEvent event, Emitter<AuthenticationState> emit) async {
    final result =
        await cacheUser(CacheUserParams(name: event.name, email: event.email));

    result.fold(
        (failure) => emit(GetCachedUserErrorState()),
        (_) => emit(
            UserLoadedState(CachedUser(name: event.name, email: event.email))));
  }

  FutureOr<void> _loginUserHandler(
      LoginUserEvent event, Emitter<AuthenticationState> emit) async {
    emit(const LoadingState('Logging In...'));
    final result = await login(
        LoginUserRequestModel(email: event.email, password: event.password));

    result.fold(
        (failure) => emit(AuthenticationErrorState(message: failure.message)),
        (user) {
      if (user.code == 1) {
        return emit(const AuthenticationErrorState(message: 'invalid User'));
      } else {
        return emit(LoginState(
            CachedUser(email: user.data.email, name: user.data.name)));
      }
    });
  }

  FutureOr<void> _logoutUserHandler(
      LogoutUserEvent event, Emitter<AuthenticationState> emit) async {
    emit(const LoadingState('Logout'));

    final result = await logout();

    result.fold(
        (failure) => emit(AuthenticationErrorState(message: failure.message)),
        (_) => emit(const LogoutUserState()));
  }
}
