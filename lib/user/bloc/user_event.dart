part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoadUserAuth extends UserEvent {
  LoadUserAuth(this.email, this.token);

  final String email;
  final String token;
}

class CheckUserStorage extends UserEvent {}

class Logout extends UserEvent {}
