import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pro/tracker_app/session_feature/presentation/widgets/add_person_text_field.dart';
import 'package:flutter_pro/tracker_app/session_feature/presentation/widgets/persons_switchers_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_pro/tracker_app/session_feature/managers/game_session_cubit/game_session_cubit_cubit.dart';
import 'package:flutter_pro/tracker_app/session_feature/managers/game_session_cubit/game_session_cubit_state.dart';
import 'package:flutter_pro/tracker_app/session_feature/presentation/widgets/session_timer.dart';
import 'package:flutter_pro/tracker_app/session_feature/presentation/widgets/arrow_widget.dart';

class TrackerActiveView extends StatefulWidget {
  final GameSessionActive gameSessionActiveState;
  const TrackerActiveView({super.key, required this.gameSessionActiveState});

  @override
  State<TrackerActiveView> createState() => _TrackerActiveViewState();
}

class _TrackerActiveViewState extends State<TrackerActiveView> {
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GameSessionCubit>();
    final sessionModel = widget.gameSessionActiveState.session;
    final bool isArrowsActive = sessionModel.persons.length > 1;

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 16.h),
            child: SessionTimer(
              timerText: sessionModel.durationString,
              currentWinner: sessionModel.winner,
            ),
          ),
          SizedBox(height: 30.h),

          AddPersonTextField(nameController: _nameController),
          SizedBox(height: 40.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ArrowWidget(
                isArrowsActive: isArrowsActive,
                onTap: () => cubit.previousPerson(),
                isLeftArrow: true,
              ),
              PersonsSwitchersWidget(
                gameSessionActiveState: widget.gameSessionActiveState,
              ),
              ArrowWidget(
                isArrowsActive: isArrowsActive,
                onTap: () => cubit.nextPerson(),
                isLeftArrow: false,
              ),
            ],
          ),
          SizedBox(height: 40.h),

          if (sessionModel.persons.isNotEmpty)
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              ),
              onPressed: () => cubit.endSession(),
              icon: const Icon(Icons.stop_rounded),
              label: const Text('Finish & Show Winner'),
            ),
        ],
      ),
    );
  }
}
