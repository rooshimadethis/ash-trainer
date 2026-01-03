// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'time_off_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TimeOffEntry _$TimeOffEntryFromJson(Map<String, dynamic> json) {
  return _TimeOffEntry.fromJson(json);
}

/// @nodoc
mixin _$TimeOffEntry {
  int get id => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;
  bool get isSynced => throw _privateConstructorUsedError;

  /// Serializes this TimeOffEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TimeOffEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimeOffEntryCopyWith<TimeOffEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeOffEntryCopyWith<$Res> {
  factory $TimeOffEntryCopyWith(
          TimeOffEntry value, $Res Function(TimeOffEntry) then) =
      _$TimeOffEntryCopyWithImpl<$Res, TimeOffEntry>;
  @useResult
  $Res call(
      {int id,
      DateTime startDate,
      DateTime endDate,
      String? reason,
      bool isSynced});
}

/// @nodoc
class _$TimeOffEntryCopyWithImpl<$Res, $Val extends TimeOffEntry>
    implements $TimeOffEntryCopyWith<$Res> {
  _$TimeOffEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimeOffEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? reason = freezed,
    Object? isSynced = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      isSynced: null == isSynced
          ? _value.isSynced
          : isSynced // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimeOffEntryImplCopyWith<$Res>
    implements $TimeOffEntryCopyWith<$Res> {
  factory _$$TimeOffEntryImplCopyWith(
          _$TimeOffEntryImpl value, $Res Function(_$TimeOffEntryImpl) then) =
      __$$TimeOffEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      DateTime startDate,
      DateTime endDate,
      String? reason,
      bool isSynced});
}

/// @nodoc
class __$$TimeOffEntryImplCopyWithImpl<$Res>
    extends _$TimeOffEntryCopyWithImpl<$Res, _$TimeOffEntryImpl>
    implements _$$TimeOffEntryImplCopyWith<$Res> {
  __$$TimeOffEntryImplCopyWithImpl(
      _$TimeOffEntryImpl _value, $Res Function(_$TimeOffEntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of TimeOffEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? reason = freezed,
    Object? isSynced = null,
  }) {
    return _then(_$TimeOffEntryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      isSynced: null == isSynced
          ? _value.isSynced
          : isSynced // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TimeOffEntryImpl implements _TimeOffEntry {
  const _$TimeOffEntryImpl(
      {required this.id,
      required this.startDate,
      required this.endDate,
      this.reason,
      this.isSynced = false});

  factory _$TimeOffEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimeOffEntryImplFromJson(json);

  @override
  final int id;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final String? reason;
  @override
  @JsonKey()
  final bool isSynced;

  @override
  String toString() {
    return 'TimeOffEntry(id: $id, startDate: $startDate, endDate: $endDate, reason: $reason, isSynced: $isSynced)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeOffEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.isSynced, isSynced) ||
                other.isSynced == isSynced));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, startDate, endDate, reason, isSynced);

  /// Create a copy of TimeOffEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeOffEntryImplCopyWith<_$TimeOffEntryImpl> get copyWith =>
      __$$TimeOffEntryImplCopyWithImpl<_$TimeOffEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimeOffEntryImplToJson(
      this,
    );
  }
}

abstract class _TimeOffEntry implements TimeOffEntry {
  const factory _TimeOffEntry(
      {required final int id,
      required final DateTime startDate,
      required final DateTime endDate,
      final String? reason,
      final bool isSynced}) = _$TimeOffEntryImpl;

  factory _TimeOffEntry.fromJson(Map<String, dynamic> json) =
      _$TimeOffEntryImpl.fromJson;

  @override
  int get id;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  String? get reason;
  @override
  bool get isSynced;

  /// Create a copy of TimeOffEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimeOffEntryImplCopyWith<_$TimeOffEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
