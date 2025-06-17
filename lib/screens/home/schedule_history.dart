import 'package:flutter/material.dart';
import 'package:repeater/screens/home/schedule_list_tile.dart';
import 'package:repeater/screens/main/main_navigation.dart';
import 'package:repeater/services/user_preferences.dart';
import 'package:repeater/widgets/custom_list_view.dart';

class ScheduleHistory extends StatefulWidget {
  final List schedules;

  const ScheduleHistory({
    super.key,
    required this.schedules,
  });

  @override
  State<ScheduleHistory> createState() => _ScheduleHistoryState();
}

class _ScheduleHistoryState extends State<ScheduleHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule History'),
        actions: [
          IconButton(
            onPressed: () async {
              await UserPreferences().clearHistory();
              if (!context.mounted) return;
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainNavigation(),
                  ),
                  (route) => false);
            },
            icon: const Icon(Icons.delete),
            tooltip: 'Delete All',
          ),
        ],
      ),
      body: CustomListView(
        children: widget.schedules.isEmpty
            ? [
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text('No history found.',
                        style: TextStyle(color: Colors.grey)),
                  ),
                ),
              ]
            : widget.schedules
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
