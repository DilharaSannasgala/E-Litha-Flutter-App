import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:e_litha/screens/calender-screen.dart';
import 'package:e_litha/screens/event-time-screen.dart';
import 'package:e_litha/screens/home-screen.dart';
import 'package:e_litha/screens/loading-screen.dart';
import 'package:e_litha/screens/nakath-screen.dart';
import 'package:e_litha/screens/annual-summary-screen.dart';
import 'package:e_litha/screens/rahu-kalaya-screen.dart';
import 'package:e_litha/screens/rashi-income-expense-screen.dart';
import 'package:e_litha/screens/subha-dawasa-screen.dart';
import 'package:e_litha/services/notification_service.dart';
import 'package:flutter/material.dart';


// This is needed for the @pragma to work correctly
@pragma('vm:entry-point')
void main() async {
  // This is required to initialize plugins before runApp
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize notification service
  await NotificationService.init();
  
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
    return MaterialApp(
      title: 'E-Litha',
      theme: ThemeData(
        fontFamily: 'AbhayaLibre',
      ),
      builder: (context, child) {
        final mediaQueryData = MediaQuery.of(context);
        
        // Base screen width for your design (e.g., standard mobile screen like iPhone X/11/13 is ~375)
        double scaleFactor = mediaQueryData.size.width / 375.0;
        
        // Clamp it to prevent text from being too tiny on small phones, or way too large on tablets
        scaleFactor = scaleFactor.clamp(0.85, 1.3);

        // Combine our responsive scale with the user's system text scaling preference (accessibility)
        final double systemTextScale = mediaQueryData.textScaler.scale(1);

        return MediaQuery(
          data: mediaQueryData.copyWith(
            textScaler: TextScaler.linear(systemTextScale * scaleFactor),
          ),
          child: child!,
        );
      },
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
      '/': (context) => const LoadingScreen(),
      '/home': (context) => HomePage(),
      '/calendar': (context) => CalendarScreen(),
      '/nakath': (context) => const NakathScreen(),
      '/eventTimes' : (context) => const EventTimeScreen(),
      '/subhaDawasa' : (context) => const SubhaDawasaScreen(),
      '/rashiIncomeExpense': (context) => const RashiTableScreen(),
      '/rahukalaya': (context) => const RahuKalayaScreen(),
      '/summary' : (context) => const AnnualSummaryScreen()
    });
  }
}
