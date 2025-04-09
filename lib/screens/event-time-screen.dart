import 'dart:convert';
import 'package:e_litha/utils/app-color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/app-component.dart';

// Models
class EventTimeInfo {
  final String title;
  final String icon;
  final List<EventDate> dates;

  const EventTimeInfo({
    required this.title,
    required this.icon,
    required this.dates,
  });

  factory EventTimeInfo.fromJson(Map<String, dynamic> json) {
    return EventTimeInfo(
      title: json['title'] ?? '',
      icon: json['icon'] ?? '',
      dates: (json['dates'] as List?)
              ?.map((item) => EventDate.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class EventDate {
  final int day;
  final int month;
  final String description;

  const EventDate({
    required this.day,
    required this.month,
    required this.description,
  });

  factory EventDate.fromJson(Map<String, dynamic> json) {
    return EventDate(
      day: json['day'] ?? 1,
      month: json['month'] ?? 1,
      description: json['description'] ?? '',
    );
  }
}

// Main screen
class EventTimeScreen extends StatefulWidget {
  const EventTimeScreen({Key? key}) : super(key: key);

  @override
  State<EventTimeScreen> createState() => _EventTimeScreenState();
}

class _EventTimeScreenState extends State<EventTimeScreen> {
  List<EventTimeInfo> eventTimes = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // For demo we'll use dummy data instead of loading from assets
    _loadDummyData();
  }

  void _loadDummyData() {
    // Dummy data for demonstration
    setState(() {
      eventTimes = [
        EventTimeInfo(
          title: 'කන් විදීම',
          icon: '👂',
          dates: [],
        ),
        EventTimeInfo(
          title: 'හිසකෙස් කැපීම',
          icon: '✂️',
          dates: [
            EventDate(
              day: 30,
              month: 1, // January
              description: 'උදේ 9-32 ට උතුර බලා',
            ),
            EventDate(
              day: 19,
              month: 3, // March
              description: 'උදේ 10-01 ට නැගෙනහිර බලා',
            ),
          ],
        ),
        EventTimeInfo(
          title: 'බත් කැවීම',
          icon: '🍵',
          dates: [],
        ),
      ];
      isLoading = false;
    });
  }

  // In a real implementation, you would load data from assets like this:
  /*
  Future<void> _loadEventTimeData() async {
    try {
      setState(() => isLoading = true);
      final String jsonString = await rootBundle.loadString('assets/data/event_times.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      setState(() {
        eventTimes = (jsonData['eventTimes'] as List?)
                ?.map((item) => EventTimeInfo.fromJson(item))
                .toList() ??
            [];
        isLoading = false;
      });
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
  */

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
          'සුභ මුහූර්ත',
          style: TextStyle(
            fontSize: 25,
            fontFamily: AppComponents.accentFont,
            color: AppColor.btnTextColor,
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppColor.accentColor))
          : SafeArea(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: eventTimes.length,
                itemBuilder: (context, index) {
                  return CollapsibleEventCard(
                    eventTimeInfo: eventTimes[index],
                  );
                },
              ),
            ),
    );
  }
}

// Collapsible card component
class CollapsibleEventCard extends StatefulWidget {
  final EventTimeInfo eventTimeInfo;

  const CollapsibleEventCard({
    Key? key,
    required this.eventTimeInfo,
  }) : super(key: key);

  @override
  State<CollapsibleEventCard> createState() => _CollapsibleEventCardState();
}

class _CollapsibleEventCardState extends State<CollapsibleEventCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(begin: 0.0, end: 0.5).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      foregroundDecoration: BoxDecoration(
        border: Border.all(
          color: AppColor.borderLightColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: _toggleExpanded,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon container
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
                    child: Container(
                      width: 75,
                      height: 75,
                      decoration: BoxDecoration(
                        color: AppColor.iconBgColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          widget.eventTimeInfo.icon,
                          style: const TextStyle(fontSize: 28),
                        ),
                      ),
                    ),
                  ),

                  // Event title
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                widget.eventTimeInfo.title,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontFamily: AppComponents.accentFont,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.btnTextColor,
                                  height: 1.2,
                                ),
                              ),
                            ),
                          ),

                          // Circle with arrow icon
                          Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: AppColor.accentColor,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: RotationTransition(
                                turns: _rotationAnimation,
                                child: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Dates list (animated)
              ClipRect(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: _isExpanded && widget.eventTimeInfo.dates.isNotEmpty
                      ? null // Auto height
                      : 0, // Collapsed
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Column(
                      children: widget.eventTimeInfo.dates.map((date) {
                        return EventDateRow(date: date);
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Event date row component
class EventDateRow extends StatelessWidget {
  final EventDate date;

  const EventDateRow({
    Key? key,
    required this.date,
  }) : super(key: key);

  String _getMonthName(int month) {
    final monthNames = [
      'ජනවාරි', 'පෙබරවාරි', 'මාර්තු', 'අප්‍රේල්', 'මැයි', 'ජූනි',
      'ජූලි', 'අගෝස්තු', 'සැප්තැම්බර්', 'ඔක්තෝබර්', 'නොවැම්බර්', 'දෙසැම්බර්'
    ];
    
    if (month >= 1 && month <= 12) {
      return monthNames[month - 1];
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date container
          Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              color: AppColor.iconBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _getMonthName(date.month),
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: AppComponents.accentFont,
                    color: AppColor.btnTextColor,
                    height: 1.2,
                  ),
                ),
                Text(
                  date.day.toString(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontFamily: AppComponents.accentFont,
                    fontWeight: FontWeight.bold,
                    color: AppColor.btnTextColor,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Event description
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                date.description,
                style: const TextStyle(
                  fontSize: 20,
                  fontFamily: AppComponents.accentFont,
                  color: AppColor.btnSubTextColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
