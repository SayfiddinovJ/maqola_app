import 'package:columnist/cubits/user/user_cubit.dart';
import 'package:columnist/data/models/user/user_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenderSelector extends StatelessWidget {
  const GenderSelector({super.key});


  @override
  Widget build(BuildContext context) {
    String selectedValue = context.watch<UserCubit>().state.userModel.gender;
    return Column(
      children: [
        RadioListTile(
          activeColor: Colors.white,
          value: 'Male',
          groupValue: selectedValue,
          onChanged: (value) {
            selectedValue = value!;
            context
                .read<UserCubit>()
                .updateUserFields(field: UserField.gender, value: value);
          },
          title: const Text(
            'Male',
            style: TextStyle(color: Colors.white),
          ),
        ),
        RadioListTile(
          activeColor: Colors.white,
          value: 'Female',
          groupValue: selectedValue,
          onChanged: (value) {
            selectedValue = value!;
            context
                .read<UserCubit>()
                .updateUserFields(field: UserField.gender, value: value);
          },
          title: const Text(
            'Female',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
