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
  static const VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedColumn<int> age = GeneratedColumn<int>(
      'age', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
      'gender', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
      'weight', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _preferredWeightUnitMeta =
      const VerificationMeta('preferredWeightUnit');
  @override
  late final GeneratedColumn<String> preferredWeightUnit =
      GeneratedColumn<String>('preferred_weight_unit', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant('kg'));
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<double> height = GeneratedColumn<double>(
      'height', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _preferredHeightUnitMeta =
      const VerificationMeta('preferredHeightUnit');
  @override
  late final GeneratedColumn<String> preferredHeightUnit =
      GeneratedColumn<String>('preferred_height_unit', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant('cm'));
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
        age,
        gender,
        weight,
        preferredWeightUnit,
        height,
        preferredHeightUnit,
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
    if (data.containsKey('age')) {
      context.handle(
          _ageMeta, age.isAcceptableOrUnknown(data['age']!, _ageMeta));
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    }
    if (data.containsKey('preferred_weight_unit')) {
      context.handle(
          _preferredWeightUnitMeta,
          preferredWeightUnit.isAcceptableOrUnknown(
              data['preferred_weight_unit']!, _preferredWeightUnitMeta));
    }
    if (data.containsKey('height')) {
      context.handle(_heightMeta,
          height.isAcceptableOrUnknown(data['height']!, _heightMeta));
    }
    if (data.containsKey('preferred_height_unit')) {
      context.handle(
          _preferredHeightUnitMeta,
          preferredHeightUnit.isAcceptableOrUnknown(
              data['preferred_height_unit']!, _preferredHeightUnitMeta));
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
      age: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}age']),
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender']),
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight']),
      preferredWeightUnit: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}preferred_weight_unit'])!,
      height: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}height']),
      preferredHeightUnit: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}preferred_height_unit'])!,
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
  final int? age;
  final String? gender;
  final double? weight;
  final String preferredWeightUnit;
  final double? height;
  final String preferredHeightUnit;
  final String availableDays;
  final String? constraints;
  final bool healthPermissionsGranted;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UserDTO(
      {required this.id,
      this.age,
      this.gender,
      this.weight,
      required this.preferredWeightUnit,
      this.height,
      required this.preferredHeightUnit,
      required this.availableDays,
      this.constraints,
      required this.healthPermissionsGranted,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || age != null) {
      map['age'] = Variable<int>(age);
    }
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<String>(gender);
    }
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<double>(weight);
    }
    map['preferred_weight_unit'] = Variable<String>(preferredWeightUnit);
    if (!nullToAbsent || height != null) {
      map['height'] = Variable<double>(height);
    }
    map['preferred_height_unit'] = Variable<String>(preferredHeightUnit);
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
      age: age == null && nullToAbsent ? const Value.absent() : Value(age),
      gender:
          gender == null && nullToAbsent ? const Value.absent() : Value(gender),
      weight:
          weight == null && nullToAbsent ? const Value.absent() : Value(weight),
      preferredWeightUnit: Value(preferredWeightUnit),
      height:
          height == null && nullToAbsent ? const Value.absent() : Value(height),
      preferredHeightUnit: Value(preferredHeightUnit),
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
      age: serializer.fromJson<int?>(json['age']),
      gender: serializer.fromJson<String?>(json['gender']),
      weight: serializer.fromJson<double?>(json['weight']),
      preferredWeightUnit:
          serializer.fromJson<String>(json['preferredWeightUnit']),
      height: serializer.fromJson<double?>(json['height']),
      preferredHeightUnit:
          serializer.fromJson<String>(json['preferredHeightUnit']),
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
      'age': serializer.toJson<int?>(age),
      'gender': serializer.toJson<String?>(gender),
      'weight': serializer.toJson<double?>(weight),
      'preferredWeightUnit': serializer.toJson<String>(preferredWeightUnit),
      'height': serializer.toJson<double?>(height),
      'preferredHeightUnit': serializer.toJson<String>(preferredHeightUnit),
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
          Value<int?> age = const Value.absent(),
          Value<String?> gender = const Value.absent(),
          Value<double?> weight = const Value.absent(),
          String? preferredWeightUnit,
          Value<double?> height = const Value.absent(),
          String? preferredHeightUnit,
          String? availableDays,
          Value<String?> constraints = const Value.absent(),
          bool? healthPermissionsGranted,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      UserDTO(
        id: id ?? this.id,
        age: age.present ? age.value : this.age,
        gender: gender.present ? gender.value : this.gender,
        weight: weight.present ? weight.value : this.weight,
        preferredWeightUnit: preferredWeightUnit ?? this.preferredWeightUnit,
        height: height.present ? height.value : this.height,
        preferredHeightUnit: preferredHeightUnit ?? this.preferredHeightUnit,
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
      age: data.age.present ? data.age.value : this.age,
      gender: data.gender.present ? data.gender.value : this.gender,
      weight: data.weight.present ? data.weight.value : this.weight,
      preferredWeightUnit: data.preferredWeightUnit.present
          ? data.preferredWeightUnit.value
          : this.preferredWeightUnit,
      height: data.height.present ? data.height.value : this.height,
      preferredHeightUnit: data.preferredHeightUnit.present
          ? data.preferredHeightUnit.value
          : this.preferredHeightUnit,
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
          ..write('age: $age, ')
          ..write('gender: $gender, ')
          ..write('weight: $weight, ')
          ..write('preferredWeightUnit: $preferredWeightUnit, ')
          ..write('height: $height, ')
          ..write('preferredHeightUnit: $preferredHeightUnit, ')
          ..write('availableDays: $availableDays, ')
          ..write('constraints: $constraints, ')
          ..write('healthPermissionsGranted: $healthPermissionsGranted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      age,
      gender,
      weight,
      preferredWeightUnit,
      height,
      preferredHeightUnit,
      availableDays,
      constraints,
      healthPermissionsGranted,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserDTO &&
          other.id == this.id &&
          other.age == this.age &&
          other.gender == this.gender &&
          other.weight == this.weight &&
          other.preferredWeightUnit == this.preferredWeightUnit &&
          other.height == this.height &&
          other.preferredHeightUnit == this.preferredHeightUnit &&
          other.availableDays == this.availableDays &&
          other.constraints == this.constraints &&
          other.healthPermissionsGranted == this.healthPermissionsGranted &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UsersCompanion extends UpdateCompanion<UserDTO> {
  final Value<int> id;
  final Value<int?> age;
  final Value<String?> gender;
  final Value<double?> weight;
  final Value<String> preferredWeightUnit;
  final Value<double?> height;
  final Value<String> preferredHeightUnit;
  final Value<String> availableDays;
  final Value<String?> constraints;
  final Value<bool> healthPermissionsGranted;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.age = const Value.absent(),
    this.gender = const Value.absent(),
    this.weight = const Value.absent(),
    this.preferredWeightUnit = const Value.absent(),
    this.height = const Value.absent(),
    this.preferredHeightUnit = const Value.absent(),
    this.availableDays = const Value.absent(),
    this.constraints = const Value.absent(),
    this.healthPermissionsGranted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    this.age = const Value.absent(),
    this.gender = const Value.absent(),
    this.weight = const Value.absent(),
    this.preferredWeightUnit = const Value.absent(),
    this.height = const Value.absent(),
    this.preferredHeightUnit = const Value.absent(),
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
    Expression<int>? age,
    Expression<String>? gender,
    Expression<double>? weight,
    Expression<String>? preferredWeightUnit,
    Expression<double>? height,
    Expression<String>? preferredHeightUnit,
    Expression<String>? availableDays,
    Expression<String>? constraints,
    Expression<bool>? healthPermissionsGranted,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (age != null) 'age': age,
      if (gender != null) 'gender': gender,
      if (weight != null) 'weight': weight,
      if (preferredWeightUnit != null)
        'preferred_weight_unit': preferredWeightUnit,
      if (height != null) 'height': height,
      if (preferredHeightUnit != null)
        'preferred_height_unit': preferredHeightUnit,
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
      Value<int?>? age,
      Value<String?>? gender,
      Value<double?>? weight,
      Value<String>? preferredWeightUnit,
      Value<double?>? height,
      Value<String>? preferredHeightUnit,
      Value<String>? availableDays,
      Value<String?>? constraints,
      Value<bool>? healthPermissionsGranted,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return UsersCompanion(
      id: id ?? this.id,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      weight: weight ?? this.weight,
      preferredWeightUnit: preferredWeightUnit ?? this.preferredWeightUnit,
      height: height ?? this.height,
      preferredHeightUnit: preferredHeightUnit ?? this.preferredHeightUnit,
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
    if (age.present) {
      map['age'] = Variable<int>(age.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (preferredWeightUnit.present) {
      map['preferred_weight_unit'] =
          Variable<String>(preferredWeightUnit.value);
    }
    if (height.present) {
      map['height'] = Variable<double>(height.value);
    }
    if (preferredHeightUnit.present) {
      map['preferred_height_unit'] =
          Variable<String>(preferredHeightUnit.value);
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
          ..write('age: $age, ')
          ..write('gender: $gender, ')
          ..write('weight: $weight, ')
          ..write('preferredWeightUnit: $preferredWeightUnit, ')
          ..write('height: $height, ')
          ..write('preferredHeightUnit: $preferredHeightUnit, ')
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

class $ConversationsTable extends Conversations
    with TableInfo<$ConversationsTable, ConversationDTO> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConversationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _startedAtMeta =
      const VerificationMeta('startedAt');
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
      'started_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endedAtMeta =
      const VerificationMeta('endedAt');
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
      'ended_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _messageCountMeta =
      const VerificationMeta('messageCount');
  @override
  late final GeneratedColumn<int> messageCount = GeneratedColumn<int>(
      'message_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [id, userId, startedAt, endedAt, messageCount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'conversations';
  @override
  VerificationContext validateIntegrity(Insertable<ConversationDTO> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(_startedAtMeta,
          startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta));
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(_endedAtMeta,
          endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta));
    }
    if (data.containsKey('message_count')) {
      context.handle(
          _messageCountMeta,
          messageCount.isAcceptableOrUnknown(
              data['message_count']!, _messageCountMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ConversationDTO map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ConversationDTO(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      startedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}started_at'])!,
      endedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}ended_at']),
      messageCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}message_count'])!,
    );
  }

  @override
  $ConversationsTable createAlias(String alias) {
    return $ConversationsTable(attachedDatabase, alias);
  }
}

class ConversationDTO extends DataClass implements Insertable<ConversationDTO> {
  final String id;
  final int userId;
  final DateTime startedAt;
  final DateTime? endedAt;
  final int messageCount;
  const ConversationDTO(
      {required this.id,
      required this.userId,
      required this.startedAt,
      this.endedAt,
      required this.messageCount});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<int>(userId);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<DateTime>(endedAt);
    }
    map['message_count'] = Variable<int>(messageCount);
    return map;
  }

  ConversationsCompanion toCompanion(bool nullToAbsent) {
    return ConversationsCompanion(
      id: Value(id),
      userId: Value(userId),
      startedAt: Value(startedAt),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
      messageCount: Value(messageCount),
    );
  }

  factory ConversationDTO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ConversationDTO(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      endedAt: serializer.fromJson<DateTime?>(json['endedAt']),
      messageCount: serializer.fromJson<int>(json['messageCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<int>(userId),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'endedAt': serializer.toJson<DateTime?>(endedAt),
      'messageCount': serializer.toJson<int>(messageCount),
    };
  }

  ConversationDTO copyWith(
          {String? id,
          int? userId,
          DateTime? startedAt,
          Value<DateTime?> endedAt = const Value.absent(),
          int? messageCount}) =>
      ConversationDTO(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        startedAt: startedAt ?? this.startedAt,
        endedAt: endedAt.present ? endedAt.value : this.endedAt,
        messageCount: messageCount ?? this.messageCount,
      );
  ConversationDTO copyWithCompanion(ConversationsCompanion data) {
    return ConversationDTO(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      messageCount: data.messageCount.present
          ? data.messageCount.value
          : this.messageCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ConversationDTO(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('messageCount: $messageCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, startedAt, endedAt, messageCount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ConversationDTO &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt &&
          other.messageCount == this.messageCount);
}

class ConversationsCompanion extends UpdateCompanion<ConversationDTO> {
  final Value<String> id;
  final Value<int> userId;
  final Value<DateTime> startedAt;
  final Value<DateTime?> endedAt;
  final Value<int> messageCount;
  final Value<int> rowid;
  const ConversationsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.messageCount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ConversationsCompanion.insert({
    required String id,
    required int userId,
    required DateTime startedAt,
    this.endedAt = const Value.absent(),
    this.messageCount = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        userId = Value(userId),
        startedAt = Value(startedAt);
  static Insertable<ConversationDTO> custom({
    Expression<String>? id,
    Expression<int>? userId,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
    Expression<int>? messageCount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (messageCount != null) 'message_count': messageCount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ConversationsCompanion copyWith(
      {Value<String>? id,
      Value<int>? userId,
      Value<DateTime>? startedAt,
      Value<DateTime?>? endedAt,
      Value<int>? messageCount,
      Value<int>? rowid}) {
    return ConversationsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      messageCount: messageCount ?? this.messageCount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (messageCount.present) {
      map['message_count'] = Variable<int>(messageCount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConversationsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('messageCount: $messageCount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ConversationMessagesTable extends ConversationMessages
    with TableInfo<$ConversationMessagesTable, ConversationMessageDTO> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConversationMessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _conversationIdMeta =
      const VerificationMeta('conversationId');
  @override
  late final GeneratedColumn<String> conversationId = GeneratedColumn<String>(
      'conversation_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES conversations (id)'));
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _functionCallNameMeta =
      const VerificationMeta('functionCallName');
  @override
  late final GeneratedColumn<String> functionCallName = GeneratedColumn<String>(
      'function_call_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _functionCallArgumentsMeta =
      const VerificationMeta('functionCallArguments');
  @override
  late final GeneratedColumn<String> functionCallArguments =
      GeneratedColumn<String>('function_call_arguments', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        conversationId,
        role,
        content,
        timestamp,
        functionCallName,
        functionCallArguments
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'conversation_messages';
  @override
  VerificationContext validateIntegrity(
      Insertable<ConversationMessageDTO> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('conversation_id')) {
      context.handle(
          _conversationIdMeta,
          conversationId.isAcceptableOrUnknown(
              data['conversation_id']!, _conversationIdMeta));
    } else if (isInserting) {
      context.missing(_conversationIdMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('function_call_name')) {
      context.handle(
          _functionCallNameMeta,
          functionCallName.isAcceptableOrUnknown(
              data['function_call_name']!, _functionCallNameMeta));
    }
    if (data.containsKey('function_call_arguments')) {
      context.handle(
          _functionCallArgumentsMeta,
          functionCallArguments.isAcceptableOrUnknown(
              data['function_call_arguments']!, _functionCallArgumentsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ConversationMessageDTO map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ConversationMessageDTO(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      conversationId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}conversation_id'])!,
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp'])!,
      functionCallName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}function_call_name']),
      functionCallArguments: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}function_call_arguments']),
    );
  }

  @override
  $ConversationMessagesTable createAlias(String alias) {
    return $ConversationMessagesTable(attachedDatabase, alias);
  }
}

class ConversationMessageDTO extends DataClass
    implements Insertable<ConversationMessageDTO> {
  final String id;
  final String conversationId;
  final String role;
  final String content;
  final DateTime timestamp;
  final String? functionCallName;
  final String? functionCallArguments;
  const ConversationMessageDTO(
      {required this.id,
      required this.conversationId,
      required this.role,
      required this.content,
      required this.timestamp,
      this.functionCallName,
      this.functionCallArguments});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['conversation_id'] = Variable<String>(conversationId);
    map['role'] = Variable<String>(role);
    map['content'] = Variable<String>(content);
    map['timestamp'] = Variable<DateTime>(timestamp);
    if (!nullToAbsent || functionCallName != null) {
      map['function_call_name'] = Variable<String>(functionCallName);
    }
    if (!nullToAbsent || functionCallArguments != null) {
      map['function_call_arguments'] = Variable<String>(functionCallArguments);
    }
    return map;
  }

  ConversationMessagesCompanion toCompanion(bool nullToAbsent) {
    return ConversationMessagesCompanion(
      id: Value(id),
      conversationId: Value(conversationId),
      role: Value(role),
      content: Value(content),
      timestamp: Value(timestamp),
      functionCallName: functionCallName == null && nullToAbsent
          ? const Value.absent()
          : Value(functionCallName),
      functionCallArguments: functionCallArguments == null && nullToAbsent
          ? const Value.absent()
          : Value(functionCallArguments),
    );
  }

  factory ConversationMessageDTO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ConversationMessageDTO(
      id: serializer.fromJson<String>(json['id']),
      conversationId: serializer.fromJson<String>(json['conversationId']),
      role: serializer.fromJson<String>(json['role']),
      content: serializer.fromJson<String>(json['content']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      functionCallName: serializer.fromJson<String?>(json['functionCallName']),
      functionCallArguments:
          serializer.fromJson<String?>(json['functionCallArguments']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'conversationId': serializer.toJson<String>(conversationId),
      'role': serializer.toJson<String>(role),
      'content': serializer.toJson<String>(content),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'functionCallName': serializer.toJson<String?>(functionCallName),
      'functionCallArguments':
          serializer.toJson<String?>(functionCallArguments),
    };
  }

  ConversationMessageDTO copyWith(
          {String? id,
          String? conversationId,
          String? role,
          String? content,
          DateTime? timestamp,
          Value<String?> functionCallName = const Value.absent(),
          Value<String?> functionCallArguments = const Value.absent()}) =>
      ConversationMessageDTO(
        id: id ?? this.id,
        conversationId: conversationId ?? this.conversationId,
        role: role ?? this.role,
        content: content ?? this.content,
        timestamp: timestamp ?? this.timestamp,
        functionCallName: functionCallName.present
            ? functionCallName.value
            : this.functionCallName,
        functionCallArguments: functionCallArguments.present
            ? functionCallArguments.value
            : this.functionCallArguments,
      );
  ConversationMessageDTO copyWithCompanion(ConversationMessagesCompanion data) {
    return ConversationMessageDTO(
      id: data.id.present ? data.id.value : this.id,
      conversationId: data.conversationId.present
          ? data.conversationId.value
          : this.conversationId,
      role: data.role.present ? data.role.value : this.role,
      content: data.content.present ? data.content.value : this.content,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      functionCallName: data.functionCallName.present
          ? data.functionCallName.value
          : this.functionCallName,
      functionCallArguments: data.functionCallArguments.present
          ? data.functionCallArguments.value
          : this.functionCallArguments,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ConversationMessageDTO(')
          ..write('id: $id, ')
          ..write('conversationId: $conversationId, ')
          ..write('role: $role, ')
          ..write('content: $content, ')
          ..write('timestamp: $timestamp, ')
          ..write('functionCallName: $functionCallName, ')
          ..write('functionCallArguments: $functionCallArguments')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, conversationId, role, content, timestamp,
      functionCallName, functionCallArguments);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ConversationMessageDTO &&
          other.id == this.id &&
          other.conversationId == this.conversationId &&
          other.role == this.role &&
          other.content == this.content &&
          other.timestamp == this.timestamp &&
          other.functionCallName == this.functionCallName &&
          other.functionCallArguments == this.functionCallArguments);
}

class ConversationMessagesCompanion
    extends UpdateCompanion<ConversationMessageDTO> {
  final Value<String> id;
  final Value<String> conversationId;
  final Value<String> role;
  final Value<String> content;
  final Value<DateTime> timestamp;
  final Value<String?> functionCallName;
  final Value<String?> functionCallArguments;
  final Value<int> rowid;
  const ConversationMessagesCompanion({
    this.id = const Value.absent(),
    this.conversationId = const Value.absent(),
    this.role = const Value.absent(),
    this.content = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.functionCallName = const Value.absent(),
    this.functionCallArguments = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ConversationMessagesCompanion.insert({
    required String id,
    required String conversationId,
    required String role,
    required String content,
    required DateTime timestamp,
    this.functionCallName = const Value.absent(),
    this.functionCallArguments = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        conversationId = Value(conversationId),
        role = Value(role),
        content = Value(content),
        timestamp = Value(timestamp);
  static Insertable<ConversationMessageDTO> custom({
    Expression<String>? id,
    Expression<String>? conversationId,
    Expression<String>? role,
    Expression<String>? content,
    Expression<DateTime>? timestamp,
    Expression<String>? functionCallName,
    Expression<String>? functionCallArguments,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (conversationId != null) 'conversation_id': conversationId,
      if (role != null) 'role': role,
      if (content != null) 'content': content,
      if (timestamp != null) 'timestamp': timestamp,
      if (functionCallName != null) 'function_call_name': functionCallName,
      if (functionCallArguments != null)
        'function_call_arguments': functionCallArguments,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ConversationMessagesCompanion copyWith(
      {Value<String>? id,
      Value<String>? conversationId,
      Value<String>? role,
      Value<String>? content,
      Value<DateTime>? timestamp,
      Value<String?>? functionCallName,
      Value<String?>? functionCallArguments,
      Value<int>? rowid}) {
    return ConversationMessagesCompanion(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      role: role ?? this.role,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      functionCallName: functionCallName ?? this.functionCallName,
      functionCallArguments:
          functionCallArguments ?? this.functionCallArguments,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (conversationId.present) {
      map['conversation_id'] = Variable<String>(conversationId.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (functionCallName.present) {
      map['function_call_name'] = Variable<String>(functionCallName.value);
    }
    if (functionCallArguments.present) {
      map['function_call_arguments'] =
          Variable<String>(functionCallArguments.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConversationMessagesCompanion(')
          ..write('id: $id, ')
          ..write('conversationId: $conversationId, ')
          ..write('role: $role, ')
          ..write('content: $content, ')
          ..write('timestamp: $timestamp, ')
          ..write('functionCallName: $functionCallName, ')
          ..write('functionCallArguments: $functionCallArguments, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LongTermContextTable extends LongTermContext
    with TableInfo<$LongTermContextTable, LongTermContextDTO> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LongTermContextTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _goalIdMeta = const VerificationMeta('goalId');
  @override
  late final GeneratedColumn<int> goalId = GeneratedColumn<int>(
      'goal_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES goals (id)'));
  static const VerificationMeta _contextJsonMeta =
      const VerificationMeta('contextJson');
  @override
  late final GeneratedColumn<String> contextJson = GeneratedColumn<String>(
      'context_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
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
  List<GeneratedColumn> get $columns =>
      [id, userId, goalId, contextJson, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'long_term_context';
  @override
  VerificationContext validateIntegrity(Insertable<LongTermContextDTO> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('goal_id')) {
      context.handle(_goalIdMeta,
          goalId.isAcceptableOrUnknown(data['goal_id']!, _goalIdMeta));
    } else if (isInserting) {
      context.missing(_goalIdMeta);
    }
    if (data.containsKey('context_json')) {
      context.handle(
          _contextJsonMeta,
          contextJson.isAcceptableOrUnknown(
              data['context_json']!, _contextJsonMeta));
    } else if (isInserting) {
      context.missing(_contextJsonMeta);
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
  LongTermContextDTO map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LongTermContextDTO(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      goalId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}goal_id'])!,
      contextJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}context_json'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $LongTermContextTable createAlias(String alias) {
    return $LongTermContextTable(attachedDatabase, alias);
  }
}

class LongTermContextDTO extends DataClass
    implements Insertable<LongTermContextDTO> {
  final String id;
  final int userId;
  final int goalId;
  final String contextJson;
  final DateTime createdAt;
  final DateTime updatedAt;
  const LongTermContextDTO(
      {required this.id,
      required this.userId,
      required this.goalId,
      required this.contextJson,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<int>(userId);
    map['goal_id'] = Variable<int>(goalId);
    map['context_json'] = Variable<String>(contextJson);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LongTermContextCompanion toCompanion(bool nullToAbsent) {
    return LongTermContextCompanion(
      id: Value(id),
      userId: Value(userId),
      goalId: Value(goalId),
      contextJson: Value(contextJson),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory LongTermContextDTO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LongTermContextDTO(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      goalId: serializer.fromJson<int>(json['goalId']),
      contextJson: serializer.fromJson<String>(json['contextJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<int>(userId),
      'goalId': serializer.toJson<int>(goalId),
      'contextJson': serializer.toJson<String>(contextJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LongTermContextDTO copyWith(
          {String? id,
          int? userId,
          int? goalId,
          String? contextJson,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      LongTermContextDTO(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        goalId: goalId ?? this.goalId,
        contextJson: contextJson ?? this.contextJson,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  LongTermContextDTO copyWithCompanion(LongTermContextCompanion data) {
    return LongTermContextDTO(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      goalId: data.goalId.present ? data.goalId.value : this.goalId,
      contextJson:
          data.contextJson.present ? data.contextJson.value : this.contextJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LongTermContextDTO(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('goalId: $goalId, ')
          ..write('contextJson: $contextJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userId, goalId, contextJson, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LongTermContextDTO &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.goalId == this.goalId &&
          other.contextJson == this.contextJson &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LongTermContextCompanion extends UpdateCompanion<LongTermContextDTO> {
  final Value<String> id;
  final Value<int> userId;
  final Value<int> goalId;
  final Value<String> contextJson;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const LongTermContextCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.goalId = const Value.absent(),
    this.contextJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LongTermContextCompanion.insert({
    required String id,
    required int userId,
    required int goalId,
    required String contextJson,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        userId = Value(userId),
        goalId = Value(goalId),
        contextJson = Value(contextJson),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<LongTermContextDTO> custom({
    Expression<String>? id,
    Expression<int>? userId,
    Expression<int>? goalId,
    Expression<String>? contextJson,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (goalId != null) 'goal_id': goalId,
      if (contextJson != null) 'context_json': contextJson,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LongTermContextCompanion copyWith(
      {Value<String>? id,
      Value<int>? userId,
      Value<int>? goalId,
      Value<String>? contextJson,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return LongTermContextCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      goalId: goalId ?? this.goalId,
      contextJson: contextJson ?? this.contextJson,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (goalId.present) {
      map['goal_id'] = Variable<int>(goalId.value);
    }
    if (contextJson.present) {
      map['context_json'] = Variable<String>(contextJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LongTermContextCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('goalId: $goalId, ')
          ..write('contextJson: $contextJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MediumTermContextTable extends MediumTermContext
    with TableInfo<$MediumTermContextTable, MediumTermContextDTO> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MediumTermContextTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _periodStartMeta =
      const VerificationMeta('periodStart');
  @override
  late final GeneratedColumn<DateTime> periodStart = GeneratedColumn<DateTime>(
      'period_start', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _periodEndMeta =
      const VerificationMeta('periodEnd');
  @override
  late final GeneratedColumn<DateTime> periodEnd = GeneratedColumn<DateTime>(
      'period_end', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _contextJsonMeta =
      const VerificationMeta('contextJson');
  @override
  late final GeneratedColumn<String> contextJson = GeneratedColumn<String>(
      'context_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, userId, periodStart, periodEnd, contextJson, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'medium_term_context';
  @override
  VerificationContext validateIntegrity(
      Insertable<MediumTermContextDTO> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('period_start')) {
      context.handle(
          _periodStartMeta,
          periodStart.isAcceptableOrUnknown(
              data['period_start']!, _periodStartMeta));
    } else if (isInserting) {
      context.missing(_periodStartMeta);
    }
    if (data.containsKey('period_end')) {
      context.handle(_periodEndMeta,
          periodEnd.isAcceptableOrUnknown(data['period_end']!, _periodEndMeta));
    } else if (isInserting) {
      context.missing(_periodEndMeta);
    }
    if (data.containsKey('context_json')) {
      context.handle(
          _contextJsonMeta,
          contextJson.isAcceptableOrUnknown(
              data['context_json']!, _contextJsonMeta));
    } else if (isInserting) {
      context.missing(_contextJsonMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MediumTermContextDTO map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MediumTermContextDTO(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      periodStart: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}period_start'])!,
      periodEnd: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}period_end'])!,
      contextJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}context_json'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $MediumTermContextTable createAlias(String alias) {
    return $MediumTermContextTable(attachedDatabase, alias);
  }
}

class MediumTermContextDTO extends DataClass
    implements Insertable<MediumTermContextDTO> {
  final String id;
  final int userId;
  final DateTime periodStart;
  final DateTime periodEnd;
  final String contextJson;
  final DateTime createdAt;
  const MediumTermContextDTO(
      {required this.id,
      required this.userId,
      required this.periodStart,
      required this.periodEnd,
      required this.contextJson,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<int>(userId);
    map['period_start'] = Variable<DateTime>(periodStart);
    map['period_end'] = Variable<DateTime>(periodEnd);
    map['context_json'] = Variable<String>(contextJson);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MediumTermContextCompanion toCompanion(bool nullToAbsent) {
    return MediumTermContextCompanion(
      id: Value(id),
      userId: Value(userId),
      periodStart: Value(periodStart),
      periodEnd: Value(periodEnd),
      contextJson: Value(contextJson),
      createdAt: Value(createdAt),
    );
  }

  factory MediumTermContextDTO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MediumTermContextDTO(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      periodStart: serializer.fromJson<DateTime>(json['periodStart']),
      periodEnd: serializer.fromJson<DateTime>(json['periodEnd']),
      contextJson: serializer.fromJson<String>(json['contextJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<int>(userId),
      'periodStart': serializer.toJson<DateTime>(periodStart),
      'periodEnd': serializer.toJson<DateTime>(periodEnd),
      'contextJson': serializer.toJson<String>(contextJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  MediumTermContextDTO copyWith(
          {String? id,
          int? userId,
          DateTime? periodStart,
          DateTime? periodEnd,
          String? contextJson,
          DateTime? createdAt}) =>
      MediumTermContextDTO(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        periodStart: periodStart ?? this.periodStart,
        periodEnd: periodEnd ?? this.periodEnd,
        contextJson: contextJson ?? this.contextJson,
        createdAt: createdAt ?? this.createdAt,
      );
  MediumTermContextDTO copyWithCompanion(MediumTermContextCompanion data) {
    return MediumTermContextDTO(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      periodStart:
          data.periodStart.present ? data.periodStart.value : this.periodStart,
      periodEnd: data.periodEnd.present ? data.periodEnd.value : this.periodEnd,
      contextJson:
          data.contextJson.present ? data.contextJson.value : this.contextJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MediumTermContextDTO(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('periodStart: $periodStart, ')
          ..write('periodEnd: $periodEnd, ')
          ..write('contextJson: $contextJson, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userId, periodStart, periodEnd, contextJson, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MediumTermContextDTO &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.periodStart == this.periodStart &&
          other.periodEnd == this.periodEnd &&
          other.contextJson == this.contextJson &&
          other.createdAt == this.createdAt);
}

class MediumTermContextCompanion extends UpdateCompanion<MediumTermContextDTO> {
  final Value<String> id;
  final Value<int> userId;
  final Value<DateTime> periodStart;
  final Value<DateTime> periodEnd;
  final Value<String> contextJson;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const MediumTermContextCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.periodStart = const Value.absent(),
    this.periodEnd = const Value.absent(),
    this.contextJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MediumTermContextCompanion.insert({
    required String id,
    required int userId,
    required DateTime periodStart,
    required DateTime periodEnd,
    required String contextJson,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        userId = Value(userId),
        periodStart = Value(periodStart),
        periodEnd = Value(periodEnd),
        contextJson = Value(contextJson),
        createdAt = Value(createdAt);
  static Insertable<MediumTermContextDTO> custom({
    Expression<String>? id,
    Expression<int>? userId,
    Expression<DateTime>? periodStart,
    Expression<DateTime>? periodEnd,
    Expression<String>? contextJson,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (periodStart != null) 'period_start': periodStart,
      if (periodEnd != null) 'period_end': periodEnd,
      if (contextJson != null) 'context_json': contextJson,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MediumTermContextCompanion copyWith(
      {Value<String>? id,
      Value<int>? userId,
      Value<DateTime>? periodStart,
      Value<DateTime>? periodEnd,
      Value<String>? contextJson,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return MediumTermContextCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      periodStart: periodStart ?? this.periodStart,
      periodEnd: periodEnd ?? this.periodEnd,
      contextJson: contextJson ?? this.contextJson,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (periodStart.present) {
      map['period_start'] = Variable<DateTime>(periodStart.value);
    }
    if (periodEnd.present) {
      map['period_end'] = Variable<DateTime>(periodEnd.value);
    }
    if (contextJson.present) {
      map['context_json'] = Variable<String>(contextJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MediumTermContextCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('periodStart: $periodStart, ')
          ..write('periodEnd: $periodEnd, ')
          ..write('contextJson: $contextJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkoutsTable extends Workouts
    with TableInfo<$WorkoutsTable, WorkoutDTO> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _goalIdMeta = const VerificationMeta('goalId');
  @override
  late final GeneratedColumn<int> goalId = GeneratedColumn<int>(
      'goal_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _phaseIdMeta =
      const VerificationMeta('phaseId');
  @override
  late final GeneratedColumn<String> phaseId = GeneratedColumn<String>(
      'phase_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _blockIdMeta =
      const VerificationMeta('blockId');
  @override
  late final GeneratedColumn<String> blockId = GeneratedColumn<String>(
      'block_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _scheduledDateMeta =
      const VerificationMeta('scheduledDate');
  @override
  late final GeneratedColumn<DateTime> scheduledDate =
      GeneratedColumn<DateTime>('scheduled_date', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
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
  static const VerificationMeta _plannedDurationMeta =
      const VerificationMeta('plannedDuration');
  @override
  late final GeneratedColumn<int> plannedDuration = GeneratedColumn<int>(
      'planned_duration', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _plannedDistanceMeta =
      const VerificationMeta('plannedDistance');
  @override
  late final GeneratedColumn<double> plannedDistance = GeneratedColumn<double>(
      'planned_distance', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _intensityMeta =
      const VerificationMeta('intensity');
  @override
  late final GeneratedColumn<String> intensity = GeneratedColumn<String>(
      'intensity', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _actualDurationMeta =
      const VerificationMeta('actualDuration');
  @override
  late final GeneratedColumn<int> actualDuration = GeneratedColumn<int>(
      'actual_duration', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _actualDistanceMeta =
      const VerificationMeta('actualDistance');
  @override
  late final GeneratedColumn<double> actualDistance = GeneratedColumn<double>(
      'actual_distance', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _actualPaceMeta =
      const VerificationMeta('actualPace');
  @override
  late final GeneratedColumn<double> actualPace = GeneratedColumn<double>(
      'actual_pace', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _rpeMeta = const VerificationMeta('rpe');
  @override
  late final GeneratedColumn<int> rpe = GeneratedColumn<int>(
      'rpe', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _completedAtMeta =
      const VerificationMeta('completedAt');
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
      'completed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        goalId,
        phaseId,
        blockId,
        scheduledDate,
        type,
        name,
        plannedDuration,
        plannedDistance,
        intensity,
        description,
        status,
        actualDuration,
        actualDistance,
        actualPace,
        rpe,
        completedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workouts';
  @override
  VerificationContext validateIntegrity(Insertable<WorkoutDTO> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('goal_id')) {
      context.handle(_goalIdMeta,
          goalId.isAcceptableOrUnknown(data['goal_id']!, _goalIdMeta));
    } else if (isInserting) {
      context.missing(_goalIdMeta);
    }
    if (data.containsKey('phase_id')) {
      context.handle(_phaseIdMeta,
          phaseId.isAcceptableOrUnknown(data['phase_id']!, _phaseIdMeta));
    }
    if (data.containsKey('block_id')) {
      context.handle(_blockIdMeta,
          blockId.isAcceptableOrUnknown(data['block_id']!, _blockIdMeta));
    }
    if (data.containsKey('scheduled_date')) {
      context.handle(
          _scheduledDateMeta,
          scheduledDate.isAcceptableOrUnknown(
              data['scheduled_date']!, _scheduledDateMeta));
    } else if (isInserting) {
      context.missing(_scheduledDateMeta);
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
    if (data.containsKey('planned_duration')) {
      context.handle(
          _plannedDurationMeta,
          plannedDuration.isAcceptableOrUnknown(
              data['planned_duration']!, _plannedDurationMeta));
    } else if (isInserting) {
      context.missing(_plannedDurationMeta);
    }
    if (data.containsKey('planned_distance')) {
      context.handle(
          _plannedDistanceMeta,
          plannedDistance.isAcceptableOrUnknown(
              data['planned_distance']!, _plannedDistanceMeta));
    }
    if (data.containsKey('intensity')) {
      context.handle(_intensityMeta,
          intensity.isAcceptableOrUnknown(data['intensity']!, _intensityMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('actual_duration')) {
      context.handle(
          _actualDurationMeta,
          actualDuration.isAcceptableOrUnknown(
              data['actual_duration']!, _actualDurationMeta));
    }
    if (data.containsKey('actual_distance')) {
      context.handle(
          _actualDistanceMeta,
          actualDistance.isAcceptableOrUnknown(
              data['actual_distance']!, _actualDistanceMeta));
    }
    if (data.containsKey('actual_pace')) {
      context.handle(
          _actualPaceMeta,
          actualPace.isAcceptableOrUnknown(
              data['actual_pace']!, _actualPaceMeta));
    }
    if (data.containsKey('rpe')) {
      context.handle(
          _rpeMeta, rpe.isAcceptableOrUnknown(data['rpe']!, _rpeMeta));
    }
    if (data.containsKey('completed_at')) {
      context.handle(
          _completedAtMeta,
          completedAt.isAcceptableOrUnknown(
              data['completed_at']!, _completedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutDTO map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutDTO(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      goalId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}goal_id'])!,
      phaseId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phase_id']),
      blockId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}block_id']),
      scheduledDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}scheduled_date'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      plannedDuration: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}planned_duration'])!,
      plannedDistance: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}planned_distance']),
      intensity: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}intensity']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      actualDuration: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}actual_duration']),
      actualDistance: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}actual_distance']),
      actualPace: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}actual_pace']),
      rpe: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rpe']),
      completedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}completed_at']),
    );
  }

  @override
  $WorkoutsTable createAlias(String alias) {
    return $WorkoutsTable(attachedDatabase, alias);
  }
}

class WorkoutDTO extends DataClass implements Insertable<WorkoutDTO> {
  final String id;
  final int userId;
  final int goalId;
  final String? phaseId;
  final String? blockId;
  final DateTime scheduledDate;
  final String type;
  final String name;
  final int plannedDuration;
  final double? plannedDistance;
  final String? intensity;
  final String? description;
  final String status;
  final int? actualDuration;
  final double? actualDistance;
  final double? actualPace;
  final int? rpe;
  final DateTime? completedAt;
  const WorkoutDTO(
      {required this.id,
      required this.userId,
      required this.goalId,
      this.phaseId,
      this.blockId,
      required this.scheduledDate,
      required this.type,
      required this.name,
      required this.plannedDuration,
      this.plannedDistance,
      this.intensity,
      this.description,
      required this.status,
      this.actualDuration,
      this.actualDistance,
      this.actualPace,
      this.rpe,
      this.completedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<int>(userId);
    map['goal_id'] = Variable<int>(goalId);
    if (!nullToAbsent || phaseId != null) {
      map['phase_id'] = Variable<String>(phaseId);
    }
    if (!nullToAbsent || blockId != null) {
      map['block_id'] = Variable<String>(blockId);
    }
    map['scheduled_date'] = Variable<DateTime>(scheduledDate);
    map['type'] = Variable<String>(type);
    map['name'] = Variable<String>(name);
    map['planned_duration'] = Variable<int>(plannedDuration);
    if (!nullToAbsent || plannedDistance != null) {
      map['planned_distance'] = Variable<double>(plannedDistance);
    }
    if (!nullToAbsent || intensity != null) {
      map['intensity'] = Variable<String>(intensity);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || actualDuration != null) {
      map['actual_duration'] = Variable<int>(actualDuration);
    }
    if (!nullToAbsent || actualDistance != null) {
      map['actual_distance'] = Variable<double>(actualDistance);
    }
    if (!nullToAbsent || actualPace != null) {
      map['actual_pace'] = Variable<double>(actualPace);
    }
    if (!nullToAbsent || rpe != null) {
      map['rpe'] = Variable<int>(rpe);
    }
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    return map;
  }

  WorkoutsCompanion toCompanion(bool nullToAbsent) {
    return WorkoutsCompanion(
      id: Value(id),
      userId: Value(userId),
      goalId: Value(goalId),
      phaseId: phaseId == null && nullToAbsent
          ? const Value.absent()
          : Value(phaseId),
      blockId: blockId == null && nullToAbsent
          ? const Value.absent()
          : Value(blockId),
      scheduledDate: Value(scheduledDate),
      type: Value(type),
      name: Value(name),
      plannedDuration: Value(plannedDuration),
      plannedDistance: plannedDistance == null && nullToAbsent
          ? const Value.absent()
          : Value(plannedDistance),
      intensity: intensity == null && nullToAbsent
          ? const Value.absent()
          : Value(intensity),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      status: Value(status),
      actualDuration: actualDuration == null && nullToAbsent
          ? const Value.absent()
          : Value(actualDuration),
      actualDistance: actualDistance == null && nullToAbsent
          ? const Value.absent()
          : Value(actualDistance),
      actualPace: actualPace == null && nullToAbsent
          ? const Value.absent()
          : Value(actualPace),
      rpe: rpe == null && nullToAbsent ? const Value.absent() : Value(rpe),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory WorkoutDTO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutDTO(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      goalId: serializer.fromJson<int>(json['goalId']),
      phaseId: serializer.fromJson<String?>(json['phaseId']),
      blockId: serializer.fromJson<String?>(json['blockId']),
      scheduledDate: serializer.fromJson<DateTime>(json['scheduledDate']),
      type: serializer.fromJson<String>(json['type']),
      name: serializer.fromJson<String>(json['name']),
      plannedDuration: serializer.fromJson<int>(json['plannedDuration']),
      plannedDistance: serializer.fromJson<double?>(json['plannedDistance']),
      intensity: serializer.fromJson<String?>(json['intensity']),
      description: serializer.fromJson<String?>(json['description']),
      status: serializer.fromJson<String>(json['status']),
      actualDuration: serializer.fromJson<int?>(json['actualDuration']),
      actualDistance: serializer.fromJson<double?>(json['actualDistance']),
      actualPace: serializer.fromJson<double?>(json['actualPace']),
      rpe: serializer.fromJson<int?>(json['rpe']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<int>(userId),
      'goalId': serializer.toJson<int>(goalId),
      'phaseId': serializer.toJson<String?>(phaseId),
      'blockId': serializer.toJson<String?>(blockId),
      'scheduledDate': serializer.toJson<DateTime>(scheduledDate),
      'type': serializer.toJson<String>(type),
      'name': serializer.toJson<String>(name),
      'plannedDuration': serializer.toJson<int>(plannedDuration),
      'plannedDistance': serializer.toJson<double?>(plannedDistance),
      'intensity': serializer.toJson<String?>(intensity),
      'description': serializer.toJson<String?>(description),
      'status': serializer.toJson<String>(status),
      'actualDuration': serializer.toJson<int?>(actualDuration),
      'actualDistance': serializer.toJson<double?>(actualDistance),
      'actualPace': serializer.toJson<double?>(actualPace),
      'rpe': serializer.toJson<int?>(rpe),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
    };
  }

  WorkoutDTO copyWith(
          {String? id,
          int? userId,
          int? goalId,
          Value<String?> phaseId = const Value.absent(),
          Value<String?> blockId = const Value.absent(),
          DateTime? scheduledDate,
          String? type,
          String? name,
          int? plannedDuration,
          Value<double?> plannedDistance = const Value.absent(),
          Value<String?> intensity = const Value.absent(),
          Value<String?> description = const Value.absent(),
          String? status,
          Value<int?> actualDuration = const Value.absent(),
          Value<double?> actualDistance = const Value.absent(),
          Value<double?> actualPace = const Value.absent(),
          Value<int?> rpe = const Value.absent(),
          Value<DateTime?> completedAt = const Value.absent()}) =>
      WorkoutDTO(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        goalId: goalId ?? this.goalId,
        phaseId: phaseId.present ? phaseId.value : this.phaseId,
        blockId: blockId.present ? blockId.value : this.blockId,
        scheduledDate: scheduledDate ?? this.scheduledDate,
        type: type ?? this.type,
        name: name ?? this.name,
        plannedDuration: plannedDuration ?? this.plannedDuration,
        plannedDistance: plannedDistance.present
            ? plannedDistance.value
            : this.plannedDistance,
        intensity: intensity.present ? intensity.value : this.intensity,
        description: description.present ? description.value : this.description,
        status: status ?? this.status,
        actualDuration:
            actualDuration.present ? actualDuration.value : this.actualDuration,
        actualDistance:
            actualDistance.present ? actualDistance.value : this.actualDistance,
        actualPace: actualPace.present ? actualPace.value : this.actualPace,
        rpe: rpe.present ? rpe.value : this.rpe,
        completedAt: completedAt.present ? completedAt.value : this.completedAt,
      );
  WorkoutDTO copyWithCompanion(WorkoutsCompanion data) {
    return WorkoutDTO(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      goalId: data.goalId.present ? data.goalId.value : this.goalId,
      phaseId: data.phaseId.present ? data.phaseId.value : this.phaseId,
      blockId: data.blockId.present ? data.blockId.value : this.blockId,
      scheduledDate: data.scheduledDate.present
          ? data.scheduledDate.value
          : this.scheduledDate,
      type: data.type.present ? data.type.value : this.type,
      name: data.name.present ? data.name.value : this.name,
      plannedDuration: data.plannedDuration.present
          ? data.plannedDuration.value
          : this.plannedDuration,
      plannedDistance: data.plannedDistance.present
          ? data.plannedDistance.value
          : this.plannedDistance,
      intensity: data.intensity.present ? data.intensity.value : this.intensity,
      description:
          data.description.present ? data.description.value : this.description,
      status: data.status.present ? data.status.value : this.status,
      actualDuration: data.actualDuration.present
          ? data.actualDuration.value
          : this.actualDuration,
      actualDistance: data.actualDistance.present
          ? data.actualDistance.value
          : this.actualDistance,
      actualPace:
          data.actualPace.present ? data.actualPace.value : this.actualPace,
      rpe: data.rpe.present ? data.rpe.value : this.rpe,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutDTO(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('goalId: $goalId, ')
          ..write('phaseId: $phaseId, ')
          ..write('blockId: $blockId, ')
          ..write('scheduledDate: $scheduledDate, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('plannedDuration: $plannedDuration, ')
          ..write('plannedDistance: $plannedDistance, ')
          ..write('intensity: $intensity, ')
          ..write('description: $description, ')
          ..write('status: $status, ')
          ..write('actualDuration: $actualDuration, ')
          ..write('actualDistance: $actualDistance, ')
          ..write('actualPace: $actualPace, ')
          ..write('rpe: $rpe, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      userId,
      goalId,
      phaseId,
      blockId,
      scheduledDate,
      type,
      name,
      plannedDuration,
      plannedDistance,
      intensity,
      description,
      status,
      actualDuration,
      actualDistance,
      actualPace,
      rpe,
      completedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutDTO &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.goalId == this.goalId &&
          other.phaseId == this.phaseId &&
          other.blockId == this.blockId &&
          other.scheduledDate == this.scheduledDate &&
          other.type == this.type &&
          other.name == this.name &&
          other.plannedDuration == this.plannedDuration &&
          other.plannedDistance == this.plannedDistance &&
          other.intensity == this.intensity &&
          other.description == this.description &&
          other.status == this.status &&
          other.actualDuration == this.actualDuration &&
          other.actualDistance == this.actualDistance &&
          other.actualPace == this.actualPace &&
          other.rpe == this.rpe &&
          other.completedAt == this.completedAt);
}

class WorkoutsCompanion extends UpdateCompanion<WorkoutDTO> {
  final Value<String> id;
  final Value<int> userId;
  final Value<int> goalId;
  final Value<String?> phaseId;
  final Value<String?> blockId;
  final Value<DateTime> scheduledDate;
  final Value<String> type;
  final Value<String> name;
  final Value<int> plannedDuration;
  final Value<double?> plannedDistance;
  final Value<String?> intensity;
  final Value<String?> description;
  final Value<String> status;
  final Value<int?> actualDuration;
  final Value<double?> actualDistance;
  final Value<double?> actualPace;
  final Value<int?> rpe;
  final Value<DateTime?> completedAt;
  final Value<int> rowid;
  const WorkoutsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.goalId = const Value.absent(),
    this.phaseId = const Value.absent(),
    this.blockId = const Value.absent(),
    this.scheduledDate = const Value.absent(),
    this.type = const Value.absent(),
    this.name = const Value.absent(),
    this.plannedDuration = const Value.absent(),
    this.plannedDistance = const Value.absent(),
    this.intensity = const Value.absent(),
    this.description = const Value.absent(),
    this.status = const Value.absent(),
    this.actualDuration = const Value.absent(),
    this.actualDistance = const Value.absent(),
    this.actualPace = const Value.absent(),
    this.rpe = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkoutsCompanion.insert({
    required String id,
    required int userId,
    required int goalId,
    this.phaseId = const Value.absent(),
    this.blockId = const Value.absent(),
    required DateTime scheduledDate,
    required String type,
    required String name,
    required int plannedDuration,
    this.plannedDistance = const Value.absent(),
    this.intensity = const Value.absent(),
    this.description = const Value.absent(),
    required String status,
    this.actualDuration = const Value.absent(),
    this.actualDistance = const Value.absent(),
    this.actualPace = const Value.absent(),
    this.rpe = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        userId = Value(userId),
        goalId = Value(goalId),
        scheduledDate = Value(scheduledDate),
        type = Value(type),
        name = Value(name),
        plannedDuration = Value(plannedDuration),
        status = Value(status);
  static Insertable<WorkoutDTO> custom({
    Expression<String>? id,
    Expression<int>? userId,
    Expression<int>? goalId,
    Expression<String>? phaseId,
    Expression<String>? blockId,
    Expression<DateTime>? scheduledDate,
    Expression<String>? type,
    Expression<String>? name,
    Expression<int>? plannedDuration,
    Expression<double>? plannedDistance,
    Expression<String>? intensity,
    Expression<String>? description,
    Expression<String>? status,
    Expression<int>? actualDuration,
    Expression<double>? actualDistance,
    Expression<double>? actualPace,
    Expression<int>? rpe,
    Expression<DateTime>? completedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (goalId != null) 'goal_id': goalId,
      if (phaseId != null) 'phase_id': phaseId,
      if (blockId != null) 'block_id': blockId,
      if (scheduledDate != null) 'scheduled_date': scheduledDate,
      if (type != null) 'type': type,
      if (name != null) 'name': name,
      if (plannedDuration != null) 'planned_duration': plannedDuration,
      if (plannedDistance != null) 'planned_distance': plannedDistance,
      if (intensity != null) 'intensity': intensity,
      if (description != null) 'description': description,
      if (status != null) 'status': status,
      if (actualDuration != null) 'actual_duration': actualDuration,
      if (actualDistance != null) 'actual_distance': actualDistance,
      if (actualPace != null) 'actual_pace': actualPace,
      if (rpe != null) 'rpe': rpe,
      if (completedAt != null) 'completed_at': completedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkoutsCompanion copyWith(
      {Value<String>? id,
      Value<int>? userId,
      Value<int>? goalId,
      Value<String?>? phaseId,
      Value<String?>? blockId,
      Value<DateTime>? scheduledDate,
      Value<String>? type,
      Value<String>? name,
      Value<int>? plannedDuration,
      Value<double?>? plannedDistance,
      Value<String?>? intensity,
      Value<String?>? description,
      Value<String>? status,
      Value<int?>? actualDuration,
      Value<double?>? actualDistance,
      Value<double?>? actualPace,
      Value<int?>? rpe,
      Value<DateTime?>? completedAt,
      Value<int>? rowid}) {
    return WorkoutsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      goalId: goalId ?? this.goalId,
      phaseId: phaseId ?? this.phaseId,
      blockId: blockId ?? this.blockId,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      type: type ?? this.type,
      name: name ?? this.name,
      plannedDuration: plannedDuration ?? this.plannedDuration,
      plannedDistance: plannedDistance ?? this.plannedDistance,
      intensity: intensity ?? this.intensity,
      description: description ?? this.description,
      status: status ?? this.status,
      actualDuration: actualDuration ?? this.actualDuration,
      actualDistance: actualDistance ?? this.actualDistance,
      actualPace: actualPace ?? this.actualPace,
      rpe: rpe ?? this.rpe,
      completedAt: completedAt ?? this.completedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (goalId.present) {
      map['goal_id'] = Variable<int>(goalId.value);
    }
    if (phaseId.present) {
      map['phase_id'] = Variable<String>(phaseId.value);
    }
    if (blockId.present) {
      map['block_id'] = Variable<String>(blockId.value);
    }
    if (scheduledDate.present) {
      map['scheduled_date'] = Variable<DateTime>(scheduledDate.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (plannedDuration.present) {
      map['planned_duration'] = Variable<int>(plannedDuration.value);
    }
    if (plannedDistance.present) {
      map['planned_distance'] = Variable<double>(plannedDistance.value);
    }
    if (intensity.present) {
      map['intensity'] = Variable<String>(intensity.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (actualDuration.present) {
      map['actual_duration'] = Variable<int>(actualDuration.value);
    }
    if (actualDistance.present) {
      map['actual_distance'] = Variable<double>(actualDistance.value);
    }
    if (actualPace.present) {
      map['actual_pace'] = Variable<double>(actualPace.value);
    }
    if (rpe.present) {
      map['rpe'] = Variable<int>(rpe.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('goalId: $goalId, ')
          ..write('phaseId: $phaseId, ')
          ..write('blockId: $blockId, ')
          ..write('scheduledDate: $scheduledDate, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('plannedDuration: $plannedDuration, ')
          ..write('plannedDistance: $plannedDistance, ')
          ..write('intensity: $intensity, ')
          ..write('description: $description, ')
          ..write('status: $status, ')
          ..write('actualDuration: $actualDuration, ')
          ..write('actualDistance: $actualDistance, ')
          ..write('actualPace: $actualPace, ')
          ..write('rpe: $rpe, ')
          ..write('completedAt: $completedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PhasesTable extends Phases with TableInfo<$PhasesTable, PhaseDTO> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PhasesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _goalIdMeta = const VerificationMeta('goalId');
  @override
  late final GeneratedColumn<int> goalId = GeneratedColumn<int>(
      'goal_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _phaseNumberMeta =
      const VerificationMeta('phaseNumber');
  @override
  late final GeneratedColumn<int> phaseNumber = GeneratedColumn<int>(
      'phase_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _phaseTypeMeta =
      const VerificationMeta('phaseType');
  @override
  late final GeneratedColumn<String> phaseType = GeneratedColumn<String>(
      'phase_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _durationWeeksMeta =
      const VerificationMeta('durationWeeks');
  @override
  late final GeneratedColumn<int> durationWeeks = GeneratedColumn<int>(
      'duration_weeks', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _targetWeeklyVolumeMeta =
      const VerificationMeta('targetWeeklyVolume');
  @override
  late final GeneratedColumn<String> targetWeeklyVolume =
      GeneratedColumn<String>('target_weekly_volume', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _targetWeeklyDurationMeta =
      const VerificationMeta('targetWeeklyDuration');
  @override
  late final GeneratedColumn<String> targetWeeklyDuration =
      GeneratedColumn<String>('target_weekly_duration', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'start_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
      'end_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        goalId,
        phaseNumber,
        phaseType,
        durationWeeks,
        targetWeeklyVolume,
        targetWeeklyDuration,
        startDate,
        endDate,
        description
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'phases';
  @override
  VerificationContext validateIntegrity(Insertable<PhaseDTO> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('goal_id')) {
      context.handle(_goalIdMeta,
          goalId.isAcceptableOrUnknown(data['goal_id']!, _goalIdMeta));
    } else if (isInserting) {
      context.missing(_goalIdMeta);
    }
    if (data.containsKey('phase_number')) {
      context.handle(
          _phaseNumberMeta,
          phaseNumber.isAcceptableOrUnknown(
              data['phase_number']!, _phaseNumberMeta));
    } else if (isInserting) {
      context.missing(_phaseNumberMeta);
    }
    if (data.containsKey('phase_type')) {
      context.handle(_phaseTypeMeta,
          phaseType.isAcceptableOrUnknown(data['phase_type']!, _phaseTypeMeta));
    } else if (isInserting) {
      context.missing(_phaseTypeMeta);
    }
    if (data.containsKey('duration_weeks')) {
      context.handle(
          _durationWeeksMeta,
          durationWeeks.isAcceptableOrUnknown(
              data['duration_weeks']!, _durationWeeksMeta));
    } else if (isInserting) {
      context.missing(_durationWeeksMeta);
    }
    if (data.containsKey('target_weekly_volume')) {
      context.handle(
          _targetWeeklyVolumeMeta,
          targetWeeklyVolume.isAcceptableOrUnknown(
              data['target_weekly_volume']!, _targetWeeklyVolumeMeta));
    } else if (isInserting) {
      context.missing(_targetWeeklyVolumeMeta);
    }
    if (data.containsKey('target_weekly_duration')) {
      context.handle(
          _targetWeeklyDurationMeta,
          targetWeeklyDuration.isAcceptableOrUnknown(
              data['target_weekly_duration']!, _targetWeeklyDurationMeta));
    } else if (isInserting) {
      context.missing(_targetWeeklyDurationMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PhaseDTO map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PhaseDTO(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      goalId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}goal_id'])!,
      phaseNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}phase_number'])!,
      phaseType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phase_type'])!,
      durationWeeks: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_weeks'])!,
      targetWeeklyVolume: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}target_weekly_volume'])!,
      targetWeeklyDuration: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}target_weekly_duration'])!,
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date']),
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_date']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
    );
  }

  @override
  $PhasesTable createAlias(String alias) {
    return $PhasesTable(attachedDatabase, alias);
  }
}

class PhaseDTO extends DataClass implements Insertable<PhaseDTO> {
  final String id;
  final int goalId;
  final int phaseNumber;
  final String phaseType;
  final int durationWeeks;
  final String targetWeeklyVolume;
  final String targetWeeklyDuration;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? description;
  const PhaseDTO(
      {required this.id,
      required this.goalId,
      required this.phaseNumber,
      required this.phaseType,
      required this.durationWeeks,
      required this.targetWeeklyVolume,
      required this.targetWeeklyDuration,
      this.startDate,
      this.endDate,
      this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['goal_id'] = Variable<int>(goalId);
    map['phase_number'] = Variable<int>(phaseNumber);
    map['phase_type'] = Variable<String>(phaseType);
    map['duration_weeks'] = Variable<int>(durationWeeks);
    map['target_weekly_volume'] = Variable<String>(targetWeeklyVolume);
    map['target_weekly_duration'] = Variable<String>(targetWeeklyDuration);
    if (!nullToAbsent || startDate != null) {
      map['start_date'] = Variable<DateTime>(startDate);
    }
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  PhasesCompanion toCompanion(bool nullToAbsent) {
    return PhasesCompanion(
      id: Value(id),
      goalId: Value(goalId),
      phaseNumber: Value(phaseNumber),
      phaseType: Value(phaseType),
      durationWeeks: Value(durationWeeks),
      targetWeeklyVolume: Value(targetWeeklyVolume),
      targetWeeklyDuration: Value(targetWeeklyDuration),
      startDate: startDate == null && nullToAbsent
          ? const Value.absent()
          : Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory PhaseDTO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PhaseDTO(
      id: serializer.fromJson<String>(json['id']),
      goalId: serializer.fromJson<int>(json['goalId']),
      phaseNumber: serializer.fromJson<int>(json['phaseNumber']),
      phaseType: serializer.fromJson<String>(json['phaseType']),
      durationWeeks: serializer.fromJson<int>(json['durationWeeks']),
      targetWeeklyVolume:
          serializer.fromJson<String>(json['targetWeeklyVolume']),
      targetWeeklyDuration:
          serializer.fromJson<String>(json['targetWeeklyDuration']),
      startDate: serializer.fromJson<DateTime?>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'goalId': serializer.toJson<int>(goalId),
      'phaseNumber': serializer.toJson<int>(phaseNumber),
      'phaseType': serializer.toJson<String>(phaseType),
      'durationWeeks': serializer.toJson<int>(durationWeeks),
      'targetWeeklyVolume': serializer.toJson<String>(targetWeeklyVolume),
      'targetWeeklyDuration': serializer.toJson<String>(targetWeeklyDuration),
      'startDate': serializer.toJson<DateTime?>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'description': serializer.toJson<String?>(description),
    };
  }

  PhaseDTO copyWith(
          {String? id,
          int? goalId,
          int? phaseNumber,
          String? phaseType,
          int? durationWeeks,
          String? targetWeeklyVolume,
          String? targetWeeklyDuration,
          Value<DateTime?> startDate = const Value.absent(),
          Value<DateTime?> endDate = const Value.absent(),
          Value<String?> description = const Value.absent()}) =>
      PhaseDTO(
        id: id ?? this.id,
        goalId: goalId ?? this.goalId,
        phaseNumber: phaseNumber ?? this.phaseNumber,
        phaseType: phaseType ?? this.phaseType,
        durationWeeks: durationWeeks ?? this.durationWeeks,
        targetWeeklyVolume: targetWeeklyVolume ?? this.targetWeeklyVolume,
        targetWeeklyDuration: targetWeeklyDuration ?? this.targetWeeklyDuration,
        startDate: startDate.present ? startDate.value : this.startDate,
        endDate: endDate.present ? endDate.value : this.endDate,
        description: description.present ? description.value : this.description,
      );
  PhaseDTO copyWithCompanion(PhasesCompanion data) {
    return PhaseDTO(
      id: data.id.present ? data.id.value : this.id,
      goalId: data.goalId.present ? data.goalId.value : this.goalId,
      phaseNumber:
          data.phaseNumber.present ? data.phaseNumber.value : this.phaseNumber,
      phaseType: data.phaseType.present ? data.phaseType.value : this.phaseType,
      durationWeeks: data.durationWeeks.present
          ? data.durationWeeks.value
          : this.durationWeeks,
      targetWeeklyVolume: data.targetWeeklyVolume.present
          ? data.targetWeeklyVolume.value
          : this.targetWeeklyVolume,
      targetWeeklyDuration: data.targetWeeklyDuration.present
          ? data.targetWeeklyDuration.value
          : this.targetWeeklyDuration,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      description:
          data.description.present ? data.description.value : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PhaseDTO(')
          ..write('id: $id, ')
          ..write('goalId: $goalId, ')
          ..write('phaseNumber: $phaseNumber, ')
          ..write('phaseType: $phaseType, ')
          ..write('durationWeeks: $durationWeeks, ')
          ..write('targetWeeklyVolume: $targetWeeklyVolume, ')
          ..write('targetWeeklyDuration: $targetWeeklyDuration, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      goalId,
      phaseNumber,
      phaseType,
      durationWeeks,
      targetWeeklyVolume,
      targetWeeklyDuration,
      startDate,
      endDate,
      description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PhaseDTO &&
          other.id == this.id &&
          other.goalId == this.goalId &&
          other.phaseNumber == this.phaseNumber &&
          other.phaseType == this.phaseType &&
          other.durationWeeks == this.durationWeeks &&
          other.targetWeeklyVolume == this.targetWeeklyVolume &&
          other.targetWeeklyDuration == this.targetWeeklyDuration &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.description == this.description);
}

class PhasesCompanion extends UpdateCompanion<PhaseDTO> {
  final Value<String> id;
  final Value<int> goalId;
  final Value<int> phaseNumber;
  final Value<String> phaseType;
  final Value<int> durationWeeks;
  final Value<String> targetWeeklyVolume;
  final Value<String> targetWeeklyDuration;
  final Value<DateTime?> startDate;
  final Value<DateTime?> endDate;
  final Value<String?> description;
  final Value<int> rowid;
  const PhasesCompanion({
    this.id = const Value.absent(),
    this.goalId = const Value.absent(),
    this.phaseNumber = const Value.absent(),
    this.phaseType = const Value.absent(),
    this.durationWeeks = const Value.absent(),
    this.targetWeeklyVolume = const Value.absent(),
    this.targetWeeklyDuration = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PhasesCompanion.insert({
    required String id,
    required int goalId,
    required int phaseNumber,
    required String phaseType,
    required int durationWeeks,
    required String targetWeeklyVolume,
    required String targetWeeklyDuration,
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        goalId = Value(goalId),
        phaseNumber = Value(phaseNumber),
        phaseType = Value(phaseType),
        durationWeeks = Value(durationWeeks),
        targetWeeklyVolume = Value(targetWeeklyVolume),
        targetWeeklyDuration = Value(targetWeeklyDuration);
  static Insertable<PhaseDTO> custom({
    Expression<String>? id,
    Expression<int>? goalId,
    Expression<int>? phaseNumber,
    Expression<String>? phaseType,
    Expression<int>? durationWeeks,
    Expression<String>? targetWeeklyVolume,
    Expression<String>? targetWeeklyDuration,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<String>? description,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (goalId != null) 'goal_id': goalId,
      if (phaseNumber != null) 'phase_number': phaseNumber,
      if (phaseType != null) 'phase_type': phaseType,
      if (durationWeeks != null) 'duration_weeks': durationWeeks,
      if (targetWeeklyVolume != null)
        'target_weekly_volume': targetWeeklyVolume,
      if (targetWeeklyDuration != null)
        'target_weekly_duration': targetWeeklyDuration,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (description != null) 'description': description,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PhasesCompanion copyWith(
      {Value<String>? id,
      Value<int>? goalId,
      Value<int>? phaseNumber,
      Value<String>? phaseType,
      Value<int>? durationWeeks,
      Value<String>? targetWeeklyVolume,
      Value<String>? targetWeeklyDuration,
      Value<DateTime?>? startDate,
      Value<DateTime?>? endDate,
      Value<String?>? description,
      Value<int>? rowid}) {
    return PhasesCompanion(
      id: id ?? this.id,
      goalId: goalId ?? this.goalId,
      phaseNumber: phaseNumber ?? this.phaseNumber,
      phaseType: phaseType ?? this.phaseType,
      durationWeeks: durationWeeks ?? this.durationWeeks,
      targetWeeklyVolume: targetWeeklyVolume ?? this.targetWeeklyVolume,
      targetWeeklyDuration: targetWeeklyDuration ?? this.targetWeeklyDuration,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      description: description ?? this.description,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (goalId.present) {
      map['goal_id'] = Variable<int>(goalId.value);
    }
    if (phaseNumber.present) {
      map['phase_number'] = Variable<int>(phaseNumber.value);
    }
    if (phaseType.present) {
      map['phase_type'] = Variable<String>(phaseType.value);
    }
    if (durationWeeks.present) {
      map['duration_weeks'] = Variable<int>(durationWeeks.value);
    }
    if (targetWeeklyVolume.present) {
      map['target_weekly_volume'] = Variable<String>(targetWeeklyVolume.value);
    }
    if (targetWeeklyDuration.present) {
      map['target_weekly_duration'] =
          Variable<String>(targetWeeklyDuration.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PhasesCompanion(')
          ..write('id: $id, ')
          ..write('goalId: $goalId, ')
          ..write('phaseNumber: $phaseNumber, ')
          ..write('phaseType: $phaseType, ')
          ..write('durationWeeks: $durationWeeks, ')
          ..write('targetWeeklyVolume: $targetWeeklyVolume, ')
          ..write('targetWeeklyDuration: $targetWeeklyDuration, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('description: $description, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TrainingBlocksTable extends TrainingBlocks
    with TableInfo<$TrainingBlocksTable, TrainingBlockDTO> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrainingBlocksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _phaseIdMeta =
      const VerificationMeta('phaseId');
  @override
  late final GeneratedColumn<String> phaseId = GeneratedColumn<String>(
      'phase_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _blockNumberMeta =
      const VerificationMeta('blockNumber');
  @override
  late final GeneratedColumn<int> blockNumber = GeneratedColumn<int>(
      'block_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _intentMeta = const VerificationMeta('intent');
  @override
  late final GeneratedColumn<String> intent = GeneratedColumn<String>(
      'intent', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _durationDaysMeta =
      const VerificationMeta('durationDays');
  @override
  late final GeneratedColumn<int> durationDays = GeneratedColumn<int>(
      'duration_days', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'start_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
      'end_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, phaseId, blockNumber, intent, durationDays, startDate, endDate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'training_blocks';
  @override
  VerificationContext validateIntegrity(Insertable<TrainingBlockDTO> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('phase_id')) {
      context.handle(_phaseIdMeta,
          phaseId.isAcceptableOrUnknown(data['phase_id']!, _phaseIdMeta));
    } else if (isInserting) {
      context.missing(_phaseIdMeta);
    }
    if (data.containsKey('block_number')) {
      context.handle(
          _blockNumberMeta,
          blockNumber.isAcceptableOrUnknown(
              data['block_number']!, _blockNumberMeta));
    } else if (isInserting) {
      context.missing(_blockNumberMeta);
    }
    if (data.containsKey('intent')) {
      context.handle(_intentMeta,
          intent.isAcceptableOrUnknown(data['intent']!, _intentMeta));
    } else if (isInserting) {
      context.missing(_intentMeta);
    }
    if (data.containsKey('duration_days')) {
      context.handle(
          _durationDaysMeta,
          durationDays.isAcceptableOrUnknown(
              data['duration_days']!, _durationDaysMeta));
    } else if (isInserting) {
      context.missing(_durationDaysMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TrainingBlockDTO map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TrainingBlockDTO(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      phaseId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phase_id'])!,
      blockNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}block_number'])!,
      intent: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}intent'])!,
      durationDays: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_days'])!,
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date']),
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_date']),
    );
  }

  @override
  $TrainingBlocksTable createAlias(String alias) {
    return $TrainingBlocksTable(attachedDatabase, alias);
  }
}

class TrainingBlockDTO extends DataClass
    implements Insertable<TrainingBlockDTO> {
  final String id;
  final String phaseId;
  final int blockNumber;
  final String intent;
  final int durationDays;
  final DateTime? startDate;
  final DateTime? endDate;
  const TrainingBlockDTO(
      {required this.id,
      required this.phaseId,
      required this.blockNumber,
      required this.intent,
      required this.durationDays,
      this.startDate,
      this.endDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['phase_id'] = Variable<String>(phaseId);
    map['block_number'] = Variable<int>(blockNumber);
    map['intent'] = Variable<String>(intent);
    map['duration_days'] = Variable<int>(durationDays);
    if (!nullToAbsent || startDate != null) {
      map['start_date'] = Variable<DateTime>(startDate);
    }
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    return map;
  }

  TrainingBlocksCompanion toCompanion(bool nullToAbsent) {
    return TrainingBlocksCompanion(
      id: Value(id),
      phaseId: Value(phaseId),
      blockNumber: Value(blockNumber),
      intent: Value(intent),
      durationDays: Value(durationDays),
      startDate: startDate == null && nullToAbsent
          ? const Value.absent()
          : Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
    );
  }

  factory TrainingBlockDTO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TrainingBlockDTO(
      id: serializer.fromJson<String>(json['id']),
      phaseId: serializer.fromJson<String>(json['phaseId']),
      blockNumber: serializer.fromJson<int>(json['blockNumber']),
      intent: serializer.fromJson<String>(json['intent']),
      durationDays: serializer.fromJson<int>(json['durationDays']),
      startDate: serializer.fromJson<DateTime?>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'phaseId': serializer.toJson<String>(phaseId),
      'blockNumber': serializer.toJson<int>(blockNumber),
      'intent': serializer.toJson<String>(intent),
      'durationDays': serializer.toJson<int>(durationDays),
      'startDate': serializer.toJson<DateTime?>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
    };
  }

  TrainingBlockDTO copyWith(
          {String? id,
          String? phaseId,
          int? blockNumber,
          String? intent,
          int? durationDays,
          Value<DateTime?> startDate = const Value.absent(),
          Value<DateTime?> endDate = const Value.absent()}) =>
      TrainingBlockDTO(
        id: id ?? this.id,
        phaseId: phaseId ?? this.phaseId,
        blockNumber: blockNumber ?? this.blockNumber,
        intent: intent ?? this.intent,
        durationDays: durationDays ?? this.durationDays,
        startDate: startDate.present ? startDate.value : this.startDate,
        endDate: endDate.present ? endDate.value : this.endDate,
      );
  TrainingBlockDTO copyWithCompanion(TrainingBlocksCompanion data) {
    return TrainingBlockDTO(
      id: data.id.present ? data.id.value : this.id,
      phaseId: data.phaseId.present ? data.phaseId.value : this.phaseId,
      blockNumber:
          data.blockNumber.present ? data.blockNumber.value : this.blockNumber,
      intent: data.intent.present ? data.intent.value : this.intent,
      durationDays: data.durationDays.present
          ? data.durationDays.value
          : this.durationDays,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TrainingBlockDTO(')
          ..write('id: $id, ')
          ..write('phaseId: $phaseId, ')
          ..write('blockNumber: $blockNumber, ')
          ..write('intent: $intent, ')
          ..write('durationDays: $durationDays, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, phaseId, blockNumber, intent, durationDays, startDate, endDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TrainingBlockDTO &&
          other.id == this.id &&
          other.phaseId == this.phaseId &&
          other.blockNumber == this.blockNumber &&
          other.intent == this.intent &&
          other.durationDays == this.durationDays &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate);
}

class TrainingBlocksCompanion extends UpdateCompanion<TrainingBlockDTO> {
  final Value<String> id;
  final Value<String> phaseId;
  final Value<int> blockNumber;
  final Value<String> intent;
  final Value<int> durationDays;
  final Value<DateTime?> startDate;
  final Value<DateTime?> endDate;
  final Value<int> rowid;
  const TrainingBlocksCompanion({
    this.id = const Value.absent(),
    this.phaseId = const Value.absent(),
    this.blockNumber = const Value.absent(),
    this.intent = const Value.absent(),
    this.durationDays = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TrainingBlocksCompanion.insert({
    required String id,
    required String phaseId,
    required int blockNumber,
    required String intent,
    required int durationDays,
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        phaseId = Value(phaseId),
        blockNumber = Value(blockNumber),
        intent = Value(intent),
        durationDays = Value(durationDays);
  static Insertable<TrainingBlockDTO> custom({
    Expression<String>? id,
    Expression<String>? phaseId,
    Expression<int>? blockNumber,
    Expression<String>? intent,
    Expression<int>? durationDays,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (phaseId != null) 'phase_id': phaseId,
      if (blockNumber != null) 'block_number': blockNumber,
      if (intent != null) 'intent': intent,
      if (durationDays != null) 'duration_days': durationDays,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TrainingBlocksCompanion copyWith(
      {Value<String>? id,
      Value<String>? phaseId,
      Value<int>? blockNumber,
      Value<String>? intent,
      Value<int>? durationDays,
      Value<DateTime?>? startDate,
      Value<DateTime?>? endDate,
      Value<int>? rowid}) {
    return TrainingBlocksCompanion(
      id: id ?? this.id,
      phaseId: phaseId ?? this.phaseId,
      blockNumber: blockNumber ?? this.blockNumber,
      intent: intent ?? this.intent,
      durationDays: durationDays ?? this.durationDays,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (phaseId.present) {
      map['phase_id'] = Variable<String>(phaseId.value);
    }
    if (blockNumber.present) {
      map['block_number'] = Variable<int>(blockNumber.value);
    }
    if (intent.present) {
      map['intent'] = Variable<String>(intent.value);
    }
    if (durationDays.present) {
      map['duration_days'] = Variable<int>(durationDays.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrainingBlocksCompanion(')
          ..write('id: $id, ')
          ..write('phaseId: $phaseId, ')
          ..write('blockNumber: $blockNumber, ')
          ..write('intent: $intent, ')
          ..write('durationDays: $durationDays, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $GoalsTable goals = $GoalsTable(this);
  late final $ConversationsTable conversations = $ConversationsTable(this);
  late final $ConversationMessagesTable conversationMessages =
      $ConversationMessagesTable(this);
  late final $LongTermContextTable longTermContext =
      $LongTermContextTable(this);
  late final $MediumTermContextTable mediumTermContext =
      $MediumTermContextTable(this);
  late final $WorkoutsTable workouts = $WorkoutsTable(this);
  late final $PhasesTable phases = $PhasesTable(this);
  late final $TrainingBlocksTable trainingBlocks = $TrainingBlocksTable(this);
  late final UserDao userDao = UserDao(this as AppDatabase);
  late final GoalDao goalDao = GoalDao(this as AppDatabase);
  late final ConversationDao conversationDao =
      ConversationDao(this as AppDatabase);
  late final ContextDao contextDao = ContextDao(this as AppDatabase);
  late final WorkoutDao workoutDao = WorkoutDao(this as AppDatabase);
  late final TrainingPlanDao trainingPlanDao =
      TrainingPlanDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        users,
        goals,
        conversations,
        conversationMessages,
        longTermContext,
        mediumTermContext,
        workouts,
        phases,
        trainingBlocks
      ];
}

typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  Value<int?> age,
  Value<String?> gender,
  Value<double?> weight,
  Value<String> preferredWeightUnit,
  Value<double?> height,
  Value<String> preferredHeightUnit,
  required String availableDays,
  Value<String?> constraints,
  Value<bool> healthPermissionsGranted,
  required DateTime createdAt,
  required DateTime updatedAt,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  Value<int?> age,
  Value<String?> gender,
  Value<double?> weight,
  Value<String> preferredWeightUnit,
  Value<double?> height,
  Value<String> preferredHeightUnit,
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

  static MultiTypedResultKey<$ConversationsTable, List<ConversationDTO>>
      _conversationsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.conversations,
              aliasName:
                  $_aliasNameGenerator(db.users.id, db.conversations.userId));

  $$ConversationsTableProcessedTableManager get conversationsRefs {
    final manager = $$ConversationsTableTableManager($_db, $_db.conversations)
        .filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_conversationsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$LongTermContextTable, List<LongTermContextDTO>>
      _longTermContextRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.longTermContext,
              aliasName:
                  $_aliasNameGenerator(db.users.id, db.longTermContext.userId));

  $$LongTermContextTableProcessedTableManager get longTermContextRefs {
    final manager =
        $$LongTermContextTableTableManager($_db, $_db.longTermContext)
            .filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_longTermContextRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$MediumTermContextTable,
      List<MediumTermContextDTO>> _mediumTermContextRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.mediumTermContext,
          aliasName:
              $_aliasNameGenerator(db.users.id, db.mediumTermContext.userId));

  $$MediumTermContextTableProcessedTableManager get mediumTermContextRefs {
    final manager =
        $$MediumTermContextTableTableManager($_db, $_db.mediumTermContext)
            .filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_mediumTermContextRefsTable($_db));
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

  ColumnFilters<int> get age => $composableBuilder(
      column: $table.age, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get preferredWeightUnit => $composableBuilder(
      column: $table.preferredWeightUnit,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get height => $composableBuilder(
      column: $table.height, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get preferredHeightUnit => $composableBuilder(
      column: $table.preferredHeightUnit,
      builder: (column) => ColumnFilters(column));

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

  Expression<bool> conversationsRefs(
      Expression<bool> Function($$ConversationsTableFilterComposer f) f) {
    final $$ConversationsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.conversations,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ConversationsTableFilterComposer(
              $db: $db,
              $table: $db.conversations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> longTermContextRefs(
      Expression<bool> Function($$LongTermContextTableFilterComposer f) f) {
    final $$LongTermContextTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.longTermContext,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LongTermContextTableFilterComposer(
              $db: $db,
              $table: $db.longTermContext,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> mediumTermContextRefs(
      Expression<bool> Function($$MediumTermContextTableFilterComposer f) f) {
    final $$MediumTermContextTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.mediumTermContext,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MediumTermContextTableFilterComposer(
              $db: $db,
              $table: $db.mediumTermContext,
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

  ColumnOrderings<int> get age => $composableBuilder(
      column: $table.age, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get preferredWeightUnit => $composableBuilder(
      column: $table.preferredWeightUnit,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get height => $composableBuilder(
      column: $table.height, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get preferredHeightUnit => $composableBuilder(
      column: $table.preferredHeightUnit,
      builder: (column) => ColumnOrderings(column));

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

  GeneratedColumn<int> get age =>
      $composableBuilder(column: $table.age, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<String> get preferredWeightUnit => $composableBuilder(
      column: $table.preferredWeightUnit, builder: (column) => column);

  GeneratedColumn<double> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<String> get preferredHeightUnit => $composableBuilder(
      column: $table.preferredHeightUnit, builder: (column) => column);

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

  Expression<T> conversationsRefs<T extends Object>(
      Expression<T> Function($$ConversationsTableAnnotationComposer a) f) {
    final $$ConversationsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.conversations,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ConversationsTableAnnotationComposer(
              $db: $db,
              $table: $db.conversations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> longTermContextRefs<T extends Object>(
      Expression<T> Function($$LongTermContextTableAnnotationComposer a) f) {
    final $$LongTermContextTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.longTermContext,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LongTermContextTableAnnotationComposer(
              $db: $db,
              $table: $db.longTermContext,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> mediumTermContextRefs<T extends Object>(
      Expression<T> Function($$MediumTermContextTableAnnotationComposer a) f) {
    final $$MediumTermContextTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.mediumTermContext,
            getReferencedColumn: (t) => t.userId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$MediumTermContextTableAnnotationComposer(
                  $db: $db,
                  $table: $db.mediumTermContext,
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
    PrefetchHooks Function(
        {bool goalsRefs,
        bool conversationsRefs,
        bool longTermContextRefs,
        bool mediumTermContextRefs})> {
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
            Value<int?> age = const Value.absent(),
            Value<String?> gender = const Value.absent(),
            Value<double?> weight = const Value.absent(),
            Value<String> preferredWeightUnit = const Value.absent(),
            Value<double?> height = const Value.absent(),
            Value<String> preferredHeightUnit = const Value.absent(),
            Value<String> availableDays = const Value.absent(),
            Value<String?> constraints = const Value.absent(),
            Value<bool> healthPermissionsGranted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              UsersCompanion(
            id: id,
            age: age,
            gender: gender,
            weight: weight,
            preferredWeightUnit: preferredWeightUnit,
            height: height,
            preferredHeightUnit: preferredHeightUnit,
            availableDays: availableDays,
            constraints: constraints,
            healthPermissionsGranted: healthPermissionsGranted,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> age = const Value.absent(),
            Value<String?> gender = const Value.absent(),
            Value<double?> weight = const Value.absent(),
            Value<String> preferredWeightUnit = const Value.absent(),
            Value<double?> height = const Value.absent(),
            Value<String> preferredHeightUnit = const Value.absent(),
            required String availableDays,
            Value<String?> constraints = const Value.absent(),
            Value<bool> healthPermissionsGranted = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
          }) =>
              UsersCompanion.insert(
            id: id,
            age: age,
            gender: gender,
            weight: weight,
            preferredWeightUnit: preferredWeightUnit,
            height: height,
            preferredHeightUnit: preferredHeightUnit,
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
          prefetchHooksCallback: (
              {goalsRefs = false,
              conversationsRefs = false,
              longTermContextRefs = false,
              mediumTermContextRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (goalsRefs) db.goals,
                if (conversationsRefs) db.conversations,
                if (longTermContextRefs) db.longTermContext,
                if (mediumTermContextRefs) db.mediumTermContext
              ],
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
                        typedResults: items),
                  if (conversationsRefs)
                    await $_getPrefetchedData<UserDTO, $UsersTable,
                            ConversationDTO>(
                        currentTable: table,
                        referencedTable:
                            $$UsersTableReferences._conversationsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0)
                                .conversationsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.userId == item.id),
                        typedResults: items),
                  if (longTermContextRefs)
                    await $_getPrefetchedData<UserDTO, $UsersTable,
                            LongTermContextDTO>(
                        currentTable: table,
                        referencedTable: $$UsersTableReferences
                            ._longTermContextRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0)
                                .longTermContextRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.userId == item.id),
                        typedResults: items),
                  if (mediumTermContextRefs)
                    await $_getPrefetchedData<UserDTO, $UsersTable,
                            MediumTermContextDTO>(
                        currentTable: table,
                        referencedTable: $$UsersTableReferences
                            ._mediumTermContextRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0)
                                .mediumTermContextRefs,
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
    PrefetchHooks Function(
        {bool goalsRefs,
        bool conversationsRefs,
        bool longTermContextRefs,
        bool mediumTermContextRefs})>;
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

  static MultiTypedResultKey<$LongTermContextTable, List<LongTermContextDTO>>
      _longTermContextRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.longTermContext,
              aliasName:
                  $_aliasNameGenerator(db.goals.id, db.longTermContext.goalId));

  $$LongTermContextTableProcessedTableManager get longTermContextRefs {
    final manager =
        $$LongTermContextTableTableManager($_db, $_db.longTermContext)
            .filter((f) => f.goalId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_longTermContextRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
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

  Expression<bool> longTermContextRefs(
      Expression<bool> Function($$LongTermContextTableFilterComposer f) f) {
    final $$LongTermContextTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.longTermContext,
        getReferencedColumn: (t) => t.goalId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LongTermContextTableFilterComposer(
              $db: $db,
              $table: $db.longTermContext,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
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

  Expression<T> longTermContextRefs<T extends Object>(
      Expression<T> Function($$LongTermContextTableAnnotationComposer a) f) {
    final $$LongTermContextTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.longTermContext,
        getReferencedColumn: (t) => t.goalId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LongTermContextTableAnnotationComposer(
              $db: $db,
              $table: $db.longTermContext,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
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
    PrefetchHooks Function({bool userId, bool longTermContextRefs})> {
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
          prefetchHooksCallback: (
              {userId = false, longTermContextRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (longTermContextRefs) db.longTermContext
              ],
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
                return [
                  if (longTermContextRefs)
                    await $_getPrefetchedData<GoalDTO, $GoalsTable,
                            LongTermContextDTO>(
                        currentTable: table,
                        referencedTable: $$GoalsTableReferences
                            ._longTermContextRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$GoalsTableReferences(db, table, p0)
                                .longTermContextRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.goalId == item.id),
                        typedResults: items)
                ];
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
    PrefetchHooks Function({bool userId, bool longTermContextRefs})>;
typedef $$ConversationsTableCreateCompanionBuilder = ConversationsCompanion
    Function({
  required String id,
  required int userId,
  required DateTime startedAt,
  Value<DateTime?> endedAt,
  Value<int> messageCount,
  Value<int> rowid,
});
typedef $$ConversationsTableUpdateCompanionBuilder = ConversationsCompanion
    Function({
  Value<String> id,
  Value<int> userId,
  Value<DateTime> startedAt,
  Value<DateTime?> endedAt,
  Value<int> messageCount,
  Value<int> rowid,
});

final class $$ConversationsTableReferences extends BaseReferences<_$AppDatabase,
    $ConversationsTable, ConversationDTO> {
  $$ConversationsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) => db.users
      .createAlias($_aliasNameGenerator(db.conversations.userId, db.users.id));

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$ConversationMessagesTable,
      List<ConversationMessageDTO>> _conversationMessagesRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.conversationMessages,
          aliasName: $_aliasNameGenerator(
              db.conversations.id, db.conversationMessages.conversationId));

  $$ConversationMessagesTableProcessedTableManager
      get conversationMessagesRefs {
    final manager = $$ConversationMessagesTableTableManager(
            $_db, $_db.conversationMessages)
        .filter(
            (f) => f.conversationId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_conversationMessagesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ConversationsTableFilterComposer
    extends Composer<_$AppDatabase, $ConversationsTable> {
  $$ConversationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
      column: $table.startedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
      column: $table.endedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get messageCount => $composableBuilder(
      column: $table.messageCount, builder: (column) => ColumnFilters(column));

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

  Expression<bool> conversationMessagesRefs(
      Expression<bool> Function($$ConversationMessagesTableFilterComposer f)
          f) {
    final $$ConversationMessagesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.conversationMessages,
        getReferencedColumn: (t) => t.conversationId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ConversationMessagesTableFilterComposer(
              $db: $db,
              $table: $db.conversationMessages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ConversationsTableOrderingComposer
    extends Composer<_$AppDatabase, $ConversationsTable> {
  $$ConversationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
      column: $table.startedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
      column: $table.endedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get messageCount => $composableBuilder(
      column: $table.messageCount,
      builder: (column) => ColumnOrderings(column));

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

class $$ConversationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ConversationsTable> {
  $$ConversationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumn<int> get messageCount => $composableBuilder(
      column: $table.messageCount, builder: (column) => column);

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

  Expression<T> conversationMessagesRefs<T extends Object>(
      Expression<T> Function($$ConversationMessagesTableAnnotationComposer a)
          f) {
    final $$ConversationMessagesTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.conversationMessages,
            getReferencedColumn: (t) => t.conversationId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$ConversationMessagesTableAnnotationComposer(
                  $db: $db,
                  $table: $db.conversationMessages,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$ConversationsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ConversationsTable,
    ConversationDTO,
    $$ConversationsTableFilterComposer,
    $$ConversationsTableOrderingComposer,
    $$ConversationsTableAnnotationComposer,
    $$ConversationsTableCreateCompanionBuilder,
    $$ConversationsTableUpdateCompanionBuilder,
    (ConversationDTO, $$ConversationsTableReferences),
    ConversationDTO,
    PrefetchHooks Function({bool userId, bool conversationMessagesRefs})> {
  $$ConversationsTableTableManager(_$AppDatabase db, $ConversationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ConversationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ConversationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ConversationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<int> userId = const Value.absent(),
            Value<DateTime> startedAt = const Value.absent(),
            Value<DateTime?> endedAt = const Value.absent(),
            Value<int> messageCount = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ConversationsCompanion(
            id: id,
            userId: userId,
            startedAt: startedAt,
            endedAt: endedAt,
            messageCount: messageCount,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required int userId,
            required DateTime startedAt,
            Value<DateTime?> endedAt = const Value.absent(),
            Value<int> messageCount = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ConversationsCompanion.insert(
            id: id,
            userId: userId,
            startedAt: startedAt,
            endedAt: endedAt,
            messageCount: messageCount,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ConversationsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {userId = false, conversationMessagesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (conversationMessagesRefs) db.conversationMessages
              ],
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
                    referencedTable:
                        $$ConversationsTableReferences._userIdTable(db),
                    referencedColumn:
                        $$ConversationsTableReferences._userIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (conversationMessagesRefs)
                    await $_getPrefetchedData<ConversationDTO,
                            $ConversationsTable, ConversationMessageDTO>(
                        currentTable: table,
                        referencedTable: $$ConversationsTableReferences
                            ._conversationMessagesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ConversationsTableReferences(db, table, p0)
                                .conversationMessagesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.conversationId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ConversationsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ConversationsTable,
    ConversationDTO,
    $$ConversationsTableFilterComposer,
    $$ConversationsTableOrderingComposer,
    $$ConversationsTableAnnotationComposer,
    $$ConversationsTableCreateCompanionBuilder,
    $$ConversationsTableUpdateCompanionBuilder,
    (ConversationDTO, $$ConversationsTableReferences),
    ConversationDTO,
    PrefetchHooks Function({bool userId, bool conversationMessagesRefs})>;
typedef $$ConversationMessagesTableCreateCompanionBuilder
    = ConversationMessagesCompanion Function({
  required String id,
  required String conversationId,
  required String role,
  required String content,
  required DateTime timestamp,
  Value<String?> functionCallName,
  Value<String?> functionCallArguments,
  Value<int> rowid,
});
typedef $$ConversationMessagesTableUpdateCompanionBuilder
    = ConversationMessagesCompanion Function({
  Value<String> id,
  Value<String> conversationId,
  Value<String> role,
  Value<String> content,
  Value<DateTime> timestamp,
  Value<String?> functionCallName,
  Value<String?> functionCallArguments,
  Value<int> rowid,
});

final class $$ConversationMessagesTableReferences extends BaseReferences<
    _$AppDatabase, $ConversationMessagesTable, ConversationMessageDTO> {
  $$ConversationMessagesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $ConversationsTable _conversationIdTable(_$AppDatabase db) =>
      db.conversations.createAlias($_aliasNameGenerator(
          db.conversationMessages.conversationId, db.conversations.id));

  $$ConversationsTableProcessedTableManager get conversationId {
    final $_column = $_itemColumn<String>('conversation_id')!;

    final manager = $$ConversationsTableTableManager($_db, $_db.conversations)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_conversationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ConversationMessagesTableFilterComposer
    extends Composer<_$AppDatabase, $ConversationMessagesTable> {
  $$ConversationMessagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get functionCallName => $composableBuilder(
      column: $table.functionCallName,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get functionCallArguments => $composableBuilder(
      column: $table.functionCallArguments,
      builder: (column) => ColumnFilters(column));

  $$ConversationsTableFilterComposer get conversationId {
    final $$ConversationsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.conversationId,
        referencedTable: $db.conversations,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ConversationsTableFilterComposer(
              $db: $db,
              $table: $db.conversations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ConversationMessagesTableOrderingComposer
    extends Composer<_$AppDatabase, $ConversationMessagesTable> {
  $$ConversationMessagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get functionCallName => $composableBuilder(
      column: $table.functionCallName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get functionCallArguments => $composableBuilder(
      column: $table.functionCallArguments,
      builder: (column) => ColumnOrderings(column));

  $$ConversationsTableOrderingComposer get conversationId {
    final $$ConversationsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.conversationId,
        referencedTable: $db.conversations,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ConversationsTableOrderingComposer(
              $db: $db,
              $table: $db.conversations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ConversationMessagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ConversationMessagesTable> {
  $$ConversationMessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get functionCallName => $composableBuilder(
      column: $table.functionCallName, builder: (column) => column);

  GeneratedColumn<String> get functionCallArguments => $composableBuilder(
      column: $table.functionCallArguments, builder: (column) => column);

  $$ConversationsTableAnnotationComposer get conversationId {
    final $$ConversationsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.conversationId,
        referencedTable: $db.conversations,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ConversationsTableAnnotationComposer(
              $db: $db,
              $table: $db.conversations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ConversationMessagesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ConversationMessagesTable,
    ConversationMessageDTO,
    $$ConversationMessagesTableFilterComposer,
    $$ConversationMessagesTableOrderingComposer,
    $$ConversationMessagesTableAnnotationComposer,
    $$ConversationMessagesTableCreateCompanionBuilder,
    $$ConversationMessagesTableUpdateCompanionBuilder,
    (ConversationMessageDTO, $$ConversationMessagesTableReferences),
    ConversationMessageDTO,
    PrefetchHooks Function({bool conversationId})> {
  $$ConversationMessagesTableTableManager(
      _$AppDatabase db, $ConversationMessagesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ConversationMessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ConversationMessagesTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ConversationMessagesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> conversationId = const Value.absent(),
            Value<String> role = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<DateTime> timestamp = const Value.absent(),
            Value<String?> functionCallName = const Value.absent(),
            Value<String?> functionCallArguments = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ConversationMessagesCompanion(
            id: id,
            conversationId: conversationId,
            role: role,
            content: content,
            timestamp: timestamp,
            functionCallName: functionCallName,
            functionCallArguments: functionCallArguments,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String conversationId,
            required String role,
            required String content,
            required DateTime timestamp,
            Value<String?> functionCallName = const Value.absent(),
            Value<String?> functionCallArguments = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ConversationMessagesCompanion.insert(
            id: id,
            conversationId: conversationId,
            role: role,
            content: content,
            timestamp: timestamp,
            functionCallName: functionCallName,
            functionCallArguments: functionCallArguments,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ConversationMessagesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({conversationId = false}) {
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
                if (conversationId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.conversationId,
                    referencedTable: $$ConversationMessagesTableReferences
                        ._conversationIdTable(db),
                    referencedColumn: $$ConversationMessagesTableReferences
                        ._conversationIdTable(db)
                        .id,
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

typedef $$ConversationMessagesTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $ConversationMessagesTable,
        ConversationMessageDTO,
        $$ConversationMessagesTableFilterComposer,
        $$ConversationMessagesTableOrderingComposer,
        $$ConversationMessagesTableAnnotationComposer,
        $$ConversationMessagesTableCreateCompanionBuilder,
        $$ConversationMessagesTableUpdateCompanionBuilder,
        (ConversationMessageDTO, $$ConversationMessagesTableReferences),
        ConversationMessageDTO,
        PrefetchHooks Function({bool conversationId})>;
typedef $$LongTermContextTableCreateCompanionBuilder = LongTermContextCompanion
    Function({
  required String id,
  required int userId,
  required int goalId,
  required String contextJson,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$LongTermContextTableUpdateCompanionBuilder = LongTermContextCompanion
    Function({
  Value<String> id,
  Value<int> userId,
  Value<int> goalId,
  Value<String> contextJson,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$LongTermContextTableReferences extends BaseReferences<
    _$AppDatabase, $LongTermContextTable, LongTermContextDTO> {
  $$LongTermContextTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) => db.users.createAlias(
      $_aliasNameGenerator(db.longTermContext.userId, db.users.id));

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $GoalsTable _goalIdTable(_$AppDatabase db) => db.goals.createAlias(
      $_aliasNameGenerator(db.longTermContext.goalId, db.goals.id));

  $$GoalsTableProcessedTableManager get goalId {
    final $_column = $_itemColumn<int>('goal_id')!;

    final manager = $$GoalsTableTableManager($_db, $_db.goals)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_goalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$LongTermContextTableFilterComposer
    extends Composer<_$AppDatabase, $LongTermContextTable> {
  $$LongTermContextTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contextJson => $composableBuilder(
      column: $table.contextJson, builder: (column) => ColumnFilters(column));

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

  $$GoalsTableFilterComposer get goalId {
    final $$GoalsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.goalId,
        referencedTable: $db.goals,
        getReferencedColumn: (t) => t.id,
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
    return composer;
  }
}

class $$LongTermContextTableOrderingComposer
    extends Composer<_$AppDatabase, $LongTermContextTable> {
  $$LongTermContextTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contextJson => $composableBuilder(
      column: $table.contextJson, builder: (column) => ColumnOrderings(column));

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

  $$GoalsTableOrderingComposer get goalId {
    final $$GoalsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.goalId,
        referencedTable: $db.goals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoalsTableOrderingComposer(
              $db: $db,
              $table: $db.goals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LongTermContextTableAnnotationComposer
    extends Composer<_$AppDatabase, $LongTermContextTable> {
  $$LongTermContextTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get contextJson => $composableBuilder(
      column: $table.contextJson, builder: (column) => column);

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

  $$GoalsTableAnnotationComposer get goalId {
    final $$GoalsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.goalId,
        referencedTable: $db.goals,
        getReferencedColumn: (t) => t.id,
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
    return composer;
  }
}

class $$LongTermContextTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LongTermContextTable,
    LongTermContextDTO,
    $$LongTermContextTableFilterComposer,
    $$LongTermContextTableOrderingComposer,
    $$LongTermContextTableAnnotationComposer,
    $$LongTermContextTableCreateCompanionBuilder,
    $$LongTermContextTableUpdateCompanionBuilder,
    (LongTermContextDTO, $$LongTermContextTableReferences),
    LongTermContextDTO,
    PrefetchHooks Function({bool userId, bool goalId})> {
  $$LongTermContextTableTableManager(
      _$AppDatabase db, $LongTermContextTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LongTermContextTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LongTermContextTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LongTermContextTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<int> userId = const Value.absent(),
            Value<int> goalId = const Value.absent(),
            Value<String> contextJson = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LongTermContextCompanion(
            id: id,
            userId: userId,
            goalId: goalId,
            contextJson: contextJson,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required int userId,
            required int goalId,
            required String contextJson,
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              LongTermContextCompanion.insert(
            id: id,
            userId: userId,
            goalId: goalId,
            contextJson: contextJson,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$LongTermContextTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({userId = false, goalId = false}) {
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
                    referencedTable:
                        $$LongTermContextTableReferences._userIdTable(db),
                    referencedColumn:
                        $$LongTermContextTableReferences._userIdTable(db).id,
                  ) as T;
                }
                if (goalId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.goalId,
                    referencedTable:
                        $$LongTermContextTableReferences._goalIdTable(db),
                    referencedColumn:
                        $$LongTermContextTableReferences._goalIdTable(db).id,
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

typedef $$LongTermContextTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LongTermContextTable,
    LongTermContextDTO,
    $$LongTermContextTableFilterComposer,
    $$LongTermContextTableOrderingComposer,
    $$LongTermContextTableAnnotationComposer,
    $$LongTermContextTableCreateCompanionBuilder,
    $$LongTermContextTableUpdateCompanionBuilder,
    (LongTermContextDTO, $$LongTermContextTableReferences),
    LongTermContextDTO,
    PrefetchHooks Function({bool userId, bool goalId})>;
typedef $$MediumTermContextTableCreateCompanionBuilder
    = MediumTermContextCompanion Function({
  required String id,
  required int userId,
  required DateTime periodStart,
  required DateTime periodEnd,
  required String contextJson,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$MediumTermContextTableUpdateCompanionBuilder
    = MediumTermContextCompanion Function({
  Value<String> id,
  Value<int> userId,
  Value<DateTime> periodStart,
  Value<DateTime> periodEnd,
  Value<String> contextJson,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$MediumTermContextTableReferences extends BaseReferences<
    _$AppDatabase, $MediumTermContextTable, MediumTermContextDTO> {
  $$MediumTermContextTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) => db.users.createAlias(
      $_aliasNameGenerator(db.mediumTermContext.userId, db.users.id));

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

class $$MediumTermContextTableFilterComposer
    extends Composer<_$AppDatabase, $MediumTermContextTable> {
  $$MediumTermContextTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get periodStart => $composableBuilder(
      column: $table.periodStart, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get periodEnd => $composableBuilder(
      column: $table.periodEnd, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contextJson => $composableBuilder(
      column: $table.contextJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

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

class $$MediumTermContextTableOrderingComposer
    extends Composer<_$AppDatabase, $MediumTermContextTable> {
  $$MediumTermContextTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get periodStart => $composableBuilder(
      column: $table.periodStart, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get periodEnd => $composableBuilder(
      column: $table.periodEnd, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contextJson => $composableBuilder(
      column: $table.contextJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

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

class $$MediumTermContextTableAnnotationComposer
    extends Composer<_$AppDatabase, $MediumTermContextTable> {
  $$MediumTermContextTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get periodStart => $composableBuilder(
      column: $table.periodStart, builder: (column) => column);

  GeneratedColumn<DateTime> get periodEnd =>
      $composableBuilder(column: $table.periodEnd, builder: (column) => column);

  GeneratedColumn<String> get contextJson => $composableBuilder(
      column: $table.contextJson, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

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

class $$MediumTermContextTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MediumTermContextTable,
    MediumTermContextDTO,
    $$MediumTermContextTableFilterComposer,
    $$MediumTermContextTableOrderingComposer,
    $$MediumTermContextTableAnnotationComposer,
    $$MediumTermContextTableCreateCompanionBuilder,
    $$MediumTermContextTableUpdateCompanionBuilder,
    (MediumTermContextDTO, $$MediumTermContextTableReferences),
    MediumTermContextDTO,
    PrefetchHooks Function({bool userId})> {
  $$MediumTermContextTableTableManager(
      _$AppDatabase db, $MediumTermContextTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MediumTermContextTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MediumTermContextTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MediumTermContextTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<int> userId = const Value.absent(),
            Value<DateTime> periodStart = const Value.absent(),
            Value<DateTime> periodEnd = const Value.absent(),
            Value<String> contextJson = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MediumTermContextCompanion(
            id: id,
            userId: userId,
            periodStart: periodStart,
            periodEnd: periodEnd,
            contextJson: contextJson,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required int userId,
            required DateTime periodStart,
            required DateTime periodEnd,
            required String contextJson,
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              MediumTermContextCompanion.insert(
            id: id,
            userId: userId,
            periodStart: periodStart,
            periodEnd: periodEnd,
            contextJson: contextJson,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$MediumTermContextTableReferences(db, table, e)
                  ))
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
                    referencedTable:
                        $$MediumTermContextTableReferences._userIdTable(db),
                    referencedColumn:
                        $$MediumTermContextTableReferences._userIdTable(db).id,
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

typedef $$MediumTermContextTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MediumTermContextTable,
    MediumTermContextDTO,
    $$MediumTermContextTableFilterComposer,
    $$MediumTermContextTableOrderingComposer,
    $$MediumTermContextTableAnnotationComposer,
    $$MediumTermContextTableCreateCompanionBuilder,
    $$MediumTermContextTableUpdateCompanionBuilder,
    (MediumTermContextDTO, $$MediumTermContextTableReferences),
    MediumTermContextDTO,
    PrefetchHooks Function({bool userId})>;
typedef $$WorkoutsTableCreateCompanionBuilder = WorkoutsCompanion Function({
  required String id,
  required int userId,
  required int goalId,
  Value<String?> phaseId,
  Value<String?> blockId,
  required DateTime scheduledDate,
  required String type,
  required String name,
  required int plannedDuration,
  Value<double?> plannedDistance,
  Value<String?> intensity,
  Value<String?> description,
  required String status,
  Value<int?> actualDuration,
  Value<double?> actualDistance,
  Value<double?> actualPace,
  Value<int?> rpe,
  Value<DateTime?> completedAt,
  Value<int> rowid,
});
typedef $$WorkoutsTableUpdateCompanionBuilder = WorkoutsCompanion Function({
  Value<String> id,
  Value<int> userId,
  Value<int> goalId,
  Value<String?> phaseId,
  Value<String?> blockId,
  Value<DateTime> scheduledDate,
  Value<String> type,
  Value<String> name,
  Value<int> plannedDuration,
  Value<double?> plannedDistance,
  Value<String?> intensity,
  Value<String?> description,
  Value<String> status,
  Value<int?> actualDuration,
  Value<double?> actualDistance,
  Value<double?> actualPace,
  Value<int?> rpe,
  Value<DateTime?> completedAt,
  Value<int> rowid,
});

class $$WorkoutsTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutsTable> {
  $$WorkoutsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get goalId => $composableBuilder(
      column: $table.goalId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phaseId => $composableBuilder(
      column: $table.phaseId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get blockId => $composableBuilder(
      column: $table.blockId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get scheduledDate => $composableBuilder(
      column: $table.scheduledDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get plannedDuration => $composableBuilder(
      column: $table.plannedDuration,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get plannedDistance => $composableBuilder(
      column: $table.plannedDistance,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get intensity => $composableBuilder(
      column: $table.intensity, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get actualDuration => $composableBuilder(
      column: $table.actualDuration,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get actualDistance => $composableBuilder(
      column: $table.actualDistance,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get actualPace => $composableBuilder(
      column: $table.actualPace, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get rpe => $composableBuilder(
      column: $table.rpe, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnFilters(column));
}

class $$WorkoutsTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutsTable> {
  $$WorkoutsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get goalId => $composableBuilder(
      column: $table.goalId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phaseId => $composableBuilder(
      column: $table.phaseId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get blockId => $composableBuilder(
      column: $table.blockId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get scheduledDate => $composableBuilder(
      column: $table.scheduledDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get plannedDuration => $composableBuilder(
      column: $table.plannedDuration,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get plannedDistance => $composableBuilder(
      column: $table.plannedDistance,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get intensity => $composableBuilder(
      column: $table.intensity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get actualDuration => $composableBuilder(
      column: $table.actualDuration,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get actualDistance => $composableBuilder(
      column: $table.actualDistance,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get actualPace => $composableBuilder(
      column: $table.actualPace, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get rpe => $composableBuilder(
      column: $table.rpe, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnOrderings(column));
}

class $$WorkoutsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutsTable> {
  $$WorkoutsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<int> get goalId =>
      $composableBuilder(column: $table.goalId, builder: (column) => column);

  GeneratedColumn<String> get phaseId =>
      $composableBuilder(column: $table.phaseId, builder: (column) => column);

  GeneratedColumn<String> get blockId =>
      $composableBuilder(column: $table.blockId, builder: (column) => column);

  GeneratedColumn<DateTime> get scheduledDate => $composableBuilder(
      column: $table.scheduledDate, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get plannedDuration => $composableBuilder(
      column: $table.plannedDuration, builder: (column) => column);

  GeneratedColumn<double> get plannedDistance => $composableBuilder(
      column: $table.plannedDistance, builder: (column) => column);

  GeneratedColumn<String> get intensity =>
      $composableBuilder(column: $table.intensity, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get actualDuration => $composableBuilder(
      column: $table.actualDuration, builder: (column) => column);

  GeneratedColumn<double> get actualDistance => $composableBuilder(
      column: $table.actualDistance, builder: (column) => column);

  GeneratedColumn<double> get actualPace => $composableBuilder(
      column: $table.actualPace, builder: (column) => column);

  GeneratedColumn<int> get rpe =>
      $composableBuilder(column: $table.rpe, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => column);
}

class $$WorkoutsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WorkoutsTable,
    WorkoutDTO,
    $$WorkoutsTableFilterComposer,
    $$WorkoutsTableOrderingComposer,
    $$WorkoutsTableAnnotationComposer,
    $$WorkoutsTableCreateCompanionBuilder,
    $$WorkoutsTableUpdateCompanionBuilder,
    (WorkoutDTO, BaseReferences<_$AppDatabase, $WorkoutsTable, WorkoutDTO>),
    WorkoutDTO,
    PrefetchHooks Function()> {
  $$WorkoutsTableTableManager(_$AppDatabase db, $WorkoutsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<int> userId = const Value.absent(),
            Value<int> goalId = const Value.absent(),
            Value<String?> phaseId = const Value.absent(),
            Value<String?> blockId = const Value.absent(),
            Value<DateTime> scheduledDate = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> plannedDuration = const Value.absent(),
            Value<double?> plannedDistance = const Value.absent(),
            Value<String?> intensity = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int?> actualDuration = const Value.absent(),
            Value<double?> actualDistance = const Value.absent(),
            Value<double?> actualPace = const Value.absent(),
            Value<int?> rpe = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WorkoutsCompanion(
            id: id,
            userId: userId,
            goalId: goalId,
            phaseId: phaseId,
            blockId: blockId,
            scheduledDate: scheduledDate,
            type: type,
            name: name,
            plannedDuration: plannedDuration,
            plannedDistance: plannedDistance,
            intensity: intensity,
            description: description,
            status: status,
            actualDuration: actualDuration,
            actualDistance: actualDistance,
            actualPace: actualPace,
            rpe: rpe,
            completedAt: completedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required int userId,
            required int goalId,
            Value<String?> phaseId = const Value.absent(),
            Value<String?> blockId = const Value.absent(),
            required DateTime scheduledDate,
            required String type,
            required String name,
            required int plannedDuration,
            Value<double?> plannedDistance = const Value.absent(),
            Value<String?> intensity = const Value.absent(),
            Value<String?> description = const Value.absent(),
            required String status,
            Value<int?> actualDuration = const Value.absent(),
            Value<double?> actualDistance = const Value.absent(),
            Value<double?> actualPace = const Value.absent(),
            Value<int?> rpe = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WorkoutsCompanion.insert(
            id: id,
            userId: userId,
            goalId: goalId,
            phaseId: phaseId,
            blockId: blockId,
            scheduledDate: scheduledDate,
            type: type,
            name: name,
            plannedDuration: plannedDuration,
            plannedDistance: plannedDistance,
            intensity: intensity,
            description: description,
            status: status,
            actualDuration: actualDuration,
            actualDistance: actualDistance,
            actualPace: actualPace,
            rpe: rpe,
            completedAt: completedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WorkoutsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WorkoutsTable,
    WorkoutDTO,
    $$WorkoutsTableFilterComposer,
    $$WorkoutsTableOrderingComposer,
    $$WorkoutsTableAnnotationComposer,
    $$WorkoutsTableCreateCompanionBuilder,
    $$WorkoutsTableUpdateCompanionBuilder,
    (WorkoutDTO, BaseReferences<_$AppDatabase, $WorkoutsTable, WorkoutDTO>),
    WorkoutDTO,
    PrefetchHooks Function()>;
typedef $$PhasesTableCreateCompanionBuilder = PhasesCompanion Function({
  required String id,
  required int goalId,
  required int phaseNumber,
  required String phaseType,
  required int durationWeeks,
  required String targetWeeklyVolume,
  required String targetWeeklyDuration,
  Value<DateTime?> startDate,
  Value<DateTime?> endDate,
  Value<String?> description,
  Value<int> rowid,
});
typedef $$PhasesTableUpdateCompanionBuilder = PhasesCompanion Function({
  Value<String> id,
  Value<int> goalId,
  Value<int> phaseNumber,
  Value<String> phaseType,
  Value<int> durationWeeks,
  Value<String> targetWeeklyVolume,
  Value<String> targetWeeklyDuration,
  Value<DateTime?> startDate,
  Value<DateTime?> endDate,
  Value<String?> description,
  Value<int> rowid,
});

class $$PhasesTableFilterComposer
    extends Composer<_$AppDatabase, $PhasesTable> {
  $$PhasesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get goalId => $composableBuilder(
      column: $table.goalId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get phaseNumber => $composableBuilder(
      column: $table.phaseNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phaseType => $composableBuilder(
      column: $table.phaseType, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationWeeks => $composableBuilder(
      column: $table.durationWeeks, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get targetWeeklyVolume => $composableBuilder(
      column: $table.targetWeeklyVolume,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get targetWeeklyDuration => $composableBuilder(
      column: $table.targetWeeklyDuration,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));
}

class $$PhasesTableOrderingComposer
    extends Composer<_$AppDatabase, $PhasesTable> {
  $$PhasesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get goalId => $composableBuilder(
      column: $table.goalId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get phaseNumber => $composableBuilder(
      column: $table.phaseNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phaseType => $composableBuilder(
      column: $table.phaseType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationWeeks => $composableBuilder(
      column: $table.durationWeeks,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get targetWeeklyVolume => $composableBuilder(
      column: $table.targetWeeklyVolume,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get targetWeeklyDuration => $composableBuilder(
      column: $table.targetWeeklyDuration,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));
}

class $$PhasesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PhasesTable> {
  $$PhasesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get goalId =>
      $composableBuilder(column: $table.goalId, builder: (column) => column);

  GeneratedColumn<int> get phaseNumber => $composableBuilder(
      column: $table.phaseNumber, builder: (column) => column);

  GeneratedColumn<String> get phaseType =>
      $composableBuilder(column: $table.phaseType, builder: (column) => column);

  GeneratedColumn<int> get durationWeeks => $composableBuilder(
      column: $table.durationWeeks, builder: (column) => column);

  GeneratedColumn<String> get targetWeeklyVolume => $composableBuilder(
      column: $table.targetWeeklyVolume, builder: (column) => column);

  GeneratedColumn<String> get targetWeeklyDuration => $composableBuilder(
      column: $table.targetWeeklyDuration, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);
}

class $$PhasesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PhasesTable,
    PhaseDTO,
    $$PhasesTableFilterComposer,
    $$PhasesTableOrderingComposer,
    $$PhasesTableAnnotationComposer,
    $$PhasesTableCreateCompanionBuilder,
    $$PhasesTableUpdateCompanionBuilder,
    (PhaseDTO, BaseReferences<_$AppDatabase, $PhasesTable, PhaseDTO>),
    PhaseDTO,
    PrefetchHooks Function()> {
  $$PhasesTableTableManager(_$AppDatabase db, $PhasesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PhasesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PhasesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PhasesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<int> goalId = const Value.absent(),
            Value<int> phaseNumber = const Value.absent(),
            Value<String> phaseType = const Value.absent(),
            Value<int> durationWeeks = const Value.absent(),
            Value<String> targetWeeklyVolume = const Value.absent(),
            Value<String> targetWeeklyDuration = const Value.absent(),
            Value<DateTime?> startDate = const Value.absent(),
            Value<DateTime?> endDate = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PhasesCompanion(
            id: id,
            goalId: goalId,
            phaseNumber: phaseNumber,
            phaseType: phaseType,
            durationWeeks: durationWeeks,
            targetWeeklyVolume: targetWeeklyVolume,
            targetWeeklyDuration: targetWeeklyDuration,
            startDate: startDate,
            endDate: endDate,
            description: description,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required int goalId,
            required int phaseNumber,
            required String phaseType,
            required int durationWeeks,
            required String targetWeeklyVolume,
            required String targetWeeklyDuration,
            Value<DateTime?> startDate = const Value.absent(),
            Value<DateTime?> endDate = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PhasesCompanion.insert(
            id: id,
            goalId: goalId,
            phaseNumber: phaseNumber,
            phaseType: phaseType,
            durationWeeks: durationWeeks,
            targetWeeklyVolume: targetWeeklyVolume,
            targetWeeklyDuration: targetWeeklyDuration,
            startDate: startDate,
            endDate: endDate,
            description: description,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PhasesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PhasesTable,
    PhaseDTO,
    $$PhasesTableFilterComposer,
    $$PhasesTableOrderingComposer,
    $$PhasesTableAnnotationComposer,
    $$PhasesTableCreateCompanionBuilder,
    $$PhasesTableUpdateCompanionBuilder,
    (PhaseDTO, BaseReferences<_$AppDatabase, $PhasesTable, PhaseDTO>),
    PhaseDTO,
    PrefetchHooks Function()>;
typedef $$TrainingBlocksTableCreateCompanionBuilder = TrainingBlocksCompanion
    Function({
  required String id,
  required String phaseId,
  required int blockNumber,
  required String intent,
  required int durationDays,
  Value<DateTime?> startDate,
  Value<DateTime?> endDate,
  Value<int> rowid,
});
typedef $$TrainingBlocksTableUpdateCompanionBuilder = TrainingBlocksCompanion
    Function({
  Value<String> id,
  Value<String> phaseId,
  Value<int> blockNumber,
  Value<String> intent,
  Value<int> durationDays,
  Value<DateTime?> startDate,
  Value<DateTime?> endDate,
  Value<int> rowid,
});

class $$TrainingBlocksTableFilterComposer
    extends Composer<_$AppDatabase, $TrainingBlocksTable> {
  $$TrainingBlocksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phaseId => $composableBuilder(
      column: $table.phaseId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get blockNumber => $composableBuilder(
      column: $table.blockNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get intent => $composableBuilder(
      column: $table.intent, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationDays => $composableBuilder(
      column: $table.durationDays, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnFilters(column));
}

class $$TrainingBlocksTableOrderingComposer
    extends Composer<_$AppDatabase, $TrainingBlocksTable> {
  $$TrainingBlocksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phaseId => $composableBuilder(
      column: $table.phaseId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get blockNumber => $composableBuilder(
      column: $table.blockNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get intent => $composableBuilder(
      column: $table.intent, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationDays => $composableBuilder(
      column: $table.durationDays,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnOrderings(column));
}

class $$TrainingBlocksTableAnnotationComposer
    extends Composer<_$AppDatabase, $TrainingBlocksTable> {
  $$TrainingBlocksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get phaseId =>
      $composableBuilder(column: $table.phaseId, builder: (column) => column);

  GeneratedColumn<int> get blockNumber => $composableBuilder(
      column: $table.blockNumber, builder: (column) => column);

  GeneratedColumn<String> get intent =>
      $composableBuilder(column: $table.intent, builder: (column) => column);

  GeneratedColumn<int> get durationDays => $composableBuilder(
      column: $table.durationDays, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);
}

class $$TrainingBlocksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TrainingBlocksTable,
    TrainingBlockDTO,
    $$TrainingBlocksTableFilterComposer,
    $$TrainingBlocksTableOrderingComposer,
    $$TrainingBlocksTableAnnotationComposer,
    $$TrainingBlocksTableCreateCompanionBuilder,
    $$TrainingBlocksTableUpdateCompanionBuilder,
    (
      TrainingBlockDTO,
      BaseReferences<_$AppDatabase, $TrainingBlocksTable, TrainingBlockDTO>
    ),
    TrainingBlockDTO,
    PrefetchHooks Function()> {
  $$TrainingBlocksTableTableManager(
      _$AppDatabase db, $TrainingBlocksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TrainingBlocksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TrainingBlocksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TrainingBlocksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> phaseId = const Value.absent(),
            Value<int> blockNumber = const Value.absent(),
            Value<String> intent = const Value.absent(),
            Value<int> durationDays = const Value.absent(),
            Value<DateTime?> startDate = const Value.absent(),
            Value<DateTime?> endDate = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TrainingBlocksCompanion(
            id: id,
            phaseId: phaseId,
            blockNumber: blockNumber,
            intent: intent,
            durationDays: durationDays,
            startDate: startDate,
            endDate: endDate,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String phaseId,
            required int blockNumber,
            required String intent,
            required int durationDays,
            Value<DateTime?> startDate = const Value.absent(),
            Value<DateTime?> endDate = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TrainingBlocksCompanion.insert(
            id: id,
            phaseId: phaseId,
            blockNumber: blockNumber,
            intent: intent,
            durationDays: durationDays,
            startDate: startDate,
            endDate: endDate,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TrainingBlocksTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TrainingBlocksTable,
    TrainingBlockDTO,
    $$TrainingBlocksTableFilterComposer,
    $$TrainingBlocksTableOrderingComposer,
    $$TrainingBlocksTableAnnotationComposer,
    $$TrainingBlocksTableCreateCompanionBuilder,
    $$TrainingBlocksTableUpdateCompanionBuilder,
    (
      TrainingBlockDTO,
      BaseReferences<_$AppDatabase, $TrainingBlocksTable, TrainingBlockDTO>
    ),
    TrainingBlockDTO,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$GoalsTableTableManager get goals =>
      $$GoalsTableTableManager(_db, _db.goals);
  $$ConversationsTableTableManager get conversations =>
      $$ConversationsTableTableManager(_db, _db.conversations);
  $$ConversationMessagesTableTableManager get conversationMessages =>
      $$ConversationMessagesTableTableManager(_db, _db.conversationMessages);
  $$LongTermContextTableTableManager get longTermContext =>
      $$LongTermContextTableTableManager(_db, _db.longTermContext);
  $$MediumTermContextTableTableManager get mediumTermContext =>
      $$MediumTermContextTableTableManager(_db, _db.mediumTermContext);
  $$WorkoutsTableTableManager get workouts =>
      $$WorkoutsTableTableManager(_db, _db.workouts);
  $$PhasesTableTableManager get phases =>
      $$PhasesTableTableManager(_db, _db.phases);
  $$TrainingBlocksTableTableManager get trainingBlocks =>
      $$TrainingBlocksTableTableManager(_db, _db.trainingBlocks);
}
