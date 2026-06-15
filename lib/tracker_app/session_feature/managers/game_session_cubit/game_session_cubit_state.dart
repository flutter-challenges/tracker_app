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
    * currentPersonIndex is used to know which person is currently active in the session, and we use it to show the arrow next to the active person.
    * isAddLoading is used to show a loading indicator when we are adding a new person to the session, and we set it to true when we are adding a new person, and set it to false when the person is added.
  */
  final SessionModel session;
  final int currentPersonIndex;
  final bool isAddLoading; 
  final bool isDisabled; // this is used to indicate if the session is disabled or not, and we set it to true when the session is disabled, and set it to false when the session is enabled.
  GameSessionActive({
    required this.session,
    this.currentPersonIndex = 0,
    this.isAddLoading = false,
    this.isDisabled = false,
  });
  /*
  * we use this method to create a new instance of the class with updated values.
  */
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

class GameSessionEnded extends GameSessionState {
  final SessionModel finalSession;
  final String winnerName;

  GameSessionEnded({required this.finalSession, required this.winnerName});
}