import 'package:flutter/material.dart';
import 'package:repeater/l10n/app_localizations.dart';
import 'package:repeater/models/schedule_entry.dart';
import 'package:repeater/screens/home/schedule_list_tile.dart';
import 'package:repeater/widgets/custom_list_view.dart';

class UpcomingSchedulesScreen extends StatelessWidget {
  const UpcomingSchedulesScreen({
    super.key,
    required this.schedules,
  });

  final List<ScheduleEntry> schedules;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.upcomingSchedules),
      ),
      body: CustomListView(
        children: schedules
            .map(
              (scheduleEntry) => ScheduleListTile(
                scheduleEntry: scheduleEntry,
              ),
            )
            .toList(),
      ),
    );
  }
}
