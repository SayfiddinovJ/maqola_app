import 'package:columnist/data/models/user/user_model.dart';

class UserState {
  final UserModel userModel;
  final String error;

  UserState({required this.userModel, required this.error});

  UserState copyWith({
    UserModel? userModel,
    String? error,
  }) =>
      UserState(
          userModel: userModel ?? this.userModel, error: error ?? this.error);
}
