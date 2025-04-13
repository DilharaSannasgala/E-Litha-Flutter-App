import 'package:e_litha/models/calender-day-odel.dart';
import 'package:e_litha/models/holiday-info-model.dart';
import 'package:e_litha/models/special-date-info.dart';
import 'package:flutter/material.dart';
import 'package:e_litha/utils/app-color.dart';
import 'package:e_litha/utils/app-component.dart';

class CalendarGrid extends StatelessWidget {
  final int year;
  final int month;
  final List<HolidayInfo> holidays;
  final List<SpecialDateInfo> specialDates;

  const CalendarGrid({
    Key? key,
    required this.year,
    required this.month,
    required this.holidays,
    required this.specialDates,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen orientation and dimensions
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width:
          isLandscape ? screenWidth * 0.95 : null, // Adjust width for landscape
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
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildWeekdayRow(),
            SizedBox(height: 8),
            Flexible(
              child: _buildDaysGrid(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeekdayRow() {
    final List<String> weekdays = ['b', 'i', 'wÕ', 'n', 'n%y', 'is', 'fi'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: weekdays
          .map((day) => Expanded(
                child: Text(
                  day,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: AppComponents.accentFont,
                    fontSize: 16,
                    color: AppColor.btnTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ))
          .toList(),
    );
  }

  Widget _buildDaysGrid(BuildContext context) {
    // Get screen orientation
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final DateTime firstDayOfMonth = DateTime(year, month + 1, 1);
    final int daysInMonth = DateTime(year, month + 2, 0).day;
    final int startWeekday =
        firstDayOfMonth.weekday % 7; // 0-indexed, Sunday = 0

    // Previous month's overflow days
    final int daysInPrevMonth = DateTime(year, month + 1, 0).day;
    final List<int> prevMonthDays = List.generate(
        startWeekday, (index) => daysInPrevMonth - startWeekday + index + 1);

    // Current month's days
    final List<int> currentMonthDays =
        List.generate(daysInMonth, (index) => index + 1);

    // Next month's overflow days
    final int totalCells = 42; // 6 rows of 7 days
    final int nextMonthDaysCount =
        totalCells - prevMonthDays.length - currentMonthDays.length;
    final List<int> nextMonthDays =
        List.generate(nextMonthDaysCount, (index) => index + 1);

    final List<CalendarDay> allDays = [
      ...prevMonthDays.map((day) => CalendarDay(day, isPreviousMonth: true)),
      ...currentMonthDays.map((day) {
        final bool isHoliday = holidays.any((h) => h.day == day);
        final bool isSpecialDay = specialDates.any((s) => s.day == day);
        final bool isToday = DateTime.now().year == year &&
            DateTime.now().month == month + 1 &&
            DateTime.now().day == day;

        return CalendarDay(
          day,
          isHoliday: isHoliday,
          isSpecialDay: isSpecialDay,
          isToday: isToday,
        );
      }),
      ...nextMonthDays.map((day) => CalendarDay(day, isNextMonth: true)),
    ];

    // Use a different aspect ratio for landscape mode
    final childAspectRatio = isLandscape ? 2.0 : 1.0;

    return LayoutBuilder(builder: (context, constraints) {
      return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          childAspectRatio: childAspectRatio,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
        ),
        itemCount: allDays.length,
        itemBuilder: (context, index) {
          final day = allDays[index];
          return _buildDayCell(day);
        },
      );
    });
  }

  Widget _buildDayCell(CalendarDay day) {
    Color textColor = AppColor.btnTextColor;
    Widget background = Container();

    if (day.isPreviousMonth || day.isNextMonth) {
      textColor = AppColor.btnTextColor.withOpacity(0.3);
    }

    // Handle combinations of today, holiday, and special day
    if (day.isToday && day.isHoliday) {
      // When today is also a holiday
      background = Container(
        decoration: BoxDecoration(
          color: AppColor.btnTextColor,
          border: Border.all(color: AppColor.accentColor, width: 3),
          shape: BoxShape.circle,
        ),
      );
      textColor = Colors.white;
    } else if (day.isToday && day.isSpecialDay) {
      // When today is also a special day
      background = Container(
        decoration: BoxDecoration(
          color: AppColor.accentColor,
          border: Border.all(color: AppColor.btnTextColor, width: 3),
          shape: BoxShape.circle,
        ),
      );
      textColor = Colors.white;
    } else if (day.isToday) {
      // Just today
      background = Container(
        decoration: BoxDecoration(
          color: AppColor.btnTextColor,
          shape: BoxShape.circle,
        ),
      );
      textColor = Colors.white;
    } else if (day.isHoliday) {
      // Just holiday
      background = Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.accentColor, width: 3),
          shape: BoxShape.circle,
        ),
      );
    } else if (day.isSpecialDay) {
      // Just special day
      background = Container(
        decoration: BoxDecoration(
          color: AppColor.accentColor,
          shape: BoxShape.circle,
        ),
      );
      textColor = Colors.white;
    }

    return Center(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Stack(
          alignment: Alignment.center,
          children: [
            background,
            Text(
              day.day.toString(),
              style: TextStyle(
                color: textColor,
                fontSize: 14,
                fontWeight: day.isToday || day.isSpecialDay || day.isHoliday
                    ? FontWeight.bold
                    : FontWeight.normal,
                fontFamily: AppComponents.accentFont,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
