import 'package:flutter/material.dart';
import 'package:flutter_pro/tracker_app/session_feature/data/models/session_model.dart';

@immutable
sealed class GameSessionState {}

class GameSessionInitial extends GameSessionState {}

class GameSessionActive extends GameSessionState {
  final SessionModel session;
  final int currentPersonIndex;
  final bool isAddLoading; 
  final bool isDisabled;

  GameSessionActive({
    required this.session,
    this.currentPersonIndex = 0,
    this.isAddLoading = false,
    this.isDisabled = false,
  });

  GameSessionActive copyWith({
    SessionModel? session,
    int? currentPersonIndex,
    bool? isAddLoading,
    bool? isDisabled,
  }) {
    return GameSessionActive(
      session: session ?? this.session,
      currentPersonIndex: currentPersonIndex ?? this.currentPersonIndex,
      isAddLoading: isAddLoading ?? this.isAddLoading,
      isDisabled: isDisabled ?? this.isDisabled,
    );
  }
}
/*
  * the only thing different between GameSessionActive state & GameSessionActiveHidden state is only isAddLoading.
*/
class GameSessionActivePaused extends GameSessionState {
  final SessionModel session;
  final int currentPersonIndex;
  final bool isDisabled;

  GameSessionActivePaused({
    required this.session,
    required this.currentPersonIndex,
    required this.isDisabled,
  });
}

class GameSessionEnded extends GameSessionState {
  final SessionModel finalSession;
  final String winnerName;

  GameSessionEnded({required this.finalSession, required this.winnerName});
}