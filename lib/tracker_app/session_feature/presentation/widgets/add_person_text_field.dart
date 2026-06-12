import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pro/tracker_app/session_feature/managers/game_session_cubit/game_session_cubit_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddPersonTextField extends StatelessWidget {
  const AddPersonTextField({
    super.key,
    required TextEditingController nameController,
  }) : _nameController = nameController;

  final TextEditingController _nameController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300.w,
      child: TextField(
        controller: _nameController,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
          filled: true,
          fillColor: Colors.grey.withOpacity(0.05),
          hintText: 'Enter the name for a person to track',
          prefixIcon: const Icon(Icons.person_add_rounded, color: Colors.blue),
        ),
        onSubmitted: (value) {
          if (value.trim().isNotEmpty) {
            // cubit.addPerson(value.trim()); // نمرر القيمة النصية فقط للـ Cubit
            context.read<GameSessionCubit>().addPerson(value.trim());
            _nameController.clear();
          }
        },
      ),
    );
  }
}