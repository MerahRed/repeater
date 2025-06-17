import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:repeater/main.dart';
import 'package:repeater/models/schedule_entry.dart';
import 'package:repeater/screens/home/schedule_details_screen.dart';
import 'package:repeater/services/user_preferences.dart';
import 'package:repeater/utils/constants/styles.dart';

const remindersChannelName = 'Reminders';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  NotificationService._internal();
  factory NotificationService() => _instance;

  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    final user = UserPreferences().getUser()!;
    final startDate = DateTime.parse(receivedAction.payload!['startDate']!);
    final scheduleEntry = user.schedules
        .firstWhere((scheduleEntry) => scheduleEntry.startDate == startDate);

    MainApp.navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) => ScheduleDetailsScreen(
          scheduleEntry: scheduleEntry,
        ),
      ),
    );
  }

  Future<void> init() async {
    if (kIsWeb) return;

    AwesomeNotifications().initialize(
      'resource://drawable/ic_launcher_foreground',
      [
        NotificationChannel(
          channelKey: remindersChannelName,
          channelName: remindersChannelName,
          channelDescription: 'Notification channel for reminders',
          importance: NotificationImportance.Max,
          defaultColor: Styles.themeColor,
          channelShowBadge: true,
          playSound: true,
          enableVibration: true,
          criticalAlerts: true,
          enableLights: true,
        ),
      ],
    );
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
    );

    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    AwesomeNotifications().resetGlobalBadge();
  }

  void createNotification({
    required String title,
    required String body,
    required DateTime startDate,
  }) {
    if (kIsWeb) return;

    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: -1,
        channelKey: remindersChannelName,
        category: NotificationCategory.Reminder,
        title: title,
        body: body,
        timeoutAfter: const Duration(hours: 1),
        payload: {
          'startDate': '$startDate',
        },
      ),
      schedule: NotificationCalendar.fromDate(
        allowWhileIdle: true,
        date: startDate,
      ),
    );
  }

  void scheduleNotification(ScheduleEntry scheduleEntry) {
    if (scheduleEntry.isScheduled) return;

    final juzNumber = scheduleEntry.juzNumber;
    final maqraNumbers = scheduleEntry.maqraNumbers.join(', ');
    final fraction =
        (scheduleEntry.fraction == null) ? '' : ' · ${scheduleEntry.fraction}';
    final title = scheduleEntry.reviewType!;
    final body = 'Juz $juzNumber · Maqra $maqraNumbers$fraction';
    final startDate = scheduleEntry.startDate;

    createNotification(
      title: title,
      body: body,
      startDate: startDate,
    );
  }

  void warningNotification(ScheduleEntry scheduleEntry) {
    if (scheduleEntry.isCompleted == true) return;

    // final juzNumber = scheduleEntry.juzNumber;
    // final maqraNumbers = scheduleEntry.maqraNumbers.join(', ');
    // final fraction =
    //     (scheduleEntry.fraction == null) ? '' : ' · ${scheduleEntry.fraction}';
    // final reviewType = scheduleEntry.reviewType!;
    final startDate = scheduleEntry.startDate;

    final title = 'Oops! ';
    final body = 'You have an incomplete schedule entry for today. ';

    createNotification(
      title: title,
      body: body,
      startDate: startDate,
    );
  }
}
