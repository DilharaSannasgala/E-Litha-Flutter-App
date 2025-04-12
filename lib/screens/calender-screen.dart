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

class _CalendarScreenState extends State<CalendarScreen> {
  late PageController _pageController;
  late int currentMonth;
  late int currentYear;
  List<HolidayInfo> holidayData = [];
  List<SpecialDateInfo> specialDateData = [];
  List<MoonPhaseInfo> moonPhaseData = [];
  bool isLoading = true;

  // Constants for responsive layout
  static const double _mobileBreakpoint = 600;
  static const double _maxCalendarWidth = 1000;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    currentMonth = now.month - 1; // 0-indexed month
    currentYear = now.year;
    
    // Initialize the PageController with the current month
    _pageController = PageController(initialPage: currentMonth);
    
    _loadCalendarData();
  }

  @override
  void dispose() {
    _pageController.dispose();
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

  // Navigate to the previous month if possible (within the current year)
  void _previousMonth() {
    if (currentMonth > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // Navigate to the next month if possible (within the current year)
  void _nextMonth() {
    if (currentMonth < 11) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth > _mobileBreakpoint;

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
      body: SingleChildScrollView(
        child: SafeArea(
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(color: AppColor.accentColor))
              : _buildResponsiveLayout(context, isWideScreen),
        ),
      ),
    );
  }

  Widget _buildResponsiveLayout(BuildContext context, bool isWideScreen) {
    if (!isWideScreen) {
      // Mobile layout (stacked)
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCalendarContainer(),
              SizedBox(height: 16),
              _buildSpecialDatesInfo(),
            ],
          ),
        ),
      );
    } else {
      // Desktop/tablet layout (side by side)
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Calendar container (left side)
            Flexible(
              flex: 3,
              child: Container(
                constraints: BoxConstraints(maxWidth: _maxCalendarWidth),
                child: _buildCalendarContainer(),
              ),
            ),
            SizedBox(width: 16),
            // Special dates (right side)
            Flexible(
              flex: 2,
              child: _buildSpecialDatesInfo(),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildCalendarContainer() {
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
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            MonthNavigation(
              month: CustomDateTime().getCustomMonth(currentMonth + 1),
              onPrevious: _previousMonth,
              onNext: _nextMonth,
              canGoBack: currentMonth > 0,
              canGoForward: currentMonth < 11,
            ),
            SizedBox(height: 16),
            Container(
              height: 400, // Set a fixed height for the PageView
              child: PageView.builder(
                controller: _pageController,
                itemCount: 12, // 12 months in a year
                onPageChanged: (index) {
                  setState(() {
                    currentMonth = index;
                  });
                },
                physics: currentMonth <= 0 || currentMonth >= 11
                    ? NeverScrollableScrollPhysics() // Disable scrolling at boundaries
                    : BouncingScrollPhysics(), // Otherwise enable scrolling
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      CalendarGrid(
                        year: currentYear,
                        month: index,
                        holidays: getHolidaysForMonth(currentYear, index),
                        specialDates: getSpecialDatesForMonth(currentYear, index),
                      ),
                      SizedBox(height: 25),
                      MoonPhaseRow(
                        moonPhases: getMoonPhasesForMonth(currentYear, index),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecialDatesInfo() {
    return SpecialDatesInfo(
      specialDates: getSpecialDatesForMonth(currentYear, currentMonth),
      holidays: getHolidaysForMonth(currentYear, currentMonth),
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