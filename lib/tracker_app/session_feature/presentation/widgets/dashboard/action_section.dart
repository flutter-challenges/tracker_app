import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pro/tracker_app/session_feature/managers/game_session_cubit/game_session_cubit_cubit.dart';
import 'package:flutter_pro/tracker_app/session_feature/managers/game_session_cubit/game_session_cubit_state.dart';
import 'package:flutter_pro/tracker_app/session_feature/presentation/widgets/custom_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActionSection extends StatelessWidget {
  const ActionSection({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.read<GameSessionCubit>();
    return BlocBuilder<GameSessionCubit, GameSessionState>(
      builder: (context, state) {
        final bool hasPausedActiveSession = state is GameSessionActivePaused;
        return Column(
          children: [
            CustomButton(
              title: 'Start New Session',
              subtitle: 'Begin recording your live game session',
              icon: Icons.play_circle_filled_rounded,
              color: theme.colorScheme.primary,
              onTap: () => cubit.startNewSession(),
            ),
            SizedBox(height: 16.h),
            CustomButton(
              title: hasPausedActiveSession ? 'Resume Current Session ⚡' : 'Track your current Session!',
              subtitle: hasPausedActiveSession 
                  ? 'Click to return to your live ongoing session' 
                  : 'View history and past session metrics',
              color: hasPausedActiveSession ? Colors.green : theme.colorScheme.secondary,
              icon: hasPausedActiveSession ? Icons.bolt_rounded : Icons.analytics_rounded,
              onTap: () {
                if (hasPausedActiveSession) {
                  cubit.resumeSession();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('No active session running! Click "Start New Session".'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 16.h),

            CustomButton(
              title: 'Last Sessions History',
              subtitle: 'View history and past session metrics',
              icon: Icons.history_rounded,
              color: theme.colorScheme.secondary,
              onTap: () {},
            ),
          ],
        );
      },
    );
  }
}