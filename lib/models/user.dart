// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:repeater/models/juz.dart';
import 'package:repeater/models/schedule_entry.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  int? _juzNumber;

  @HiveField(1)
  int? _maqraNumber;

  @HiveField(2)
  List<Juz> _juzs;

  @HiveField(3)
  DateTime _lastLoginTime;

  @HiveField(4)
  List<ScheduleEntry>? _schedules;

  @HiveField(5)
  String? _themeMode;

  @HiveField(6)
  int? _colorScheme;

  @HiveField(7)
  List<ScheduleEntry>? _scheduleHistory;

  User({
    int? juzNumber,
    int? maqraNumber,
    List<Juz>? juzs,
    DateTime? lastLoginTime,
    List<ScheduleEntry>? schedules,
    String? themeMode,
    int? colorScheme,
    List<ScheduleEntry>? scheduleHistory,
  })  : _juzNumber = juzNumber,
        _maqraNumber = maqraNumber,
        _juzs = juzs ?? List.generate(30, (_) => Juz()),
        _lastLoginTime = lastLoginTime ??
            DateTime.now().subtract(
              const Duration(days: 1),
            ),
        _schedules = schedules,
        _themeMode = themeMode,
        _colorScheme = colorScheme,
        _scheduleHistory = scheduleHistory;

  User copyWith({
    int? juzNumber,
    int? maqraNumber,
    List<Juz>? juzs,
    DateTime? lastLoginTime,
    List<ScheduleEntry>? schedules,
    String? themeMode,
    int? colorScheme,
    List<ScheduleEntry>? scheduleHistory,
  }) {
    return User(
      juzNumber: juzNumber ?? this.juzNumber,
      maqraNumber: maqraNumber ?? this.maqraNumber,
      juzs: juzs ?? this.juzs,
      lastLoginTime: lastLoginTime ?? this.lastLoginTime,
      schedules: schedules ?? this.schedules,
      themeMode: themeMode ?? this.themeMode,
      colorScheme: colorScheme ?? this.colorScheme,
      scheduleHistory: scheduleHistory ?? this.scheduleHistory,
    );
  }

  int? get juzNumber => _juzNumber;
  int? get maqraNumber => _maqraNumber;
  List<Juz> get juzs => _juzs;
  DateTime get lastLoginTime => _lastLoginTime;
  List<ScheduleEntry> get schedules => _schedules ?? [];
  String get themeMode => _themeMode ?? 'System';
  int get colorScheme => _colorScheme ?? Colors.teal.toARGB32();
  List<ScheduleEntry> get scheduleHistory => _scheduleHistory ?? [];

  List<ScheduleEntry> getSchedulesByReviewType(String reviewType) => schedules
      .where(
        (scheduleEntry) => scheduleEntry.reviewType == reviewType,
      )
      .toList();

  DateTime getLatestStartDate(List<ScheduleEntry> schedules) {
    final latestStartDate = schedules
        .map((scheduleEntry) => scheduleEntry.startDate)
        .reduce((a, b) => a.isAfter(b) ? a : b);
    return latestStartDate;
  }

  ScheduleEntry getScheduleEntryByDate(DateTime date) =>
      schedules.firstWhere((scheduleEntry) => scheduleEntry.startDate == date);
}
