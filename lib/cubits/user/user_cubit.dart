import 'package:columnist/cubits/user/user_state.dart';
import 'package:columnist/data/models/user/user_fields.dart';
import 'package:columnist/data/models/user/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit()
      : super(
          UserState(
            userModel: UserModel(
              username: '',
              contact: '',
              email: '',
              password: '',
              avatar: '',
              profession: '',
              role: '',
              gender: '',
            ),
            error: '',
          ),
        );

  updateUserFields({required UserField field, required dynamic value}) {
    UserModel user = state.userModel;

    switch (field) {
      case UserField.username:
        user = user.copyWith(username: value as String);
        break;
      case UserField.contact:
        user = user.copyWith(contact: value as String);
        break;
      case UserField.email:
        user = user.copyWith(email: value as String);
        break;
      case UserField.password:
        user = user.copyWith(password: value as String);
        break;
      case UserField.profession:
        user = user.copyWith(profession: value as String);
        break;
      case UserField.role:
        user = user.copyWith(role: value as String);
        break;
      case UserField.gender:
        user = user.copyWith(gender: value as String);
        break;
      case UserField.avatar:
        user = user.copyWith(avatar: value as String);
        break;
    }

    debugPrint(user.toString());

    emit(state.copyWith(userModel: user));
  }

  bool canRegister() {
    UserModel user = state.userModel;

    if (user.username.isEmpty) {
      return false;
    }
    if (user.contact.length < 9) {
      return false;
    }
    if (user.email.isEmpty) {
      return false;
    }
    if (user.password.length < 8) {
      return false;
    }
    if (user.profession.isEmpty) {
      return false;
    }
    if (user.gender.isEmpty) {
      return false;
    }
    if (user.avatar.isEmpty) {
      return false;
    }
    return true;
  }

  clear() {
    UserModel(
      username: '',
      contact: '',
      email: '',
      password: '',
      avatar: '',
      profession: '',
      role: '',
      gender: '',
    );
  }
}
