// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScheduleEntryAdapter extends TypeAdapter<ScheduleEntry> {
  @override
  final int typeId = 3;

  @override
  ScheduleEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScheduleEntry()
      .._startDate = fields[0] as DateTime
      .._reviewType = fields[1] as String?
      .._juzNumber = fields[2] as int?
      .._maqraNumbers = (fields[3] as List).cast<int>()
      .._fraction = fields[4] as String?
      .._isCompleted = fields[5] as bool?
      .._isScheduled = fields[6] as bool?;
  }

  @override
  void write(BinaryWriter writer, ScheduleEntry obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj._startDate)
      ..writeByte(1)
      ..write(obj._reviewType)
      ..writeByte(2)
      ..write(obj._juzNumber)
      ..writeByte(3)
      ..write(obj._maqraNumbers)
      ..writeByte(4)
      ..write(obj._fraction)
      ..writeByte(5)
      ..write(obj._isCompleted)
      ..writeByte(6)
      ..write(obj._isScheduled);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScheduleEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
