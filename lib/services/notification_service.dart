import 'dart:convert';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:e_litha/models/holiday-info-model.dart';
import 'package:e_litha/models/special-date-info.dart';
import 'package:e_litha/models/special-nakath-date-info.dart';
import 'package:flutter/material.dart';

class NotificationService {
  // Initialize notification plugin
  static Future<void> init() async {
    String? iconPath = null; // Use null to let awesome_notifications use the default app icon

    try {
      await AwesomeNotifications().initialize(
        iconPath,
        [
          NotificationChannel(
            channelKey: 'special_date_channel',
            channelName: 'Special Dates',
            channelDescription: 'Notifications for special dates',
            defaultColor: Colors.purple,
            ledColor: Colors.purple,
            importance: NotificationImportance.High,
          ),
          NotificationChannel(
            channelKey: 'holiday_channel',
            channelName: 'Holiday Notifications',
            channelDescription: 'Notifications for holidays',
            defaultColor: Colors.red,
            ledColor: Colors.red,
            importance: NotificationImportance.High,
          ),
          NotificationChannel(
            channelKey: 'nakath_channel',
            channelName: 'Nakath Notifications',
            channelDescription: 'Notifications for nakath dates',
            defaultColor: Colors.blue,
            ledColor: Colors.blue,
            importance: NotificationImportance.High,
          ),
        ],
      );
    } catch (e) {
      print('Failed to initialize notifications: $e');
    }

    // Request permissions
    await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  // Parse JSON data and schedule notifications
  static Future<void> scheduleNotificationsFromJson(String nakathJson, String holidayJson) async {
    // Parse Nakath JSON
    final nakathData = jsonDecode(nakathJson);
    final List<dynamic> nakathList = nakathData['specialDates'];
    final List<SpecialNakathDateInfo> nakathDates = nakathList
        .map((item) => SpecialNakathDateInfo.fromJson(item))
        .toList();

    // Parse Holiday JSON
    final holidayData = jsonDecode(holidayJson);
    final List<dynamic> holidayList = holidayData['holidays'];
    final List<HolidayInfo> holidays = holidayList
        .map((item) => HolidayInfo.fromJson(item))
        .toList();

    final List<dynamic> specialDatesList = holidayData['specialDates'];
    final List<SpecialDateInfo> specialDates = specialDatesList
        .map((item) => SpecialDateInfo.fromJson(item))
        .toList();

    // Debug prints for loaded data
    print('Loaded Nakath dates: ${nakathDates.length}');
    print('Loaded Holidays: ${holidays.length}');
    print('Loaded Special dates: ${specialDates.length}');

    // Schedule notifications
    await _scheduleNakathNotifications(nakathDates);
    await _scheduleHolidayNotifications(holidays);
    await _scheduleSpecialDateNotifications(specialDates);

    // Debug prints for scheduled notifications
    print('All notifications scheduled. Checking current notifications...');
    AwesomeNotifications().listScheduledNotifications().then((notifications) {
      print('Total scheduled notifications: ${notifications.length}');
    });
  }

  // Schedule notifications for Nakath dates
  static Future<void> _scheduleNakathNotifications(List<SpecialNakathDateInfo> nakathDates) async {
    for (var nakath in nakathDates) {
      // Extract hour and minute from time string
      final timeParts = nakath.time.split(':');
      final hour = int.parse(timeParts[0]);
      final minute = int.parse(timeParts[1]);

      // Create a DateTime for the exact time
      final scheduledTime = DateTime(
        nakath.year,
        nakath.month,
        nakath.day,
        hour,
        minute,
      );

      // Create a DateTime for 1 hour before
      final reminderTime = scheduledTime.subtract(const Duration(hours: 1));

      // Only schedule if the time is in the future
      if (scheduledTime.isAfter(DateTime.now())) {
        // Schedule the exact time notification
        await AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: _generateUniqueId(),
            channelKey: 'nakath_channel',
            title: "${nakath.notification} ආරම්භය...",
            notificationLayout: NotificationLayout.BigText,
          ),
          schedule: NotificationCalendar(
            year: scheduledTime.year,
            month: scheduledTime.month,
            day: scheduledTime.day,
            hour: scheduledTime.hour,
            minute: scheduledTime.minute,
            second: 0,
            millisecond: 0,
            allowWhileIdle: true,
          ),
        );

        // Schedule the 1-hour reminder notification
        await AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: _generateUniqueId(),
            channelKey: 'nakath_channel',
            title: '${nakath.notification} ${nakath.time}ට යෙදී ඇත...',
            notificationLayout: NotificationLayout.BigText,
          ),
          schedule: NotificationCalendar(
            year: reminderTime.year,
            month: reminderTime.month,
            day: reminderTime.day,
            hour: reminderTime.hour,
            minute: reminderTime.minute,
            second: 0,
            millisecond: 0,
            allowWhileIdle: true,
          ),
        );
      }
    }
  }

  // Schedule notifications for holidays
  static Future<void> _scheduleHolidayNotifications(List<HolidayInfo> holidays) async {
    for (var holiday in holidays) {
      // Create a DateTime for the beginning of the day (midnight)
      final scheduledTime = DateTime(
        holiday.year,
        holiday.month,
        holiday.day,
        0,
        0,
      );

      // Only schedule if the date is in the future
      if (scheduledTime.isAfter(DateTime.now())) {
        await AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: _generateUniqueId(),
            channelKey: 'holiday_channel',
            title: holiday.description,
            notificationLayout: NotificationLayout.BigText,
          ),
          schedule: NotificationCalendar(
            year: scheduledTime.year,
            month: scheduledTime.month,
            day: scheduledTime.day,
            hour: 7, // Send at 7 AM
            minute: 0,
            second: 0,
            millisecond: 0,
            allowWhileIdle: true,
          ),
        );
      }
    }
  }

  // Schedule notifications for special dates
  static Future<void> _scheduleSpecialDateNotifications(List<SpecialDateInfo> specialDates) async {
    for (var specialDate in specialDates) {
      // Create a DateTime for the beginning of the day (midnight)
      final scheduledTime = DateTime(
        specialDate.year,
        specialDate.month,
        specialDate.day,
        0,
        0,
      );

      // Only schedule if the date is in the future
      if (scheduledTime.isAfter(DateTime.now())) {
        await AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: _generateUniqueId(),
            channelKey: 'special_date_channel',
            title: specialDate.description,
            notificationLayout: NotificationLayout.BigText,
          ),
          schedule: NotificationCalendar(
            year: scheduledTime.year,
            month: scheduledTime.month,
            day: scheduledTime.day,
            hour: 7, // Send at 7 AM
            minute: 0,
            second: 0,
            millisecond: 0,
            allowWhileIdle: true,
          ),
        );
      }
    }
  }

  // Generate a unique ID for notifications
  static int _generateUniqueId() {
    return DateTime.now().millisecondsSinceEpoch.remainder(100000);
  }

  // Cancel all scheduled notifications
  static Future<void> cancelAllNotifications() async {
    await AwesomeNotifications().cancelAll();
  }

  // Store the notification callback for foreground handling
  static Function(ReceivedNotification)? _onNotificationTapped;

  // Setup notification listeners - FIXED VERSION
  static void setupNotificationListeners(Function(ReceivedNotification) onNotificationTapped) {
    // Store the callback for foreground handling
    _onNotificationTapped = onNotificationTapped;
  }

  // This static method is required for background notification handling
  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
    // This method will be called when the app is in foreground or background,
    // but not terminated/closed

    // If we're in foreground and have a callback, use it
    if (_onNotificationTapped != null) {
      _onNotificationTapped!(receivedAction);
    }

    // For background/terminated state handling, we could add channel-specific logic here
    // Or use a static method to save information for when the app is next opened
    print('Notification received in background: ${receivedAction.title}');
  }
}