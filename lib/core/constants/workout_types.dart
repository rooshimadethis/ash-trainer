import 'package:flutter/material.dart';
import '../theme/colors.dart';

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
        return AppColors.runEasy;
      case tempo:
        return AppColors.runTempo;
      case intervals:
        return AppColors.runIntervals;
      case longRun:
        return AppColors.runLong;
      case strength:
        return AppColors.strength;
      case mobility:
        return AppColors.mobility;
      case rest:
      default:
        return AppColors.rest;
    }
  }

  static IconData getIcon(String type) {
    switch (type) {
      case easyRun:
        return Icons.directions_run;
      case tempo:
        return Icons.speed;
      case intervals:
        return Icons.timer;
      case longRun:
        return Icons.event;
      case rest:
        return Icons.hotel;
      case strength:
        return Icons.fitness_center;
      case mobility:
        return Icons.self_improvement;
      default:
        return Icons.help_outline;
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
