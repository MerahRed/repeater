import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:repeater/l10n/app_localizations.dart';
import 'package:repeater/l10n/app_localizations_ar.dart';
import 'package:repeater/models/maqra.dart';
import 'package:repeater/models/schedule_entry.dart';
import 'package:repeater/screens/main/main_navigation.dart';
import 'package:repeater/services/user_preferences.dart';
import 'package:repeater/widgets/custom_list_view.dart';

class ScheduleDetailsScreen extends StatelessWidget {
  final ScheduleEntry scheduleEntry;

  const ScheduleDetailsScreen({
    super.key,
    required this.scheduleEntry,
  });

  @override
  Widget build(BuildContext context) {
    final userPrefs = Provider.of<UserPreferences>(context, listen: false);
    final user = userPrefs.getUser()!;

    final reviewType = scheduleEntry.reviewType!;
    final juzNumber = 'Juz ${scheduleEntry.juzNumber}';
    final fraction =
        (scheduleEntry.fraction == null) ? '' : ' · ${scheduleEntry.fraction}';
    final maqraNumbers =
        'Maqra ${scheduleEntry.maqraNumbers.join(', ')}$fraction';
    final date = (DateFormat.yMMMd().format(DateTime.now()) ==
            DateFormat.yMMMd().format(scheduleEntry.startDate))
        ? AppLocalizations.of(context)!.today
        : DateFormat.yMMMd().format(scheduleEntry.startDate);
    final time = DateFormat.jm().format(scheduleEntry.startDate);

    void markAsCompleted(value) {
      final newScheduleEntry = scheduleEntry.copyWith(
        isCompleted: !scheduleEntry.isCompleted,
      );
      final schedules = List<ScheduleEntry>.from(user.schedules);
      final index = schedules.indexOf(scheduleEntry);
      schedules[index] = newScheduleEntry;

      final lastMaqraNumber = scheduleEntry.maqraNumbers.last;

      int? juzNumber;
      int? maqraNumber;

      if (user.juzNumber != null && scheduleEntry.fraction == '4/4') {
        //not khatam
        if (scheduleEntry.isCompleted) {
          //incompleting + set to current juz
          juzNumber = scheduleEntry.juzNumber;

          if (lastMaqraNumber == 8) {
            maqraNumber = 8;
          } else {
            maqraNumber = lastMaqraNumber;
          }

          userPrefs.updateMaqra(
            scheduleEntry.juzNumber,
            lastMaqraNumber,
            Maqra(isMemorized: false),
          );
        } else {
          //completing

          if (lastMaqraNumber == 8) {
            //increment juz
            if (scheduleEntry.juzNumber == 30) {
              userPrefs.setKhatam();
            } else {
              juzNumber = scheduleEntry.juzNumber;
              do {
                juzNumber = juzNumber! + 1;
              } while (user.juzs[juzNumber - 1].isFullyMemorized);
              maqraNumber = 1;
            }
          } else {
            maqraNumber = lastMaqraNumber + 1;
          }

          userPrefs.updateMaqra(
            scheduleEntry.juzNumber,
            lastMaqraNumber,
            Maqra(isMemorized: true),
          );
        }
      } else {
        //khatam
        if (scheduleEntry.isCompleted) {
          juzNumber = scheduleEntry.juzNumber;
          maqraNumber = lastMaqraNumber;
          userPrefs.updateMaqra(
            scheduleEntry.juzNumber,
            lastMaqraNumber,
            Maqra(isMemorized: false),
          );
        } else {
          userPrefs.updateMaqra(
            scheduleEntry.juzNumber,
            lastMaqraNumber,
            Maqra(isMemorized: true),
          );
        }
      }

      userPrefs.updateUser(
        schedules: schedules,
        juzNumber: juzNumber,
        maqraNumber: maqraNumber,
      );

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const MainNavigation()),
        (_) => false,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.scheduleDetails),
      ),
      body: CustomListView(
        children: [
          ListTile(
            leading: const Icon(Icons.loop),
            title: Text(AppLocalizations.of(context)!.reviewType),
            trailing: Text(reviewType),
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: Text(AppLocalizations.of(context)!.portion),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(juzNumber),
                Text(maqraNumbers),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.timer),
            title: Text(AppLocalizations.of(context)!.time),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(date),
                Text(time),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(AppLocalizations.of(context)!.typeDetail),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(reviewType == 'Sabaq'
                    ? AppLocalizations.of(context)!.sabaqDetails
                    : reviewType == 'Sabqi'
                        ? AppLocalizations.of(context)!.sabqiDetails
                        : reviewType == 'Manzil'
                            ? AppLocalizations.of(context)!.manzilDetails
                            : reviewType),
              ],
            ),
          ),
          ListTile(
            title: FilledButton.icon(
              onPressed: () => markAsCompleted(true),
              icon: Icon(
                scheduleEntry.isCompleted ? Icons.close : Icons.check,
              ),
              label: Text(
                scheduleEntry.isCompleted
                    ? AppLocalizations.of(context)!.incompleted
                    : AppLocalizations.of(context)!.completed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
