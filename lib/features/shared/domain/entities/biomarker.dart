/// Domain entity representing daily health biomarkers
class Biomarker {
  final int id;
  final int userId;
  final DateTime date;
  final int? sleepDuration; // minutes
  final double? hrv; // milliseconds (SDNN)
  final int? rhr; // beats per minute
  final DateTime createdAt;
  final DateTime updatedAt;

  const Biomarker({
    required this.id,
    required this.userId,
    required this.date,
    this.sleepDuration,
    this.hrv,
    this.rhr,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Formats sleep duration as "7h 30m"
  String get sleepDurationFormatted {
    if (sleepDuration == null) return '--';
    final hours = sleepDuration! ~/ 60;
    final minutes = sleepDuration! % 60;
    return '${hours}h ${minutes}m';
  }

  Biomarker copyWith({
    int? id,
    int? userId,
    DateTime? date,
    int? sleepDuration,
    double? hrv,
    int? rhr,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Biomarker(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      sleepDuration: sleepDuration ?? this.sleepDuration,
      hrv: hrv ?? this.hrv,
      rhr: rhr ?? this.rhr,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Biomarker &&
        other.id == id &&
        other.userId == userId &&
        other.date == date &&
        other.sleepDuration == sleepDuration &&
        other.hrv == hrv &&
        other.rhr == rhr &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      userId,
      date,
      sleepDuration,
      hrv,
      rhr,
      createdAt,
      updatedAt,
    );
  }
}
