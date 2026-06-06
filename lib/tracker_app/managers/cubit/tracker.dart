import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tracker_state.dart';

class TrackerCubit extends Cubit<TrackerState> {
  TrackerCubit() : super(TrackerEmpty());
  final TextEditingController fieldText = TextEditingController();
  Future<void> addPerson(String name) async {
    if (name.trim().isEmpty) return;

    Map<String, int> currentPersons = {};
    if (state is TrackerUpdated) {
      currentPersons = Map<String, int>.from((state as TrackerUpdated).persons);
    }

    emit(TrackerAddLoading());
    await Future.delayed(const Duration(seconds: 1));
    currentPersons = {name: 0, ...currentPersons};
    emit(TrackerUpdated(persons: currentPersons, currentIndex: 0));
  }

  void incrementScore(String name) {
    if (state is TrackerUpdated) {
      final currentState = state as TrackerUpdated;
      final updatedPersons = Map<String, int>.from(currentState.persons);
      updatedPersons[name] = (updatedPersons[name] ?? 0) + 1;

      emit(
        TrackerUpdated(
          persons: updatedPersons,
          currentIndex: currentState.currentIndex,
        ),
      );
    }
  }

  void nextPerson() {
    if (state is TrackerUpdated) {
      final currentState = state as TrackerUpdated;
      final namesLength = currentState.persons.keys.length;
      if (namesLength == 0) return;
      final int nextIndex = (currentState.currentIndex + 1) % namesLength;
      emit(
        TrackerUpdated(persons: currentState.persons, currentIndex: nextIndex),
      );
    }
  }

  void previousPerson() {
    if (state is TrackerUpdated) {
      final currentState = state as TrackerUpdated;
      final namesLength = currentState.persons.keys.length;
      if (namesLength == 0) return;
      int prevIndex = (currentState.currentIndex - 1) % namesLength;
      if (prevIndex < 0) {
        prevIndex += namesLength;
      }
      emit(
        TrackerUpdated(persons: currentState.persons, currentIndex: prevIndex),
      );
    }
  }
}
