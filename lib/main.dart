import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:e_litha/screens/calender-screen.dart';
import 'package:e_litha/screens/event-time-screen.dart';
import 'package:e_litha/screens/home-screen.dart';
import 'package:e_litha/screens/loading-screen.dart';
import 'package:e_litha/screens/nakath-screen.dart';
import 'package:e_litha/screens/rashi-income-expense-screen.dart';
import 'package:e_litha/services/notification_service.dart';
import 'package:flutter/material.dart';


// This is needed for the @pragma to work correctly
@pragma('vm:entry-point')
void main() async {
  // This is required to initialize plugins before runApp
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize notification service
  await NotificationService.init();
  NotificationService.showTestNotification();

  // Set up the notification background action handler
  AwesomeNotifications().setListeners(
    onActionReceivedMethod: NotificationService.onActionReceivedMethod,
  );


  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'E-Litha', initialRoute: '/', routes: {
      '/': (context) => const LoadingScreen(),
      '/home': (context) => HomePage(),
      '/calendar': (context) => CalendarScreen(),
      '/nakath': (context) => const NakathScreen(),
      '/eventTimes' : (context) => const EventTimeScreen(),
      '/rashiIncomeExpense': (context) => const RashiTableScreen(),
    });
  }
}
