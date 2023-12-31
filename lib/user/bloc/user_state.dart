part of 'user_bloc.dart';

class UserState extends Equatable {
  UserState({this.token, this.email});

  String? token;
  String? email;

  UserState copyWith({String? token, String? email}) {
    return UserState(
      token: token,
      email: email,
    );
  }

  @override
  List<Object> get props => [];
}
