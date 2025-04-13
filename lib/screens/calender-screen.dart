import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:e_litha/models/holiday-info-model.dart';
import 'package:e_litha/models/moon-phase-info-model.dart';
import 'package:e_litha/models/special-date-info.dart';
import 'package:e_litha/utils/app-color.dart';
import 'package:e_litha/utils/custom-date-time.dart';
import 'package:e_litha/utils/app-component.dart';
import 'package:e_litha/widgets/calender/calender-grid.dart';
import 'package:e_litha/widgets/calender/calender-month-navigation.dart';
import 'package:e_litha/widgets/calender/calender-moon-phase-widget.dart';
import 'package:e_litha/widgets/calender/calender-special-date-widget.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen>
    with SingleTickerProviderStateMixin {
  late int currentMonth;
  late int currentYear;
  List<HolidayInfo> holidayData = [];
  List<SpecialDateInfo> specialDateData = [];
  List<MoonPhaseInfo> moonPhaseData = [];
  bool isLoading = true;

  // Page controller for swipe navigation
  late PageController _pageController;

  // Animation controller for smooth transitions
  late AnimationController _animationController;
  late Animation<double> _animation;

  // Constants for responsive layout
  static const double _mobileBreakpoint = 600;
  static const double _maxCalendarWidth = 1000;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    currentMonth = now.month - 1;
    currentYear = now.year;

    // Initialize page controller with initial page set to current month
    _pageController = PageController(initialPage: currentMonth);

    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation =
        Tween<double>(begin: 0.8, end: 1.0).animate(_animationController);
    _animationController.forward();

    _loadCalendarData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadCalendarData() async {
    try {
      // Verify the path is correct
      debugPrint('Loading calendar data from: ${AppComponents.calendarData}');

      final String jsonString =
          await rootBundle.loadString(AppComponents.calendarData);
      debugPrint('Successfully loaded JSON string');

      final Map<String, dynamic> jsonData = json.decode(jsonString);
      debugPrint('Successfully parsed JSON data');

      setState(() {
        holidayData = (jsonData['holidays'] as List?)
                ?.map((item) => HolidayInfo.fromJson(item))
                .toList() ??
            [];
        debugPrint('Loaded ${holidayData.length} holidays');

        specialDateData = (jsonData['specialDates'] as List?)
                ?.map((item) => SpecialDateInfo.fromJson(item))
                .toList() ??
            [];
        debugPrint('Loaded ${specialDateData.length} special dates');

        moonPhaseData = (jsonData['moonPhases'] as List?)
                ?.map((item) => MoonPhaseInfo.fromJson(item))
                .toList() ??
            [];

        isLoading = false;
      });
    } catch (e, stackTrace) {
      debugPrint('Error loading calendar data: $e');
      debugPrint('Stack trace: $stackTrace');

      setState(() => isLoading = false);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load calendar data: ${e.toString()}'),
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }

  // Method to navigate to previous month
  void _navigateToPreviousMonth() {
    _animationController.reset();
    setState(() {
      if (currentMonth > 0) {
        currentMonth--;
        _pageController.previousPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        currentMonth = 11;
        currentYear--;
        _pageController.jumpToPage(currentMonth);
      }
    });
    _animationController.forward();
  }

  // Method to navigate to next month
  void _navigateToNextMonth() {
    _animationController.reset();
    setState(() {
      if (currentMonth < 11) {
        currentMonth++;
        _pageController.nextPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        currentMonth = 0;
        currentYear++;
        _pageController.jumpToPage(currentMonth);
      }
    });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isWideScreen = screenWidth > _mobileBreakpoint;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: AppBar(
        title: Text(
          "Èk o¾Ykh - $currentYear",
          style: TextStyle(
            fontSize: 25,
            fontFamily: AppComponents.accentFont,
            color: AppColor.btnTextColor,
          ),
        ),
        backgroundColor: AppColor.bgColor,
        elevation: 0,
        iconTheme: IconThemeData(
          color: AppColor.btnTextColor,
        ),
      ),
      body: SafeArea(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(color: AppColor.accentColor))
            : _buildResponsiveLayout(
                context, isWideScreen, isLandscape, screenHeight),
      ),
    );
  }

  Widget _buildResponsiveLayout(BuildContext context, bool isWideScreen,
      bool isLandscape, double screenHeight) {
    if (!isWideScreen && !isLandscape) {
      // Mobile portrait layout - always use ListView for scrolling
      return ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildCalendarContainer(isWideScreen, isLandscape, screenHeight),
          SizedBox(height: 16),
          _buildSpecialDatesContainer(isWideScreen, isLandscape, screenHeight),
        ],
      );
    } else if (!isWideScreen && isLandscape) {
      // Mobile landscape layout - side by side with scrolling
      return ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: _buildCalendarContainer(
                    isWideScreen, isLandscape, screenHeight),
              ),
              SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: _buildSpecialDatesContainer(
                    isWideScreen, isLandscape, screenHeight),
              ),
            ],
          ),
        ],
      );
    } else {
      // Desktop/tablet layout - side by side with individual scrolling areas
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Calendar container (left side)
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                constraints: BoxConstraints(maxWidth: _maxCalendarWidth),
                child: _buildCalendarContainer(
                    isWideScreen, isLandscape, screenHeight),
              ),
            ),
          ),
          // Special dates (right side)
          Expanded(
            flex: 2,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              child: _buildSpecialDatesContainer(
                  isWideScreen, isLandscape, screenHeight),
            ),
          ),
        ],
      );
    }
  }

  Widget _buildCalendarContainer(
      bool isWideScreen, bool isLandscape, double screenHeight) {
    // Calculate the calendar height based on screen size and orientation
    // Use a more conservative approach to avoid overflow
    double calendarHeight;
    if (isWideScreen) {
      calendarHeight = isLandscape ? screenHeight * 0.55 : screenHeight * 0.45;
    } else if (isLandscape) {
      calendarHeight = screenHeight * 0.6;
    } else {
      calendarHeight = screenHeight * 0.43;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 3),
          )
        ],
      ),
      foregroundDecoration: BoxDecoration(
        border: Border.all(
          color: AppColor.borderLightColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MonthNavigation(
            month: CustomDateTime().getCustomMonth(currentMonth + 1),
            onPrevious: _navigateToPreviousMonth,
            onNext: _navigateToNextMonth,
          ),
          SizedBox(height: 8),
          // Calendar grid with calculated height
          Container(
            height: calendarHeight,
            child: GestureDetector(
              onHorizontalDragEnd: (DragEndDetails details) {
                if (details.primaryVelocity! > 0) {
                  _navigateToPreviousMonth();
                } else if (details.primaryVelocity! < 0) {
                  _navigateToNextMonth();
                }
              },
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    if ((currentMonth == 11 && page == 0)) {
                      currentYear++;
                    } else if ((currentMonth == 0 && page == 11)) {
                      currentYear--;
                    }
                    currentMonth = page;
                  });
                },
                itemCount: 12,
                itemBuilder: (context, index) {
                  return FadeTransition(
                    opacity: _animation,
                    child: CalendarGrid(
                      year: currentYear,
                      month: index,
                      holidays: getHolidaysForMonth(currentYear, index),
                      specialDates: getSpecialDatesForMonth(currentYear, index),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 12),
          // Moon phase row
          MoonPhaseRow(
            moonPhases: getMoonPhasesForMonth(currentYear, currentMonth),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialDatesContainer(
      bool isWideScreen, bool isLandscape, double screenHeight) {
    // Calculate appropriate height based on screen dimensions
    double containerHeight;
    if (isWideScreen) {
      containerHeight = isLandscape ? screenHeight * 0.75 : screenHeight * 0.4;
    } else if (isLandscape) {
      containerHeight = screenHeight * 0.6;
    } else {
      containerHeight = screenHeight * 0.35;
    }

    // Get the events for current month
    final events = [
      ...getSpecialDatesForMonth(currentYear, currentMonth)
          .map((e) => _EventItem(
                date: e.day,
                month: e.month,
                description: e.name,
                isHoliday: false,
              )),
      ...getHolidaysForMonth(currentYear, currentMonth).map((e) => _EventItem(
            date: e.day,
            month: e.month,
            description: e.name,
            isHoliday: true,
          )),
    ]..sort((a, b) => a.date.compareTo(b.date));

    if (events.isEmpty) {
      return Container(
        height: isWideScreen ? null : containerHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 3),
            )
          ],
          border: Border.all(
            color: AppColor.borderLightColor,
            width: 2,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "No special dates for this month",
              style: TextStyle(
                fontFamily: AppComponents.accentFont,
                fontSize: 18,
                color: AppColor.btnTextColor.withOpacity(0.7),
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      height: isWideScreen ? null : containerHeight,
      padding: EdgeInsets.all(4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // For wide screens, use Expanded to allow the list to fill available space
          // For smaller screens, use a fixed Container height
          isWideScreen
              ? Expanded(
                  child: _buildEventsList(events),
                )
              : Container(
                  height:
                      containerHeight - 60, // Subtract header height + padding
                  child: _buildEventsList(events),
                ),
        ],
      ),
    );
  }

  Widget _buildEventsList(List<_EventItem> events) {
    return ListView.builder(
      itemCount: events.length,
      shrinkWrap: true,
      padding: EdgeInsets.only(bottom: 8),
      physics: AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final event = events[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: SpecialDateCard(
            date: event.date.toString(),
            month: event.month,
            description: event.description,
            isHoliday: event.isHoliday,
          ),
        );
      },
    );
  }

  List<HolidayInfo> getHolidaysForMonth(int year, int month) {
    return holidayData
        .where((holiday) =>
            holiday.year == year &&
            holiday.month == month + 1) // Adjust for 0-indexed months
        .toList();
  }

  List<SpecialDateInfo> getSpecialDatesForMonth(int year, int month) {
    return specialDateData
        .where((specialDate) =>
            specialDate.year == year &&
            specialDate.month == month + 1) // Adjust for 0-indexed months
        .toList();
  }

  List<MoonPhaseInfo> getMoonPhasesForMonth(int year, int month) {
    return moonPhaseData
        .where((moonPhase) =>
            moonPhase.year == year && moonPhase.month == month + 1)
        .toList();
  }
}

// Event item class for special dates list
class _EventItem {
  final int date;
  final int month;
  final String description;
  final bool isHoliday;

  _EventItem({
    required this.date,
    required this.month,
    required this.description,
    required this.isHoliday,
  });
}
