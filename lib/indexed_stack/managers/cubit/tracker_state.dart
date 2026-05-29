part of 'tracker.dart';

sealed class TrackerState {}

final class TrackerEmpty extends TrackerState {}

final class TrackerAddLoading extends TrackerState {}

final class TrackerUpdated extends TrackerState {
  final Map<String, int> persons;
  final int currentIndex;
  TrackerUpdated({required this.persons, required this.currentIndex});
}