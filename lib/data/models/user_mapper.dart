import 'dart:convert';
import '../datasources/local/drift_database.dart';
import '../../features/shared/domain/entities/user.dart';

import 'package:drift/drift.dart';

extension UserDTOMapper on UserDTO {
  User toEntity() {
    return User(
      id: id.toString(),
      availableDays: (jsonDecode(availableDays) as List).cast<String>(),
      constraints: constraints,
      healthPermissionsGranted: healthPermissionsGranted,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension UserMapper on User {
  UserDTO toDTO() {
    return UserDTO(
      id: int.tryParse(id) ?? 0, // 0 means auto-increment/new
      availableDays: jsonEncode(availableDays),
      constraints: constraints,
      healthPermissionsGranted: healthPermissionsGranted,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  UsersCompanion toCompanion() {
    return UsersCompanion.insert(
      id: Value.absentIfNull(int.tryParse(id)),
      availableDays: jsonEncode(availableDays),
      constraints: Value(constraints),
      healthPermissionsGranted: Value(healthPermissionsGranted),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
