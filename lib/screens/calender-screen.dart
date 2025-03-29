import 'dart:convert';
import 'package:e_litha/models/holiday-info-model.dart';
import 'package:e_litha/models/moon-phase-info-model.dart';
import 'package:e_litha/models/special-date-info.dart';
import 'package:e_litha/utils/app-color.dart';
import 'package:e_litha/widgets/calender/calender-grid.dart';
import 'package:e_litha/widgets/calender/calender-header.dart';
import 'package:e_litha/widgets/calender/calender-month-navigation.dart';
import 'package:e_litha/widgets/calender/calender-moon-phase-widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:e_litha/utils/custom-date-time.dart';
import 'package:e_litha/utils/app-component.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late int currentMonth;
  late int currentYear;
  List<HolidayInfo> holidayData = [];
  List<SpecialDateInfo> specialDateData = [];
  List<MoonPhaseInfo> moonPhaseData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    currentMonth = now.month - 1;
    currentYear = now.year;
    _loadCalendarData();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CalendarHeader(
                        title: "Èk o¾Ykh - $currentYear",
                        onBackPressed: () => Navigator.pop(context),
                      ),
                      SizedBox(height: 16),
                      MonthNavigation(
                        month:
                            CustomDateTime().getCustomMonth(currentMonth + 1),
                        onPrevious: () {
                          setState(() {
                            if (currentMonth > 0) {
                              currentMonth--;
                            } else {
                              currentMonth = 11;
                              currentYear--;
                            }
                          });
                        },
                        onNext: () {
                          setState(() {
                            if (currentMonth < 11) {
                              currentMonth++;
                            } else {
                              currentMonth = 0;
                              currentYear++;
                            }
                          });
                        },
                      ),
                      SizedBox(height: 16),
                      CalendarGrid(
                        year: currentYear,
                        month: currentMonth,
                        holidays:
                            getHolidaysForMonth(currentYear, currentMonth),
                        specialDates:
                            getSpecialDatesForMonth(currentYear, currentMonth),
                      ),
                      SizedBox(height: 25),
                      MoonPhaseRow(
                        moonPhases:
                            getMoonPhasesForMonth(currentYear, currentMonth),
                      ),
                    ],
                  ),
          ),
        ),
      ),
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
