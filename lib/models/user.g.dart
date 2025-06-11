// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User()
      .._juzNumber = fields[0] as int?
      .._maqraNumber = fields[1] as int?
      .._juzs = (fields[2] as List).cast<Juz>()
      .._lastLoginTime = fields[3] as DateTime
      .._schedules = (fields[4] as List?)?.cast<ScheduleEntry>()
      .._themeMode = fields[5] as String?
      .._colorScheme = fields[6] as int?
      .._scheduleHistory = (fields[7] as List?)?.cast<ScheduleEntry>();
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj._juzNumber)
      ..writeByte(1)
      ..write(obj._maqraNumber)
      ..writeByte(2)
      ..write(obj._juzs)
      ..writeByte(3)
      ..write(obj._lastLoginTime)
      ..writeByte(4)
      ..write(obj._schedules)
      ..writeByte(5)
      ..write(obj._themeMode)
      ..writeByte(6)
      ..write(obj._colorScheme)
      ..writeByte(7)
      ..write(obj._scheduleHistory);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
