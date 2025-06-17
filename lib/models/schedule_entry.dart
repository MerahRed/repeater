import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'schedule_entry.g.dart';

@HiveType(typeId: 3)
class ScheduleEntry {
  @HiveField(0)
  DateTime _startDate;

  @HiveField(1)
  String? _reviewType;

  @HiveField(2)
  int? _juzNumber;

  @HiveField(3)
  List<int> _maqraNumbers;

  @HiveField(4)
  String? _fraction;

  @HiveField(5)
  bool? _isCompleted;

  @HiveField(6)
  bool? _isScheduled;

  ScheduleEntry({
    DateTime? startDate,
    String? reviewType,
    int? juzNumber,
    List<int>? maqraNumbers,
    String? fraction,
    bool? isCompleted,
    bool? isScheduled,
  })  : _startDate = startDate ?? DateTime.now(),
        _reviewType = reviewType,
        _juzNumber = juzNumber,
        _maqraNumbers = maqraNumbers ?? List.generate(8, (index) => index + 1),
        _fraction = fraction,
        _isCompleted = isCompleted,
        _isScheduled = isScheduled;

  ScheduleEntry copyWith({
    DateTime? startDate,
    String? reviewType,
    int? juzNumber,
    List<int>? maqraNumbers,
    String? fraction,
    bool? isCompleted,
    bool? isScheduled,
  }) {
    return ScheduleEntry(
      startDate: startDate ?? this.startDate,
      reviewType: reviewType ?? this.reviewType,
      juzNumber: juzNumber ?? this.juzNumber,
      maqraNumbers: maqraNumbers ?? this.maqraNumbers,
      fraction: fraction ?? this.fraction,
      isCompleted: isCompleted ?? this.isCompleted,
      isScheduled: isScheduled ?? this.isScheduled,
    );
  }

  DateTime get startDate => _startDate;
  String? get reviewType => _reviewType;
  int get juzNumber => _juzNumber!;
  List<int> get maqraNumbers => _maqraNumbers;
  String? get fraction => _fraction;
  bool get isCompleted => _isCompleted ?? false;
  bool get isScheduled => _isScheduled ?? false;

  set isCompleted(bool value) {
    _isCompleted = value;
  }

  set isScheduled(bool value) {
    _isScheduled = value;
  }
}
