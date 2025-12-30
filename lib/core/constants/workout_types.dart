import 'package:flutter/material.dart';

class WorkoutTypes {
  static const String easyRun = 'easy_run';
  static const String tempo = 'tempo';
  static const String intervals = 'intervals';
  static const String longRun = 'long_run';
  static const String rest = 'rest';
  static const String strength = 'strength';
  static const String mobility = 'mobility';

  static Color getColor(String type) {
    switch (type) {
      case easyRun:
        return Colors.green;
      case tempo:
        return Colors.orange;
      case intervals:
        return Colors.red;
      case longRun:
        return Colors.blue;
      case rest:
        return Colors.grey;
      case strength:
        return Colors.purple;
      case mobility:
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  static String getDisplayName(String type) {
    switch (type) {
      case easyRun:
        return 'Easy Run';
      case tempo:
        return 'Tempo';
      case intervals:
        return 'Intervals';
      case longRun:
        return 'Long Run';
      case rest:
        return 'Rest Day';
      case strength:
        return 'Strength';
      case mobility:
        return 'Mobility';
      default:
        return type;
    }
  }
}
