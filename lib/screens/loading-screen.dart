import 'package:e_litha/utils/app-component.dart';
import 'package:e_litha/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'dart:async';
import 'dart:convert';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool _isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      // Load JSON data in background
      await _loadNotificationData();
      
      // Setup notification listeners
      _setupNotificationListener();
      
      setState(() {
        _isDataLoaded = true;
      });
      
      // Timer for the splash screen
      Timer(const Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, '/home');
      });
    } catch (e) {
      print('Error initializing app: $e');
      
      // If there's an error, still navigate to home after delay
      Timer(const Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, '/home');
      });
    }
  }

  Future<void> _loadNotificationData() async {
    try {
      // Load your JSON data - adjust paths to your actual asset files
      final nakathJson = await rootBundle.loadString(AppComponents.nakathData);
      final holidayJson = await rootBundle.loadString(AppComponents.calendarData);
      
      // Schedule notifications based on the data
      await NotificationService.scheduleNotificationsFromJson(nakathJson, holidayJson);
    } catch (e) {
      print('Error loading notification data: $e');
      // Continue with app loading even if notifications fail
    }
  }

  void _setupNotificationListener() {
    NotificationService.setupNotificationListeners((receivedNotification) {
      // Handle notification tap
      print('Notification tapped: ${receivedNotification.title}');
      
      // Navigate based on notification type
      if (receivedNotification.channelKey == 'nakath_channel') {
        Navigator.of(context).pushNamed('/nakath');
      } else if (receivedNotification.channelKey == 'holiday_channel' || 
                receivedNotification.channelKey == 'special_date_channel') {
        Navigator.of(context).pushNamed('/calendar');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(AppComponents.loadingScreen, fit: BoxFit.cover),
          
          // loading indicator
          if (!_isDataLoaded)
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Center(
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}