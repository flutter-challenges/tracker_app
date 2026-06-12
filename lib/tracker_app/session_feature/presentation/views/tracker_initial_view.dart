import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_pro/tracker_app/session_feature/managers/game_session_cubit/game_session_cubit_cubit.dart';

class TrackerInitialView extends StatelessWidget {
  const TrackerInitialView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(16.r),
        ),
        onPressed: () => context.read<GameSessionCubit>().startNewSession(),
        icon: const Icon(Icons.play_arrow_rounded),
        label: Text(
          'Start Session to Track',
          style: TextStyle(fontSize: 16.sp),
        ),
      ),
    );
  }
}