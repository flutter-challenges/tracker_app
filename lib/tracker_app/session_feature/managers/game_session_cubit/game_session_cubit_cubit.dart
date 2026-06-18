import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pro/tracker_app/session_feature/managers/game_session_cubit/game_session_cubit_state.dart';
import 'package:flutter_pro/tracker_app/session_feature/data/models/session_model.dart';

class GameSessionCubit extends Cubit<GameSessionState> {
  GameSessionCubit() : super(GameSessionInitial());
  Timer? _timer;

  void startNewSession() {
    _stopTimer();
    final newSession = SessionModel(
      startTime: DateTime.now(),
      persons: const {},
    );
    _startTimer(newSession);
  }

  void _startTimer(
    SessionModel sessionModel, {
    int currentPersonIndex = 0, 
    bool isDisabled = false,
  }) {
    _stopTimer();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final currentState = state;
      if (currentState is GameSessionActive) {
        emit(currentState.copyWith(session: currentState.session.copyWith()));
      }
    });

    emit(
      GameSessionActive(
        session: sessionModel,
        currentPersonIndex: currentPersonIndex,
        isDisabled: isDisabled,
      ),
    );
  }

  void pauseActiveSession() {
    if (state is GameSessionActive) {
      final currentState = state as GameSessionActive;
      _stopTimer();
      emit(
        GameSessionActivePaused(
          session: currentState.session,
          currentPersonIndex: currentState.currentPersonIndex,
          isDisabled: currentState.isDisabled,
        ),
      );
    }
  }

  void resumeSession() {
    if (state is GameSessionActivePaused) {
      final currentState = state as GameSessionActivePaused;
      //? we start timer with session model that we store in GameSessionActivePaused state.
      _startTimer(
        currentState.session,
        currentPersonIndex: currentState.currentPersonIndex,
        isDisabled: currentState.isDisabled,
      );
    }
  }

  void goToDashBoard() {
    _stopTimer();
    emit(GameSessionInitial());
  }

  void endSession() {
    if (state is GameSessionActive) {
      _stopTimer();
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

  void _stopTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
  }

  Future<void> addPerson(String name) async {
    if (name.trim().isEmpty || state is! GameSessionActive) return;
    final currentState = state as GameSessionActive;

    emit(currentState.copyWith(isAddLoading: true));
    await Future.delayed(const Duration(seconds: 1));

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

  void disableSession() {
    if (state is GameSessionActive) {
      final currentState = state as GameSessionActive;
      emit(currentState.copyWith(isDisabled: true));
    }
  }

  void enableSession() {
    if (state is GameSessionActive) {
      final currentState = state as GameSessionActive;
      emit(currentState.copyWith(isDisabled: false));
    }
  }

  @override
  Future<void> close() {
    _stopTimer();
    return super.close();
  }
}
