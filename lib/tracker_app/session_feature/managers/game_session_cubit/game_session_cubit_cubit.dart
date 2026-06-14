import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_pro/tracker_app/session_feature/managers/game_session_cubit/game_session_cubit_state.dart';
import 'package:flutter_pro/tracker_app/session_feature/data/models/session_model.dart';

class GameSessionCubit extends Cubit<GameSessionState> {
  GameSessionCubit() : super(GameSessionInitial());

  Timer? _timer;
  /*
    * when we start new session it's should that start time be DateTime.now().
    * map of persons be empty.
    * end time be null because it not yet ended.
  */
  void startNewSession() {
    _timer?.cancel();
    final newSession = SessionModel(
      startTime: DateTime.now(),
      persons: const {},
    );
    _startTimer(newSession);
  }


  /*
    *start timer method is reponsible for starting the timer and emitting the active state with the session model.
    * it work in tow cases : 
    * 1- when we start new session.
    * 2- when we load existing session.
  */
  void _startTimer(SessionModel sessionModel) {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final currentState = state;
      if (currentState is GameSessionActive) {
        emit(currentState.copyWith(session: currentState.session.copyWith()));
      }
    });
    emit(GameSessionActive(session: sessionModel));
  }


  /*
    * the stop button it appeare when length of persons > 1 & session is gameSessionActive.
    * it take last sessionModel and create new one with update endTime , then emit gameSessionEnded with final session and winner name.
  */
  void endSession() {
    if (state is GameSessionActive) {
      _timer?.cancel();
      final currentState = state as GameSessionActive;
      final endedSession = currentState.session.copyWith(
        endTime: DateTime.now(),
      );
      emit(
        GameSessionEnded(
          finalSession: endedSession,
          winnerName: endedSession.winner,
        ),
      );
    }
  }


  Future<void> addPerson(String name) async {
    if (name.trim().isEmpty || state is! GameSessionActive) return;
    final currentState = state as GameSessionActive;
    //? loading
    emit(currentState.copyWith(isAddLoading: true));
    await Future.delayed(const Duration(seconds: 1));
    //? add person at the new person at 0 "at beging of the map".
    final updatedPersons = {name: 0, ...currentState.session.persons};
    final updatedSessionModel = currentState.session.copyWith(
      persons: updatedPersons,
    );

    emit(
      currentState.copyWith(
        session: updatedSessionModel,
        isAddLoading: false,
        currentPersonIndex: 0,
      ),
    );
  }

  void incrementScore(String name) {
    if (state is GameSessionActive) {
      final currentState = state as GameSessionActive;
      final updatedPersons = Map<String, int>.from(
        currentState.session.persons,
      );
      updatedPersons[name] = (updatedPersons[name] ?? 0) + 1;

      emit(
        currentState.copyWith(
          session: currentState.session.copyWith(persons: updatedPersons),
        ),
      );
    }
  }

  void nextPerson() {
    if (state is GameSessionActive) {
      final currentState = state as GameSessionActive;
      final total = currentState.session.persons.length;
      if (total <= 1) return;

      final nextIndex = (currentState.currentPersonIndex + 1) % total;
      emit(currentState.copyWith(currentPersonIndex: nextIndex));
    }
  }

  void previousPerson() {
    if (state is GameSessionActive) {
      final currentState = state as GameSessionActive;
      final total = currentState.session.persons.length;
      if (total <= 1) return;

      int prevIndex = currentState.currentPersonIndex - 1;
      if (prevIndex < 0) prevIndex = total - 1;
      emit(currentState.copyWith(currentPersonIndex: prevIndex));
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
