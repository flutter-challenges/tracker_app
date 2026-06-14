import 'dart:developer';

import 'package:flutter/foundation.dart';

@immutable
class SessionModel {
  final DateTime startTime;
  final DateTime? endTime;
  final Map<String, int> persons; 

  const SessionModel({
    required this.startTime,
    this.endTime,
    required this.persons,
  });

  String get winner {
    if (persons.isEmpty) return "No participants";
    
    final firstPerson = persons.entries.first;
    int maxPersonScore = firstPerson.value;
    List<String> currentWinners = [firstPerson.key];

    persons.forEach((name, score) {
      if (score > maxPersonScore) {
        maxPersonScore = score;
        currentWinners = [name]; 
      } else if (score == maxPersonScore && !currentWinners.contains(name)) {
        currentWinners.add(name); 
      }
    });

    return currentWinners.join(' & ');
  }

  /*
     * here we get total duration of session in seconds.
  */
  Duration get duration {
    final end = endTime ?? DateTime.now();
    return end.difference(startTime);
  }

  /*
  * We calculate the total seconds from the duration, then derive minutes and seconds.
  * we get minuts & seconds.
  * we use it in session_timer widget to show the live timer in "mm:ss" format.
  */
  String get durationInMinutesAndSeconds {
    final totalSeconds = duration.inSeconds;
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    log('Duration: $minutes:$seconds');
    return '$minutes:$seconds';
  }

  SessionModel copyWith({
    DateTime? startTime,
    DateTime? endTime,
    Map<String, int>? persons,
    bool? isActive,
  }) {
    return SessionModel(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      persons: persons ?? Map<String, int>.from(this.persons),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'startTime': startTime.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'persons': persons,
    };
  }

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] != null ? DateTime.parse(json['endTime'] as String) : null,
      persons: Map<String, int>.from(json['persons'] as Map),
    );
  }

  @override
  bool operator ==(Object actor) =>
      identical(this, actor) ||
      actor is SessionModel &&
          runtimeType == actor.runtimeType &&
          startTime == actor.startTime &&
          endTime == actor.endTime &&
          mapEquals(persons, actor.persons);

  @override
  int get hashCode => 
      startTime.hashCode ^ 
      endTime.hashCode ^ 
      persons.hashCode ; 
}