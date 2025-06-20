import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repeater/models/juz.dart';
import 'package:repeater/models/schedule_entry.dart';
import 'package:repeater/models/user.dart';
import 'package:repeater/screens/home/edit_screen.dart';
import 'package:repeater/screens/home/juz_list_tile.dart';
import 'package:repeater/screens/home/schedule_history.dart';
import 'package:repeater/screens/home/schedule_list_tile.dart';
import 'package:repeater/screens/home/upcoming_schedules_screen.dart';
import 'package:repeater/services/user_preferences.dart';
import 'package:repeater/utils/constants/styles.dart';
import 'package:repeater/utils/date_time.dart';
import 'package:repeater/widgets/custom_list_view.dart';
import 'package:repeater/widgets/gap.dart';
import 'package:repeater/widgets/section_title.dart';
import 'package:repeater/l10n/app_localizations.dart';

// sabaq - hafal baru
// sabqi - mengulang hafal pd juz sedang hafal
// manzil - mengulang juz lama

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Juz> filteredJuzs = [];
  late Map<String, bool> filters;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final lang = AppLocalizations.of(context)!;
    filters = {
      lang.fullyMemorized: false,
      lang.partiallyMemorized: false,
      lang.notMemorized: false,
    };
  }

  List<ScheduleEntry> todaySchedules = [];
  List<ScheduleEntry> upcomingSchedules = [];
  List<ScheduleEntry> scheduleHistory = [];

  @override
  void initState() {
    super.initState();
    _getSchedules();
  }

  void _getSchedules() {
    final user =
        Provider.of<UserPreferences>(context, listen: false).getUser()!;
    filteredJuzs = user.juzs;
    final now = DateTime.now();

    final tempTodaySchedules = <ScheduleEntry>[];
    final tempUpcomingSchedules = <ScheduleEntry>[];
    for (final scheduleEntry in user.schedules) {
      if (isToday(scheduleEntry.startDate)) {
        tempTodaySchedules.add(scheduleEntry);
      } else if (scheduleEntry.startDate.isAfter(now)) {
        tempUpcomingSchedules.add(scheduleEntry);
      }
    }
    setState(() {
      todaySchedules = tempTodaySchedules;
      upcomingSchedules = tempUpcomingSchedules;
      scheduleHistory = user.scheduleHistory;
    });
  }

  void _filterJuzs(List<Juz> allJuzs) {
    setState(() {
      filteredJuzs = allJuzs.where((juz) {
        if (filters[AppLocalizations.of(context)!.fullyMemorized]! &&
            !juz.isFullyMemorized) {
          return false;
        }
        if (filters[AppLocalizations.of(context)!.partiallyMemorized]! &&
            !juz.isPartiallyMemorized) {
          return false;
        }
        if (filters[AppLocalizations.of(context)!.notMemorized]! &&
            !juz.isNotMemorized) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    final userPrefs = Provider.of<UserPreferences>(context);
    final user = userPrefs.getUser()!;

    return Stack(children: [
      Scaffold(
        appBar: AppBar(
          title: Text(lang.home),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await userPrefs.logIn();
            _getSchedules();
          },
          child: CustomListView(
            children: [
              ..._memorizationSection(user, context),
              const LargeGap(),
              ..._tasksSection(user),
              const LargeGap(),
              ..._overallProgressSection(user),
            ],
          ),
        ),
      ),
    ]);
  }

  List<Widget> _memorizationSection(User user, context) => [
        SectionTitle(AppLocalizations.of(context)!.memorizationInfo),
        ListTile(
          leading: const Icon(Icons.book),
          title: Text(AppLocalizations.of(context)!.hasKhatam),
          trailing: Icon(
            (user.juzNumber == null) ? Icons.check : Icons.close,
          ),
        ),
        if (user.juzNumber != null) ...[
          ListTile(
            leading: const Icon(Icons.menu_book),
            title: Text(AppLocalizations.of(context)!.currentJuz),
            trailing: Text(
              user.juzNumber.toString(),
              style: const TextStyle(fontSize: 15),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.brightness_low_outlined),
            title: Text(AppLocalizations.of(context)!.currentMaqra),
            trailing: Text(
              user.maqraNumber.toString(),
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
        ListTile(
          title: FilledButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const EditScreen(),
                ),
              );
            },
            icon: const Icon(Icons.edit),
            label: Text(AppLocalizations.of(context)!.editInfo),
          ),
        )
      ];

  List<Widget> _tasksSection(User user) => [
        SectionTitle(AppLocalizations.of(context)!.schedules),
        if (todaySchedules.isEmpty)
          ListTile(
            title: Center(
              child: Text(
                AppLocalizations.of(context)!.sorry,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          )
        else
          ...todaySchedules.map((scheduleEntry) {
            return ScheduleListTile(scheduleEntry: scheduleEntry);
          }),
        ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FilledButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          UpcomingSchedulesScreen(schedules: upcomingSchedules),
                    ),
                  );
                },
                icon: const Icon(Icons.upcoming),
                label: Text(AppLocalizations.of(context)!.seeUpcomingSchedules),
              ),
              FilledButton.tonalIcon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ScheduleHistory(
                        schedules: scheduleHistory,
                      ),
                    ),
                  );
                },
                label: Text(AppLocalizations.of(context)!.seeSchedulesHistory),
                icon: const Icon(Icons.history),
              ),
            ],
          ),
        ),
      ];

  List<Widget> _overallProgressSection(User user) => [
        SectionTitle(AppLocalizations.of(context)!.overallProgress),
        ListTile(
          title: Wrap(
            spacing: Styles.smallSpacing,
            children: filters.keys.map((key) {
              return ChoiceChip(
                label: Text(key),
                selected: filters[key]!,
                onSelected: (value) {
                  filters.forEach((key, _) {
                    filters[key] = false;
                  });

                  setState(() => filters[key] = value);
                  _filterJuzs(user.juzs);
                },
              );
            }).toList(),
          ),
        ),
        if (filteredJuzs.isEmpty)
          ListTile(
            leading: const Icon(Icons.not_interested),
            title: Text(AppLocalizations.of(context)!.noResult),
          )
        else
          ...filteredJuzs.map((juz) {
            final juzNumber = user.juzs.indexOf(juz) + 1;
            return JuzListTile(
              juz: juz,
              juzNumber: juzNumber,
            );
          }),
      ];
}
