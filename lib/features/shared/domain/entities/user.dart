import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    int? age,
    String? gender,
    double? weight, // Always stored in KG
    @Default('kg')
    String preferredWeightUnit, // UI display preference: 'kg' or 'lb'
    double? height, // Always stored in CM
    @Default('cm')
    String preferredHeightUnit, // UI display preference: 'cm' or 'in'
    @Default([]) List<String> availableDays,
    String? constraints,
    @Default(false) bool healthPermissionsGranted,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
