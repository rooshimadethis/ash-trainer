import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_off_entry.freezed.dart';
part 'time_off_entry.g.dart';

@freezed
class TimeOffEntry with _$TimeOffEntry {
  const factory TimeOffEntry({
    required int id,
    required DateTime startDate,
    required DateTime endDate,
    String? reason,
    @Default(false) bool isSynced,
  }) = _TimeOffEntry;

  factory TimeOffEntry.fromJson(Map<String, dynamic> json) =>
      _$TimeOffEntryFromJson(json);
}
