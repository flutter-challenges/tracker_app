import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pro/tracker_app/session_feature/presentation/views/tracker_active_view.dart';
import 'package:flutter_pro/tracker_app/session_feature/presentation/views/tracker_initial_view.dart';
import 'package:flutter_pro/tracker_app/session_feature/presentation/widgets/show_ended_dialog.dart';
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
            listener: (context, state) {
              if (state is GameSessionEnded) {
                showSessionEndedDialog(context, state);
              }
            },
            listenWhen: (previous, current) => current is GameSessionEnded,
            buildWhen: (previous, current) => current is! GameSessionEnded,
            builder: (context, state) {
              return switch (state) {
                GameSessionInitial() => const TrackerInitialView(),
                GameSessionActivePaused() => const TrackerInitialView(),
                GameSessionActive() => TrackerActiveView(gameSessionActiveState: state),
                _ => const SizedBox.shrink(),
              };
            },
          ),
        ),
      ),
    );
  }
}