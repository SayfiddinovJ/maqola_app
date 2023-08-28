import 'package:columnist/data/models/user/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {}

class ProfileInitial extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileLoadingState extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileSuccessState extends ProfileState {
  final UserModel userModel;

  ProfileSuccessState({required this.userModel});

  @override
  List<Object?> get props => [userModel];
}

class ProfileErrorState extends ProfileState {
  final String error;

  ProfileErrorState({required this.error});

  @override
  List<Object?> get props => [error];
}