import 'package:flutter/material.dart';
import 'package:flutter_pro/tracker_app/session_feature/data/models/session_model.dart';

@immutable
sealed class GameSessionState {}

/*
  * this initial state as we show the inital view.
*/
class GameSessionInitial extends GameSessionState {}


class GameSessionActive extends GameSessionState {
  /*
    * in session model we hold data like list of persons, start time, end time, duration, and winner.
  */
  final SessionModel session;
  final int currentIndex;
  final bool isAddLoading; 

  GameSessionActive({
    required this.session,
    this.currentIndex = 0,
    this.isAddLoading = false,
  });
  /*
  * we use this method to create a new instance of the class with updated values.
  */
  GameSessionActive copyWith({
    SessionModel? session,
    int? currentIndex,
    bool? isAddLoading,
  }) {
    return GameSessionActive(
      session: session ?? this.session,
      currentIndex: currentIndex ?? this.currentIndex,
      isAddLoading: isAddLoading ?? this.isAddLoading,
    );
  }
}

class GameSessionEnded extends GameSessionState {
  final SessionModel finalSession;
  final String winnerName;

  GameSessionEnded({required this.finalSession, required this.winnerName});
}