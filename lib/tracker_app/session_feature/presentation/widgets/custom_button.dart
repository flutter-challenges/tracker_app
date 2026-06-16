import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  const CustomButton({super.key, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(padding: EdgeInsets.all(16.r)),
        // onPressed: () => context.read<GameSessionCubit>().startNewSession(),
        onPressed: onPressed,
        icon: const Icon(Icons.play_arrow_rounded),
        label: Text(
          // 'Start Session to Track',
          title,
          style: TextStyle(fontSize: 16.sp),
        ),
      ),
    );
  }
}
