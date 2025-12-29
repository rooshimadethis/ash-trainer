// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, UserDTO> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _availableDaysMeta =
      const VerificationMeta('availableDays');
  @override
  late final GeneratedColumn<String> availableDays = GeneratedColumn<String>(
      'available_days', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _constraintsMeta =
      const VerificationMeta('constraints');
  @override
  late final GeneratedColumn<String> constraints = GeneratedColumn<String>(
      'constraints', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _healthPermissionsGrantedMeta =
      const VerificationMeta('healthPermissionsGranted');
  @override
  late final GeneratedColumn<bool> healthPermissionsGranted =
      GeneratedColumn<bool>(
          'health_permissions_granted', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("health_permissions_granted" IN (0, 1))'),
          defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        availableDays,
        constraints,
        healthPermissionsGranted,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<UserDTO> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('available_days')) {
      context.handle(
          _availableDaysMeta,
          availableDays.isAcceptableOrUnknown(
              data['available_days']!, _availableDaysMeta));
    } else if (isInserting) {
      context.missing(_availableDaysMeta);
    }
    if (data.containsKey('constraints')) {
      context.handle(
          _constraintsMeta,
          constraints.isAcceptableOrUnknown(
              data['constraints']!, _constraintsMeta));
    }
    if (data.containsKey('health_permissions_granted')) {
      context.handle(
          _healthPermissionsGrantedMeta,
          healthPermissionsGranted.isAcceptableOrUnknown(
              data['health_permissions_granted']!,
              _healthPermissionsGrantedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserDTO map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserDTO(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      availableDays: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}available_days'])!,
      constraints: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}constraints']),
      healthPermissionsGranted: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}health_permissions_granted'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class UserDTO extends DataClass implements Insertable<UserDTO> {
  final int id;
  final String availableDays;
  final String? constraints;
  final bool healthPermissionsGranted;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UserDTO(
      {required this.id,
      required this.availableDays,
      this.constraints,
      required this.healthPermissionsGranted,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['available_days'] = Variable<String>(availableDays);
    if (!nullToAbsent || constraints != null) {
      map['constraints'] = Variable<String>(constraints);
    }
    map['health_permissions_granted'] =
        Variable<bool>(healthPermissionsGranted);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      availableDays: Value(availableDays),
      constraints: constraints == null && nullToAbsent
          ? const Value.absent()
          : Value(constraints),
      healthPermissionsGranted: Value(healthPermissionsGranted),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserDTO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserDTO(
      id: serializer.fromJson<int>(json['id']),
      availableDays: serializer.fromJson<String>(json['availableDays']),
      constraints: serializer.fromJson<String?>(json['constraints']),
      healthPermissionsGranted:
          serializer.fromJson<bool>(json['healthPermissionsGranted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'availableDays': serializer.toJson<String>(availableDays),
      'constraints': serializer.toJson<String?>(constraints),
      'healthPermissionsGranted':
          serializer.toJson<bool>(healthPermissionsGranted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserDTO copyWith(
          {int? id,
          String? availableDays,
          Value<String?> constraints = const Value.absent(),
          bool? healthPermissionsGranted,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      UserDTO(
        id: id ?? this.id,
        availableDays: availableDays ?? this.availableDays,
        constraints: constraints.present ? constraints.value : this.constraints,
        healthPermissionsGranted:
            healthPermissionsGranted ?? this.healthPermissionsGranted,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  UserDTO copyWithCompanion(UsersCompanion data) {
    return UserDTO(
      id: data.id.present ? data.id.value : this.id,
      availableDays: data.availableDays.present
          ? data.availableDays.value
          : this.availableDays,
      constraints:
          data.constraints.present ? data.constraints.value : this.constraints,
      healthPermissionsGranted: data.healthPermissionsGranted.present
          ? data.healthPermissionsGranted.value
          : this.healthPermissionsGranted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserDTO(')
          ..write('id: $id, ')
          ..write('availableDays: $availableDays, ')
          ..write('constraints: $constraints, ')
          ..write('healthPermissionsGranted: $healthPermissionsGranted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, availableDays, constraints,
      healthPermissionsGranted, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserDTO &&
          other.id == this.id &&
          other.availableDays == this.availableDays &&
          other.constraints == this.constraints &&
          other.healthPermissionsGranted == this.healthPermissionsGranted &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UsersCompanion extends UpdateCompanion<UserDTO> {
  final Value<int> id;
  final Value<String> availableDays;
  final Value<String?> constraints;
  final Value<bool> healthPermissionsGranted;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.availableDays = const Value.absent(),
    this.constraints = const Value.absent(),
    this.healthPermissionsGranted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String availableDays,
    this.constraints = const Value.absent(),
    this.healthPermissionsGranted = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  })  : availableDays = Value(availableDays),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<UserDTO> custom({
    Expression<int>? id,
    Expression<String>? availableDays,
    Expression<String>? constraints,
    Expression<bool>? healthPermissionsGranted,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (availableDays != null) 'available_days': availableDays,
      if (constraints != null) 'constraints': constraints,
      if (healthPermissionsGranted != null)
        'health_permissions_granted': healthPermissionsGranted,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UsersCompanion copyWith(
      {Value<int>? id,
      Value<String>? availableDays,
      Value<String?>? constraints,
      Value<bool>? healthPermissionsGranted,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return UsersCompanion(
      id: id ?? this.id,
      availableDays: availableDays ?? this.availableDays,
      constraints: constraints ?? this.constraints,
      healthPermissionsGranted:
          healthPermissionsGranted ?? this.healthPermissionsGranted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (availableDays.present) {
      map['available_days'] = Variable<String>(availableDays.value);
    }
    if (constraints.present) {
      map['constraints'] = Variable<String>(constraints.value);
    }
    if (healthPermissionsGranted.present) {
      map['health_permissions_granted'] =
          Variable<bool>(healthPermissionsGranted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('availableDays: $availableDays, ')
          ..write('constraints: $constraints, ')
          ..write('healthPermissionsGranted: $healthPermissionsGranted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $GoalsTable extends Goals with TableInfo<$GoalsTable, GoalDTO> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _targetDistanceMeta =
      const VerificationMeta('targetDistance');
  @override
  late final GeneratedColumn<double> targetDistance = GeneratedColumn<double>(
      'target_distance', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _targetDateMeta =
      const VerificationMeta('targetDate');
  @override
  late final GeneratedColumn<DateTime> targetDate = GeneratedColumn<DateTime>(
      'target_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _targetTimeMeta =
      const VerificationMeta('targetTime');
  @override
  late final GeneratedColumn<int> targetTime = GeneratedColumn<int>(
      'target_time', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _currentBestTimeMeta =
      const VerificationMeta('currentBestTime');
  @override
  late final GeneratedColumn<int> currentBestTime = GeneratedColumn<int>(
      'current_best_time', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _eventNameMeta =
      const VerificationMeta('eventName');
  @override
  late final GeneratedColumn<String> eventName = GeneratedColumn<String>(
      'event_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _eventDateMeta =
      const VerificationMeta('eventDate');
  @override
  late final GeneratedColumn<DateTime> eventDate = GeneratedColumn<DateTime>(
      'event_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _maintenanceFrequencyMeta =
      const VerificationMeta('maintenanceFrequency');
  @override
  late final GeneratedColumn<int> maintenanceFrequency = GeneratedColumn<int>(
      'maintenance_frequency', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _maintenanceDurationMeta =
      const VerificationMeta('maintenanceDuration');
  @override
  late final GeneratedColumn<int> maintenanceDuration = GeneratedColumn<int>(
      'maintenance_duration', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
      'end_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _confidenceMeta =
      const VerificationMeta('confidence');
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
      'confidence', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _adherenceScoreMeta =
      const VerificationMeta('adherenceScore');
  @override
  late final GeneratedColumn<double> adherenceScore = GeneratedColumn<double>(
      'adherence_score', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _qualityScoreMeta =
      const VerificationMeta('qualityScore');
  @override
  late final GeneratedColumn<double> qualityScore = GeneratedColumn<double>(
      'quality_score', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _consistencyScoreMeta =
      const VerificationMeta('consistencyScore');
  @override
  late final GeneratedColumn<double> consistencyScore = GeneratedColumn<double>(
      'consistency_score', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _recoveryScoreMeta =
      const VerificationMeta('recoveryScore');
  @override
  late final GeneratedColumn<double> recoveryScore = GeneratedColumn<double>(
      'recovery_score', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        type,
        name,
        isActive,
        targetDistance,
        targetDate,
        targetTime,
        currentBestTime,
        eventName,
        eventDate,
        maintenanceFrequency,
        maintenanceDuration,
        endDate,
        confidence,
        adherenceScore,
        qualityScore,
        consistencyScore,
        recoveryScore,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goals';
  @override
  VerificationContext validateIntegrity(Insertable<GoalDTO> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('target_distance')) {
      context.handle(
          _targetDistanceMeta,
          targetDistance.isAcceptableOrUnknown(
              data['target_distance']!, _targetDistanceMeta));
    }
    if (data.containsKey('target_date')) {
      context.handle(
          _targetDateMeta,
          targetDate.isAcceptableOrUnknown(
              data['target_date']!, _targetDateMeta));
    }
    if (data.containsKey('target_time')) {
      context.handle(
          _targetTimeMeta,
          targetTime.isAcceptableOrUnknown(
              data['target_time']!, _targetTimeMeta));
    }
    if (data.containsKey('current_best_time')) {
      context.handle(
          _currentBestTimeMeta,
          currentBestTime.isAcceptableOrUnknown(
              data['current_best_time']!, _currentBestTimeMeta));
    }
    if (data.containsKey('event_name')) {
      context.handle(_eventNameMeta,
          eventName.isAcceptableOrUnknown(data['event_name']!, _eventNameMeta));
    }
    if (data.containsKey('event_date')) {
      context.handle(_eventDateMeta,
          eventDate.isAcceptableOrUnknown(data['event_date']!, _eventDateMeta));
    }
    if (data.containsKey('maintenance_frequency')) {
      context.handle(
          _maintenanceFrequencyMeta,
          maintenanceFrequency.isAcceptableOrUnknown(
              data['maintenance_frequency']!, _maintenanceFrequencyMeta));
    }
    if (data.containsKey('maintenance_duration')) {
      context.handle(
          _maintenanceDurationMeta,
          maintenanceDuration.isAcceptableOrUnknown(
              data['maintenance_duration']!, _maintenanceDurationMeta));
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    }
    if (data.containsKey('confidence')) {
      context.handle(
          _confidenceMeta,
          confidence.isAcceptableOrUnknown(
              data['confidence']!, _confidenceMeta));
    }
    if (data.containsKey('adherence_score')) {
      context.handle(
          _adherenceScoreMeta,
          adherenceScore.isAcceptableOrUnknown(
              data['adherence_score']!, _adherenceScoreMeta));
    }
    if (data.containsKey('quality_score')) {
      context.handle(
          _qualityScoreMeta,
          qualityScore.isAcceptableOrUnknown(
              data['quality_score']!, _qualityScoreMeta));
    }
    if (data.containsKey('consistency_score')) {
      context.handle(
          _consistencyScoreMeta,
          consistencyScore.isAcceptableOrUnknown(
              data['consistency_score']!, _consistencyScoreMeta));
    }
    if (data.containsKey('recovery_score')) {
      context.handle(
          _recoveryScoreMeta,
          recoveryScore.isAcceptableOrUnknown(
              data['recovery_score']!, _recoveryScoreMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GoalDTO map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GoalDTO(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      targetDistance: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}target_distance']),
      targetDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}target_date']),
      targetTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}target_time']),
      currentBestTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}current_best_time']),
      eventName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}event_name']),
      eventDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}event_date']),
      maintenanceFrequency: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}maintenance_frequency']),
      maintenanceDuration: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}maintenance_duration']),
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_date']),
      confidence: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}confidence'])!,
      adherenceScore: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}adherence_score'])!,
      qualityScore: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}quality_score'])!,
      consistencyScore: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}consistency_score'])!,
      recoveryScore: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}recovery_score'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $GoalsTable createAlias(String alias) {
    return $GoalsTable(attachedDatabase, alias);
  }
}

class GoalDTO extends DataClass implements Insertable<GoalDTO> {
  final int id;
  final int userId;
  final String type;
  final String name;
  final bool isActive;
  final double? targetDistance;
  final DateTime? targetDate;
  final int? targetTime;
  final int? currentBestTime;
  final String? eventName;
  final DateTime? eventDate;
  final int? maintenanceFrequency;
  final int? maintenanceDuration;
  final DateTime? endDate;
  final double confidence;
  final double adherenceScore;
  final double qualityScore;
  final double consistencyScore;
  final double recoveryScore;
  final DateTime createdAt;
  final DateTime updatedAt;
  const GoalDTO(
      {required this.id,
      required this.userId,
      required this.type,
      required this.name,
      required this.isActive,
      this.targetDistance,
      this.targetDate,
      this.targetTime,
      this.currentBestTime,
      this.eventName,
      this.eventDate,
      this.maintenanceFrequency,
      this.maintenanceDuration,
      this.endDate,
      required this.confidence,
      required this.adherenceScore,
      required this.qualityScore,
      required this.consistencyScore,
      required this.recoveryScore,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['type'] = Variable<String>(type);
    map['name'] = Variable<String>(name);
    map['is_active'] = Variable<bool>(isActive);
    if (!nullToAbsent || targetDistance != null) {
      map['target_distance'] = Variable<double>(targetDistance);
    }
    if (!nullToAbsent || targetDate != null) {
      map['target_date'] = Variable<DateTime>(targetDate);
    }
    if (!nullToAbsent || targetTime != null) {
      map['target_time'] = Variable<int>(targetTime);
    }
    if (!nullToAbsent || currentBestTime != null) {
      map['current_best_time'] = Variable<int>(currentBestTime);
    }
    if (!nullToAbsent || eventName != null) {
      map['event_name'] = Variable<String>(eventName);
    }
    if (!nullToAbsent || eventDate != null) {
      map['event_date'] = Variable<DateTime>(eventDate);
    }
    if (!nullToAbsent || maintenanceFrequency != null) {
      map['maintenance_frequency'] = Variable<int>(maintenanceFrequency);
    }
    if (!nullToAbsent || maintenanceDuration != null) {
      map['maintenance_duration'] = Variable<int>(maintenanceDuration);
    }
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    map['confidence'] = Variable<double>(confidence);
    map['adherence_score'] = Variable<double>(adherenceScore);
    map['quality_score'] = Variable<double>(qualityScore);
    map['consistency_score'] = Variable<double>(consistencyScore);
    map['recovery_score'] = Variable<double>(recoveryScore);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  GoalsCompanion toCompanion(bool nullToAbsent) {
    return GoalsCompanion(
      id: Value(id),
      userId: Value(userId),
      type: Value(type),
      name: Value(name),
      isActive: Value(isActive),
      targetDistance: targetDistance == null && nullToAbsent
          ? const Value.absent()
          : Value(targetDistance),
      targetDate: targetDate == null && nullToAbsent
          ? const Value.absent()
          : Value(targetDate),
      targetTime: targetTime == null && nullToAbsent
          ? const Value.absent()
          : Value(targetTime),
      currentBestTime: currentBestTime == null && nullToAbsent
          ? const Value.absent()
          : Value(currentBestTime),
      eventName: eventName == null && nullToAbsent
          ? const Value.absent()
          : Value(eventName),
      eventDate: eventDate == null && nullToAbsent
          ? const Value.absent()
          : Value(eventDate),
      maintenanceFrequency: maintenanceFrequency == null && nullToAbsent
          ? const Value.absent()
          : Value(maintenanceFrequency),
      maintenanceDuration: maintenanceDuration == null && nullToAbsent
          ? const Value.absent()
          : Value(maintenanceDuration),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      confidence: Value(confidence),
      adherenceScore: Value(adherenceScore),
      qualityScore: Value(qualityScore),
      consistencyScore: Value(consistencyScore),
      recoveryScore: Value(recoveryScore),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory GoalDTO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GoalDTO(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      type: serializer.fromJson<String>(json['type']),
      name: serializer.fromJson<String>(json['name']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      targetDistance: serializer.fromJson<double?>(json['targetDistance']),
      targetDate: serializer.fromJson<DateTime?>(json['targetDate']),
      targetTime: serializer.fromJson<int?>(json['targetTime']),
      currentBestTime: serializer.fromJson<int?>(json['currentBestTime']),
      eventName: serializer.fromJson<String?>(json['eventName']),
      eventDate: serializer.fromJson<DateTime?>(json['eventDate']),
      maintenanceFrequency:
          serializer.fromJson<int?>(json['maintenanceFrequency']),
      maintenanceDuration:
          serializer.fromJson<int?>(json['maintenanceDuration']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      confidence: serializer.fromJson<double>(json['confidence']),
      adherenceScore: serializer.fromJson<double>(json['adherenceScore']),
      qualityScore: serializer.fromJson<double>(json['qualityScore']),
      consistencyScore: serializer.fromJson<double>(json['consistencyScore']),
      recoveryScore: serializer.fromJson<double>(json['recoveryScore']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'type': serializer.toJson<String>(type),
      'name': serializer.toJson<String>(name),
      'isActive': serializer.toJson<bool>(isActive),
      'targetDistance': serializer.toJson<double?>(targetDistance),
      'targetDate': serializer.toJson<DateTime?>(targetDate),
      'targetTime': serializer.toJson<int?>(targetTime),
      'currentBestTime': serializer.toJson<int?>(currentBestTime),
      'eventName': serializer.toJson<String?>(eventName),
      'eventDate': serializer.toJson<DateTime?>(eventDate),
      'maintenanceFrequency': serializer.toJson<int?>(maintenanceFrequency),
      'maintenanceDuration': serializer.toJson<int?>(maintenanceDuration),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'confidence': serializer.toJson<double>(confidence),
      'adherenceScore': serializer.toJson<double>(adherenceScore),
      'qualityScore': serializer.toJson<double>(qualityScore),
      'consistencyScore': serializer.toJson<double>(consistencyScore),
      'recoveryScore': serializer.toJson<double>(recoveryScore),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  GoalDTO copyWith(
          {int? id,
          int? userId,
          String? type,
          String? name,
          bool? isActive,
          Value<double?> targetDistance = const Value.absent(),
          Value<DateTime?> targetDate = const Value.absent(),
          Value<int?> targetTime = const Value.absent(),
          Value<int?> currentBestTime = const Value.absent(),
          Value<String?> eventName = const Value.absent(),
          Value<DateTime?> eventDate = const Value.absent(),
          Value<int?> maintenanceFrequency = const Value.absent(),
          Value<int?> maintenanceDuration = const Value.absent(),
          Value<DateTime?> endDate = const Value.absent(),
          double? confidence,
          double? adherenceScore,
          double? qualityScore,
          double? consistencyScore,
          double? recoveryScore,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      GoalDTO(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        type: type ?? this.type,
        name: name ?? this.name,
        isActive: isActive ?? this.isActive,
        targetDistance:
            targetDistance.present ? targetDistance.value : this.targetDistance,
        targetDate: targetDate.present ? targetDate.value : this.targetDate,
        targetTime: targetTime.present ? targetTime.value : this.targetTime,
        currentBestTime: currentBestTime.present
            ? currentBestTime.value
            : this.currentBestTime,
        eventName: eventName.present ? eventName.value : this.eventName,
        eventDate: eventDate.present ? eventDate.value : this.eventDate,
        maintenanceFrequency: maintenanceFrequency.present
            ? maintenanceFrequency.value
            : this.maintenanceFrequency,
        maintenanceDuration: maintenanceDuration.present
            ? maintenanceDuration.value
            : this.maintenanceDuration,
        endDate: endDate.present ? endDate.value : this.endDate,
        confidence: confidence ?? this.confidence,
        adherenceScore: adherenceScore ?? this.adherenceScore,
        qualityScore: qualityScore ?? this.qualityScore,
        consistencyScore: consistencyScore ?? this.consistencyScore,
        recoveryScore: recoveryScore ?? this.recoveryScore,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  GoalDTO copyWithCompanion(GoalsCompanion data) {
    return GoalDTO(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      type: data.type.present ? data.type.value : this.type,
      name: data.name.present ? data.name.value : this.name,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      targetDistance: data.targetDistance.present
          ? data.targetDistance.value
          : this.targetDistance,
      targetDate:
          data.targetDate.present ? data.targetDate.value : this.targetDate,
      targetTime:
          data.targetTime.present ? data.targetTime.value : this.targetTime,
      currentBestTime: data.currentBestTime.present
          ? data.currentBestTime.value
          : this.currentBestTime,
      eventName: data.eventName.present ? data.eventName.value : this.eventName,
      eventDate: data.eventDate.present ? data.eventDate.value : this.eventDate,
      maintenanceFrequency: data.maintenanceFrequency.present
          ? data.maintenanceFrequency.value
          : this.maintenanceFrequency,
      maintenanceDuration: data.maintenanceDuration.present
          ? data.maintenanceDuration.value
          : this.maintenanceDuration,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      confidence:
          data.confidence.present ? data.confidence.value : this.confidence,
      adherenceScore: data.adherenceScore.present
          ? data.adherenceScore.value
          : this.adherenceScore,
      qualityScore: data.qualityScore.present
          ? data.qualityScore.value
          : this.qualityScore,
      consistencyScore: data.consistencyScore.present
          ? data.consistencyScore.value
          : this.consistencyScore,
      recoveryScore: data.recoveryScore.present
          ? data.recoveryScore.value
          : this.recoveryScore,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GoalDTO(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('isActive: $isActive, ')
          ..write('targetDistance: $targetDistance, ')
          ..write('targetDate: $targetDate, ')
          ..write('targetTime: $targetTime, ')
          ..write('currentBestTime: $currentBestTime, ')
          ..write('eventName: $eventName, ')
          ..write('eventDate: $eventDate, ')
          ..write('maintenanceFrequency: $maintenanceFrequency, ')
          ..write('maintenanceDuration: $maintenanceDuration, ')
          ..write('endDate: $endDate, ')
          ..write('confidence: $confidence, ')
          ..write('adherenceScore: $adherenceScore, ')
          ..write('qualityScore: $qualityScore, ')
          ..write('consistencyScore: $consistencyScore, ')
          ..write('recoveryScore: $recoveryScore, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        userId,
        type,
        name,
        isActive,
        targetDistance,
        targetDate,
        targetTime,
        currentBestTime,
        eventName,
        eventDate,
        maintenanceFrequency,
        maintenanceDuration,
        endDate,
        confidence,
        adherenceScore,
        qualityScore,
        consistencyScore,
        recoveryScore,
        createdAt,
        updatedAt
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GoalDTO &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.type == this.type &&
          other.name == this.name &&
          other.isActive == this.isActive &&
          other.targetDistance == this.targetDistance &&
          other.targetDate == this.targetDate &&
          other.targetTime == this.targetTime &&
          other.currentBestTime == this.currentBestTime &&
          other.eventName == this.eventName &&
          other.eventDate == this.eventDate &&
          other.maintenanceFrequency == this.maintenanceFrequency &&
          other.maintenanceDuration == this.maintenanceDuration &&
          other.endDate == this.endDate &&
          other.confidence == this.confidence &&
          other.adherenceScore == this.adherenceScore &&
          other.qualityScore == this.qualityScore &&
          other.consistencyScore == this.consistencyScore &&
          other.recoveryScore == this.recoveryScore &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class GoalsCompanion extends UpdateCompanion<GoalDTO> {
  final Value<int> id;
  final Value<int> userId;
  final Value<String> type;
  final Value<String> name;
  final Value<bool> isActive;
  final Value<double?> targetDistance;
  final Value<DateTime?> targetDate;
  final Value<int?> targetTime;
  final Value<int?> currentBestTime;
  final Value<String?> eventName;
  final Value<DateTime?> eventDate;
  final Value<int?> maintenanceFrequency;
  final Value<int?> maintenanceDuration;
  final Value<DateTime?> endDate;
  final Value<double> confidence;
  final Value<double> adherenceScore;
  final Value<double> qualityScore;
  final Value<double> consistencyScore;
  final Value<double> recoveryScore;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const GoalsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.type = const Value.absent(),
    this.name = const Value.absent(),
    this.isActive = const Value.absent(),
    this.targetDistance = const Value.absent(),
    this.targetDate = const Value.absent(),
    this.targetTime = const Value.absent(),
    this.currentBestTime = const Value.absent(),
    this.eventName = const Value.absent(),
    this.eventDate = const Value.absent(),
    this.maintenanceFrequency = const Value.absent(),
    this.maintenanceDuration = const Value.absent(),
    this.endDate = const Value.absent(),
    this.confidence = const Value.absent(),
    this.adherenceScore = const Value.absent(),
    this.qualityScore = const Value.absent(),
    this.consistencyScore = const Value.absent(),
    this.recoveryScore = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  GoalsCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required String type,
    required String name,
    this.isActive = const Value.absent(),
    this.targetDistance = const Value.absent(),
    this.targetDate = const Value.absent(),
    this.targetTime = const Value.absent(),
    this.currentBestTime = const Value.absent(),
    this.eventName = const Value.absent(),
    this.eventDate = const Value.absent(),
    this.maintenanceFrequency = const Value.absent(),
    this.maintenanceDuration = const Value.absent(),
    this.endDate = const Value.absent(),
    this.confidence = const Value.absent(),
    this.adherenceScore = const Value.absent(),
    this.qualityScore = const Value.absent(),
    this.consistencyScore = const Value.absent(),
    this.recoveryScore = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  })  : userId = Value(userId),
        type = Value(type),
        name = Value(name),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<GoalDTO> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<String>? type,
    Expression<String>? name,
    Expression<bool>? isActive,
    Expression<double>? targetDistance,
    Expression<DateTime>? targetDate,
    Expression<int>? targetTime,
    Expression<int>? currentBestTime,
    Expression<String>? eventName,
    Expression<DateTime>? eventDate,
    Expression<int>? maintenanceFrequency,
    Expression<int>? maintenanceDuration,
    Expression<DateTime>? endDate,
    Expression<double>? confidence,
    Expression<double>? adherenceScore,
    Expression<double>? qualityScore,
    Expression<double>? consistencyScore,
    Expression<double>? recoveryScore,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (type != null) 'type': type,
      if (name != null) 'name': name,
      if (isActive != null) 'is_active': isActive,
      if (targetDistance != null) 'target_distance': targetDistance,
      if (targetDate != null) 'target_date': targetDate,
      if (targetTime != null) 'target_time': targetTime,
      if (currentBestTime != null) 'current_best_time': currentBestTime,
      if (eventName != null) 'event_name': eventName,
      if (eventDate != null) 'event_date': eventDate,
      if (maintenanceFrequency != null)
        'maintenance_frequency': maintenanceFrequency,
      if (maintenanceDuration != null)
        'maintenance_duration': maintenanceDuration,
      if (endDate != null) 'end_date': endDate,
      if (confidence != null) 'confidence': confidence,
      if (adherenceScore != null) 'adherence_score': adherenceScore,
      if (qualityScore != null) 'quality_score': qualityScore,
      if (consistencyScore != null) 'consistency_score': consistencyScore,
      if (recoveryScore != null) 'recovery_score': recoveryScore,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  GoalsCompanion copyWith(
      {Value<int>? id,
      Value<int>? userId,
      Value<String>? type,
      Value<String>? name,
      Value<bool>? isActive,
      Value<double?>? targetDistance,
      Value<DateTime?>? targetDate,
      Value<int?>? targetTime,
      Value<int?>? currentBestTime,
      Value<String?>? eventName,
      Value<DateTime?>? eventDate,
      Value<int?>? maintenanceFrequency,
      Value<int?>? maintenanceDuration,
      Value<DateTime?>? endDate,
      Value<double>? confidence,
      Value<double>? adherenceScore,
      Value<double>? qualityScore,
      Value<double>? consistencyScore,
      Value<double>? recoveryScore,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return GoalsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
      targetDistance: targetDistance ?? this.targetDistance,
      targetDate: targetDate ?? this.targetDate,
      targetTime: targetTime ?? this.targetTime,
      currentBestTime: currentBestTime ?? this.currentBestTime,
      eventName: eventName ?? this.eventName,
      eventDate: eventDate ?? this.eventDate,
      maintenanceFrequency: maintenanceFrequency ?? this.maintenanceFrequency,
      maintenanceDuration: maintenanceDuration ?? this.maintenanceDuration,
      endDate: endDate ?? this.endDate,
      confidence: confidence ?? this.confidence,
      adherenceScore: adherenceScore ?? this.adherenceScore,
      qualityScore: qualityScore ?? this.qualityScore,
      consistencyScore: consistencyScore ?? this.consistencyScore,
      recoveryScore: recoveryScore ?? this.recoveryScore,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (targetDistance.present) {
      map['target_distance'] = Variable<double>(targetDistance.value);
    }
    if (targetDate.present) {
      map['target_date'] = Variable<DateTime>(targetDate.value);
    }
    if (targetTime.present) {
      map['target_time'] = Variable<int>(targetTime.value);
    }
    if (currentBestTime.present) {
      map['current_best_time'] = Variable<int>(currentBestTime.value);
    }
    if (eventName.present) {
      map['event_name'] = Variable<String>(eventName.value);
    }
    if (eventDate.present) {
      map['event_date'] = Variable<DateTime>(eventDate.value);
    }
    if (maintenanceFrequency.present) {
      map['maintenance_frequency'] = Variable<int>(maintenanceFrequency.value);
    }
    if (maintenanceDuration.present) {
      map['maintenance_duration'] = Variable<int>(maintenanceDuration.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (adherenceScore.present) {
      map['adherence_score'] = Variable<double>(adherenceScore.value);
    }
    if (qualityScore.present) {
      map['quality_score'] = Variable<double>(qualityScore.value);
    }
    if (consistencyScore.present) {
      map['consistency_score'] = Variable<double>(consistencyScore.value);
    }
    if (recoveryScore.present) {
      map['recovery_score'] = Variable<double>(recoveryScore.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('isActive: $isActive, ')
          ..write('targetDistance: $targetDistance, ')
          ..write('targetDate: $targetDate, ')
          ..write('targetTime: $targetTime, ')
          ..write('currentBestTime: $currentBestTime, ')
          ..write('eventName: $eventName, ')
          ..write('eventDate: $eventDate, ')
          ..write('maintenanceFrequency: $maintenanceFrequency, ')
          ..write('maintenanceDuration: $maintenanceDuration, ')
          ..write('endDate: $endDate, ')
          ..write('confidence: $confidence, ')
          ..write('adherenceScore: $adherenceScore, ')
          ..write('qualityScore: $qualityScore, ')
          ..write('consistencyScore: $consistencyScore, ')
          ..write('recoveryScore: $recoveryScore, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $GoalsTable goals = $GoalsTable(this);
  late final UserDao userDao = UserDao(this as AppDatabase);
  late final GoalDao goalDao = GoalDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [users, goals];
}

typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  required String availableDays,
  Value<String?> constraints,
  Value<bool> healthPermissionsGranted,
  required DateTime createdAt,
  required DateTime updatedAt,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  Value<String> availableDays,
  Value<String?> constraints,
  Value<bool> healthPermissionsGranted,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$UsersTableReferences
    extends BaseReferences<_$AppDatabase, $UsersTable, UserDTO> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$GoalsTable, List<GoalDTO>> _goalsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.goals,
          aliasName: $_aliasNameGenerator(db.users.id, db.goals.userId));

  $$GoalsTableProcessedTableManager get goalsRefs {
    final manager = $$GoalsTableTableManager($_db, $_db.goals)
        .filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_goalsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get availableDays => $composableBuilder(
      column: $table.availableDays, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get constraints => $composableBuilder(
      column: $table.constraints, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get healthPermissionsGranted => $composableBuilder(
      column: $table.healthPermissionsGranted,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> goalsRefs(
      Expression<bool> Function($$GoalsTableFilterComposer f) f) {
    final $$GoalsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.goals,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoalsTableFilterComposer(
              $db: $db,
              $table: $db.goals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get availableDays => $composableBuilder(
      column: $table.availableDays,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get constraints => $composableBuilder(
      column: $table.constraints, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get healthPermissionsGranted => $composableBuilder(
      column: $table.healthPermissionsGranted,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get availableDays => $composableBuilder(
      column: $table.availableDays, builder: (column) => column);

  GeneratedColumn<String> get constraints => $composableBuilder(
      column: $table.constraints, builder: (column) => column);

  GeneratedColumn<bool> get healthPermissionsGranted => $composableBuilder(
      column: $table.healthPermissionsGranted, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> goalsRefs<T extends Object>(
      Expression<T> Function($$GoalsTableAnnotationComposer a) f) {
    final $$GoalsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.goals,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoalsTableAnnotationComposer(
              $db: $db,
              $table: $db.goals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UsersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UsersTable,
    UserDTO,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (UserDTO, $$UsersTableReferences),
    UserDTO,
    PrefetchHooks Function({bool goalsRefs})> {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> availableDays = const Value.absent(),
            Value<String?> constraints = const Value.absent(),
            Value<bool> healthPermissionsGranted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              UsersCompanion(
            id: id,
            availableDays: availableDays,
            constraints: constraints,
            healthPermissionsGranted: healthPermissionsGranted,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String availableDays,
            Value<String?> constraints = const Value.absent(),
            Value<bool> healthPermissionsGranted = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
          }) =>
              UsersCompanion.insert(
            id: id,
            availableDays: availableDays,
            constraints: constraints,
            healthPermissionsGranted: healthPermissionsGranted,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$UsersTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({goalsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (goalsRefs) db.goals],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (goalsRefs)
                    await $_getPrefetchedData<UserDTO, $UsersTable, GoalDTO>(
                        currentTable: table,
                        referencedTable:
                            $$UsersTableReferences._goalsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0).goalsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.userId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$UsersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UsersTable,
    UserDTO,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (UserDTO, $$UsersTableReferences),
    UserDTO,
    PrefetchHooks Function({bool goalsRefs})>;
typedef $$GoalsTableCreateCompanionBuilder = GoalsCompanion Function({
  Value<int> id,
  required int userId,
  required String type,
  required String name,
  Value<bool> isActive,
  Value<double?> targetDistance,
  Value<DateTime?> targetDate,
  Value<int?> targetTime,
  Value<int?> currentBestTime,
  Value<String?> eventName,
  Value<DateTime?> eventDate,
  Value<int?> maintenanceFrequency,
  Value<int?> maintenanceDuration,
  Value<DateTime?> endDate,
  Value<double> confidence,
  Value<double> adherenceScore,
  Value<double> qualityScore,
  Value<double> consistencyScore,
  Value<double> recoveryScore,
  required DateTime createdAt,
  required DateTime updatedAt,
});
typedef $$GoalsTableUpdateCompanionBuilder = GoalsCompanion Function({
  Value<int> id,
  Value<int> userId,
  Value<String> type,
  Value<String> name,
  Value<bool> isActive,
  Value<double?> targetDistance,
  Value<DateTime?> targetDate,
  Value<int?> targetTime,
  Value<int?> currentBestTime,
  Value<String?> eventName,
  Value<DateTime?> eventDate,
  Value<int?> maintenanceFrequency,
  Value<int?> maintenanceDuration,
  Value<DateTime?> endDate,
  Value<double> confidence,
  Value<double> adherenceScore,
  Value<double> qualityScore,
  Value<double> consistencyScore,
  Value<double> recoveryScore,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$GoalsTableReferences
    extends BaseReferences<_$AppDatabase, $GoalsTable, GoalDTO> {
  $$GoalsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) =>
      db.users.createAlias($_aliasNameGenerator(db.goals.userId, db.users.id));

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$GoalsTableFilterComposer extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get targetDistance => $composableBuilder(
      column: $table.targetDistance,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get targetDate => $composableBuilder(
      column: $table.targetDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get targetTime => $composableBuilder(
      column: $table.targetTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get currentBestTime => $composableBuilder(
      column: $table.currentBestTime,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get eventName => $composableBuilder(
      column: $table.eventName, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get eventDate => $composableBuilder(
      column: $table.eventDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get maintenanceFrequency => $composableBuilder(
      column: $table.maintenanceFrequency,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get maintenanceDuration => $composableBuilder(
      column: $table.maintenanceDuration,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get confidence => $composableBuilder(
      column: $table.confidence, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get adherenceScore => $composableBuilder(
      column: $table.adherenceScore,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get qualityScore => $composableBuilder(
      column: $table.qualityScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get consistencyScore => $composableBuilder(
      column: $table.consistencyScore,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get recoveryScore => $composableBuilder(
      column: $table.recoveryScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GoalsTableOrderingComposer
    extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get targetDistance => $composableBuilder(
      column: $table.targetDistance,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get targetDate => $composableBuilder(
      column: $table.targetDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get targetTime => $composableBuilder(
      column: $table.targetTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get currentBestTime => $composableBuilder(
      column: $table.currentBestTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get eventName => $composableBuilder(
      column: $table.eventName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get eventDate => $composableBuilder(
      column: $table.eventDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get maintenanceFrequency => $composableBuilder(
      column: $table.maintenanceFrequency,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get maintenanceDuration => $composableBuilder(
      column: $table.maintenanceDuration,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get confidence => $composableBuilder(
      column: $table.confidence, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get adherenceScore => $composableBuilder(
      column: $table.adherenceScore,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get qualityScore => $composableBuilder(
      column: $table.qualityScore,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get consistencyScore => $composableBuilder(
      column: $table.consistencyScore,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get recoveryScore => $composableBuilder(
      column: $table.recoveryScore,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GoalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<double> get targetDistance => $composableBuilder(
      column: $table.targetDistance, builder: (column) => column);

  GeneratedColumn<DateTime> get targetDate => $composableBuilder(
      column: $table.targetDate, builder: (column) => column);

  GeneratedColumn<int> get targetTime => $composableBuilder(
      column: $table.targetTime, builder: (column) => column);

  GeneratedColumn<int> get currentBestTime => $composableBuilder(
      column: $table.currentBestTime, builder: (column) => column);

  GeneratedColumn<String> get eventName =>
      $composableBuilder(column: $table.eventName, builder: (column) => column);

  GeneratedColumn<DateTime> get eventDate =>
      $composableBuilder(column: $table.eventDate, builder: (column) => column);

  GeneratedColumn<int> get maintenanceFrequency => $composableBuilder(
      column: $table.maintenanceFrequency, builder: (column) => column);

  GeneratedColumn<int> get maintenanceDuration => $composableBuilder(
      column: $table.maintenanceDuration, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<double> get confidence => $composableBuilder(
      column: $table.confidence, builder: (column) => column);

  GeneratedColumn<double> get adherenceScore => $composableBuilder(
      column: $table.adherenceScore, builder: (column) => column);

  GeneratedColumn<double> get qualityScore => $composableBuilder(
      column: $table.qualityScore, builder: (column) => column);

  GeneratedColumn<double> get consistencyScore => $composableBuilder(
      column: $table.consistencyScore, builder: (column) => column);

  GeneratedColumn<double> get recoveryScore => $composableBuilder(
      column: $table.recoveryScore, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GoalsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $GoalsTable,
    GoalDTO,
    $$GoalsTableFilterComposer,
    $$GoalsTableOrderingComposer,
    $$GoalsTableAnnotationComposer,
    $$GoalsTableCreateCompanionBuilder,
    $$GoalsTableUpdateCompanionBuilder,
    (GoalDTO, $$GoalsTableReferences),
    GoalDTO,
    PrefetchHooks Function({bool userId})> {
  $$GoalsTableTableManager(_$AppDatabase db, $GoalsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GoalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GoalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GoalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> userId = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<double?> targetDistance = const Value.absent(),
            Value<DateTime?> targetDate = const Value.absent(),
            Value<int?> targetTime = const Value.absent(),
            Value<int?> currentBestTime = const Value.absent(),
            Value<String?> eventName = const Value.absent(),
            Value<DateTime?> eventDate = const Value.absent(),
            Value<int?> maintenanceFrequency = const Value.absent(),
            Value<int?> maintenanceDuration = const Value.absent(),
            Value<DateTime?> endDate = const Value.absent(),
            Value<double> confidence = const Value.absent(),
            Value<double> adherenceScore = const Value.absent(),
            Value<double> qualityScore = const Value.absent(),
            Value<double> consistencyScore = const Value.absent(),
            Value<double> recoveryScore = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              GoalsCompanion(
            id: id,
            userId: userId,
            type: type,
            name: name,
            isActive: isActive,
            targetDistance: targetDistance,
            targetDate: targetDate,
            targetTime: targetTime,
            currentBestTime: currentBestTime,
            eventName: eventName,
            eventDate: eventDate,
            maintenanceFrequency: maintenanceFrequency,
            maintenanceDuration: maintenanceDuration,
            endDate: endDate,
            confidence: confidence,
            adherenceScore: adherenceScore,
            qualityScore: qualityScore,
            consistencyScore: consistencyScore,
            recoveryScore: recoveryScore,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int userId,
            required String type,
            required String name,
            Value<bool> isActive = const Value.absent(),
            Value<double?> targetDistance = const Value.absent(),
            Value<DateTime?> targetDate = const Value.absent(),
            Value<int?> targetTime = const Value.absent(),
            Value<int?> currentBestTime = const Value.absent(),
            Value<String?> eventName = const Value.absent(),
            Value<DateTime?> eventDate = const Value.absent(),
            Value<int?> maintenanceFrequency = const Value.absent(),
            Value<int?> maintenanceDuration = const Value.absent(),
            Value<DateTime?> endDate = const Value.absent(),
            Value<double> confidence = const Value.absent(),
            Value<double> adherenceScore = const Value.absent(),
            Value<double> qualityScore = const Value.absent(),
            Value<double> consistencyScore = const Value.absent(),
            Value<double> recoveryScore = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
          }) =>
              GoalsCompanion.insert(
            id: id,
            userId: userId,
            type: type,
            name: name,
            isActive: isActive,
            targetDistance: targetDistance,
            targetDate: targetDate,
            targetTime: targetTime,
            currentBestTime: currentBestTime,
            eventName: eventName,
            eventDate: eventDate,
            maintenanceFrequency: maintenanceFrequency,
            maintenanceDuration: maintenanceDuration,
            endDate: endDate,
            confidence: confidence,
            adherenceScore: adherenceScore,
            qualityScore: qualityScore,
            consistencyScore: consistencyScore,
            recoveryScore: recoveryScore,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$GoalsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (userId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.userId,
                    referencedTable: $$GoalsTableReferences._userIdTable(db),
                    referencedColumn:
                        $$GoalsTableReferences._userIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$GoalsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $GoalsTable,
    GoalDTO,
    $$GoalsTableFilterComposer,
    $$GoalsTableOrderingComposer,
    $$GoalsTableAnnotationComposer,
    $$GoalsTableCreateCompanionBuilder,
    $$GoalsTableUpdateCompanionBuilder,
    (GoalDTO, $$GoalsTableReferences),
    GoalDTO,
    PrefetchHooks Function({bool userId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$GoalsTableTableManager get goals =>
      $$GoalsTableTableManager(_db, _db.goals);
}
