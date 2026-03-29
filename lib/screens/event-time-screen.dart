import 'dart:convert';
import 'package:e_litha/models/event-time-model.dart';
import 'package:e_litha/utils/app-color.dart';
import 'package:e_litha/widgets/event-times/event-card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/app-component.dart';

class EventTimeScreen extends StatefulWidget {
  const EventTimeScreen({super.key});

  @override
  State<EventTimeScreen> createState() => _EventTimeScreenState();
}

class _EventTimeScreenState extends State<EventTimeScreen> with SingleTickerProviderStateMixin {
  List<EventTimeInfo> eventTimes = [];
  bool isLoading = false;
  
  final double maxTabletWidth = 700.0;
  
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _loadEventTimeData();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadEventTimeData() async {
    try {
      setState(() => isLoading = true);
      final String jsonString = await rootBundle.loadString(AppComponents.eventData);
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      setState(() {
        eventTimes = (jsonData['eventTimes'] as List?)
                ?.map((item) => EventTimeInfo.fromJson(item))
                .toList() ??
            [];
        isLoading = false;
      });
      _animationController.forward();
    } catch (e) {
      debugPrint('Error loading event time data: $e');
      setState(() => isLoading = false);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load event time data: ${e.toString()}'),
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: AppBar(
        backgroundColor: AppColor.bgColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColor.btnTextColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'සුභ මුහුර්ත - 2025',
          style: TextStyle(
            fontSize: 25,
            
            color: AppColor.btnTextColor,
          ),
        ),
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: maxTabletWidth),
          child: isLoading
              ? const CircularProgressIndicator(color: AppColor.accentColor)
              : SafeArea(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: eventTimes.length,
                    itemBuilder: (context, index) {
                      final double start = (index * 0.1).clamp(0.0, 0.8);
                      final double end = (start + 0.2).clamp(0.0, 1.0);
                      
                      final Animation<double> itemFade = Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                          parent: _animationController,
                          curve: Interval(start, end, curve: Curves.easeOut),
                        ),
                      );
                      
                      final Animation<Offset> itemSlide = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
                        CurvedAnimation(
                          parent: _animationController,
                          curve: Interval(start, end, curve: Curves.easeOut),
                        ),
                      );

                      return FadeTransition(
                        opacity: itemFade,
                        child: SlideTransition(
                          position: itemSlide,
                          child: CollapsibleEventCard(
                            eventTimeInfo: eventTimes[index],
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }
}