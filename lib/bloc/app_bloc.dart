import 'package:flutter_bloc/flutter_bloc.dart';
import '../repo/repository.dart';
import 'app_event.dart';
import 'app_states.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc(this._userRepository) : super(UserLoadingState()) {
    on<LoadUserEvent>((event, emit) async {
      emit(UserLoadingState());
      print("you are in the first state");
      try {
        final users = await _userRepository.getUsers();
        emit(UserLoadedState(users));
        print("you are in the second state");
      } catch (e) {
        emit(DataErrorState(e.toString()));
        print("you are in the error state");
      }

      // emit(DataErrorState());
      // print("Sorry, but there is an error");
    });
  }
}
