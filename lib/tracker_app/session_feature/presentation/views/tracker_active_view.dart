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
    
    final bool isDisabled = widget.gameSessionActiveState.isDisabled; 
    final bool isArrowsActive = sessionModel.persons.length > 1 && !isDisabled;

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.5),
                  ),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                  onPressed: () => cubit.pauseActiveSession(),
                ),
                Text(
                  'Live Session',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 40),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 16.h),
            child: SessionTimer(
              timerText: sessionModel.durationInMinutesAndSeconds,
              currentWinner: sessionModel.winner,
            ),
          ),
          SizedBox(height: 30.h),

          AbsorbPointer(
            absorbing: isDisabled, 
            child: Opacity(
              opacity: isDisabled ? 0.5 : 1, 
              child: AddPersonTextField(nameController: _nameController),
            ),
          ),
          SizedBox(height: 40.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ArrowWidget(
                isArrowsActive: isArrowsActive, 
                onTap: () => cubit.previousPerson(),
                isLeftArrow: true,
              ),
              Opacity(
                opacity: isDisabled ? 0.6 : 1.0,
                child: PersonsSwitchersWidget(
                  gameSessionActiveState: widget.gameSessionActiveState,
                ),
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        elevation: 2,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      onPressed: () => cubit.endSession(),
                      icon: const Icon(Icons.stop_rounded),
                      label: Text(
                        'Finish Session',
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),

                  Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDisabled ? Colors.green : Colors.orange,
                          foregroundColor: Colors.white,
                          elevation: 2,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        onPressed: () {
                          if (isDisabled) {
                            cubit.enableSession();
                          } else {
                            cubit.disableSession();
                          }
                        },
                        icon: Icon(isDisabled ? Icons.play_arrow_rounded : Icons.pause_rounded),
                        label: Text(
                          isDisabled ? 'Enable' : 'Disable',
                          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}