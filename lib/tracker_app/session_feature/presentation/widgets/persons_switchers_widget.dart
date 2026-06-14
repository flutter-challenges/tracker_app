import 'dart:developer';

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

  Widget _buildCarouselContent(GameSessionActive gameSessionActiveState) {
    /*
      * if isLoading true we show CircularProgressIndicator.
      * if the list of persons is empty we show a text to indicate that there are no "persons to track".
      * otherwise we show the current active person with their score.
    */
    if (gameSessionActiveState.isAddLoading) {
      return CircularProgressIndicator(
        key: const ValueKey('loading'),
        strokeWidth: 3.sp,
      );
    }

    if (gameSessionActiveState.session.persons.isEmpty) {
      return Text(
        'No persons to track yet!\nAdd someone above.',
        key: const ValueKey('empty'),
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.grey, fontSize: 16.sp),
      );
    }
    /*
      * we have extract currnet person index from the gameSessionActiveState.
      * to get map of person as <name , score>.
    */
    final currentPersonEntry = gameSessionActiveState.session.persons.entries.elementAt(
      gameSessionActiveState.currentPersonIndex,
    );

    log(
      'Current Person: ${currentPersonEntry.key}, Score: ${currentPersonEntry.value} , {Index: ${gameSessionActiveState.currentPersonIndex}}',
    );

    return PersonTracker(
      key: ValueKey(currentPersonEntry.key),
      name: currentPersonEntry.key,
      score: currentPersonEntry.value,
    );

  }
}
