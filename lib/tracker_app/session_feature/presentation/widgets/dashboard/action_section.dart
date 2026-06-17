import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pro/tracker_app/session_feature/managers/game_session_cubit/game_session_cubit_cubit.dart';
import 'package:flutter_pro/tracker_app/session_feature/presentation/widgets/custom_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActionSection extends StatelessWidget {
  const ActionSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        CustomButton(
          title: 'Start New Session',
          subtitle: 'Begin recording your live game session',
          icon: Icons.play_circle_filled_rounded,
          color: theme.colorScheme.primary,
          onTap: () => context.read<GameSessionCubit>().startNewSession(),
        ),
        SizedBox(height: 16.h),
        CustomButton(
          title: 'Track your current Session!',
          subtitle: 'View history and past session metrics',
          icon: Icons.currency_bitcoin,
          color: theme.colorScheme.secondary,
          onTap: () {},
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
  }
}
