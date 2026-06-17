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
            //* we take action when state changes like in our case when session ends we show endded dialog.
            listener: (context, state) {
              if (state is GameSessionEnded) {
                showSessionEndedDialog(context, state);
              }
            },
            /*
              * listenWhen : 
              * it work when state changes into GameSessionEnded and show Ended dialog.
            */
            listenWhen: (previous, current) => current is GameSessionEnded,

            /*
              * buildWhen : 
              * it work with all states like GameSessionInitial, GameSessionActive but not with GameSessionEnded.
              * it works as changes tracker view from initial into active.
            */
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

}
