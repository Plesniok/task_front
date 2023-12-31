import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_front/services/storage_service.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState()) {
    on<CheckUserStorage>((event, emit) async{
      // final StorageService storageService = StorageService();

      // final String? token = await storageService.readSecureData("token");
      // final String? email = await storageService.readSecureData("email");

      // emit(state.copyWith(token: token, email: email));
    });
    
    on<LoadUserAuth>((event, emit) async {
      // final StorageService storageService = StorageService();

      // await storageService.writeSecureData(StorageItem("token", event.token));
      // await storageService.writeSecureData(StorageItem("email", event.email));

      emit(state.copyWith(token: event.token, email: event.email));
    });

    on<Logout>((event, emit) {
      emit(state.copyWith(token: null, email: null));
      print("doing");
    });
  }
}
