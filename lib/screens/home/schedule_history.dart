import 'package:flutter/material.dart';
import 'package:repeater/screens/home/schedule_list_tile.dart';
import 'package:repeater/widgets/custom_list_view.dart';

class ScheduleHistory extends StatelessWidget {
  final List schedules;

  const ScheduleHistory({
    super.key,
    required this.schedules,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History Schedules'),
      ),
      body: CustomListView(
        children: schedules
            .map(
              (scheduleEntry) => ScheduleListTile(
                scheduleEntry: scheduleEntry,
                enabled: false,
              ),
            )
            .toList(),
      ),
    );
  }
}
