import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:users_bloc/models/user_model.dart';

@immutable
abstract class UserState extends Equatable {}

// Data Loading state
class UserLoadingState extends UserState {
  @override
  List<Object?> get props => [];
}

//Data Loaded State
class UserLoadedState extends UserState {
  UserLoadedState(this.users);
  final List<UserModel> users;
  @override
  List<Object?> get props => [];
}

//Data Error State
class DataErrorState extends UserState {
  DataErrorState(this.error);
  final String error;
  @override
  List<Object?> get props => [error];
}
