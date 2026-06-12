import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pro/tracker_app/session_feature/presentation/views/tracker_active_view.dart';
import 'package:flutter_pro/tracker_app/session_feature/presentation/views/tracker_initial_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_pro/tracker_app/session_feature/managers/game_session_cubit/game_session_cubit_cubit.dart';
import 'package:flutter_pro/tracker_app/session_feature/managers/game_session_cubit/game_session_cubit_state.dart';

class TrackerAppView extends StatelessWidget {
  const TrackerAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameSessionCubit(),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<GameSessionCubit, GameSessionState>(

            //* we take action when state changes like in our case when session ends we show endded dialog.
            listener: (context, state) {
              if (state is GameSessionEnded) {
                _showSessionEndedDialog(context, state);
              }
            },
            listenWhen: (previous, current) => current is GameSessionEnded,

            buildWhen: (previous, current) => current is! GameSessionEnded,

            //* here we determine wether body should show initial view or active view.
            builder: (context, state) {
              return switch (state) {
                GameSessionInitial() => const TrackerInitialView(),
                GameSessionActive() => TrackerActiveView(gameSessionActiveState: state),
                _ => const SizedBox.shrink(),
              };
            },
          ),
        ),
      ),
    );
  }

  void _showSessionEndedDialog(BuildContext context, GameSessionEnded state) {
    final cubit = context.read<GameSessionCubit>();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: const Text('🎉 Session Ended!'),
        content: Text(
          'The Winner is: ${state.winnerName}\n'
          'Total Duration: ${state.finalSession.duration.inMinutes} mins : ${state.finalSession.duration.inSeconds} secs',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              cubit.startNewSession();
            },
            child: const Text('Start New Session'),
          ),
        ],
      ),
    );
  }
}
