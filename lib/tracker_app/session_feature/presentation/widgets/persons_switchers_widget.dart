import 'package:flutter/material.dart';
import 'package:flutter_pro/tracker_app/session_feature/managers/game_session_cubit/game_session_cubit_state.dart';
import 'package:flutter_pro/tracker_app/session_feature/presentation/widgets/person_tacker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonsSwitchersWidget extends StatelessWidget {
  final GameSessionActive gameSessionActiveState;
  const PersonsSwitchersWidget({
    super.key,
    required this.gameSessionActiveState,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 180.h,
        width: 240.w,
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: ScaleTransition(scale: animation, child: child),
            ),
            child: _buildCarouselContent(gameSessionActiveState),
          ),
        ),
      ),
    );
  }

  Widget _buildCarouselContent(GameSessionActive state) {
    if (state.isAddLoading) {
      return CircularProgressIndicator(
        key: const ValueKey('loading'),
        strokeWidth: 3.sp,
      );
    }

    if (state.session.persons.isEmpty) {
      return Text(
        'No persons to track yet!\nAdd someone above.',
        key: const ValueKey('empty'),
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.grey, fontSize: 16.sp),
      );
    }

    final currentEntry = state.session.persons.entries.elementAt(
      state.currentIndex,
    );
    return PersonTracker(
      key: ValueKey(currentEntry.key),
      name: currentEntry.key,
      score: currentEntry.value,
      session: state.session,
    );
  }
}
