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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildWeekdayRow(),
            SizedBox(height: 16),
            _buildDaysGrid(),
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
                    fontSize: 18,
                    color: AppColor.btnTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ))
          .toList(),
    );
  }

  Widget _buildDaysGrid() {
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

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1.0,
      ),
      itemCount: allDays.length,
      itemBuilder: (context, index) {
        final day = allDays[index];
        return _buildDayCell(day);
      },
    );
  }

  Widget _buildDayCell(CalendarDay day) {
    Color textColor = AppColor.btnTextColor;
    Widget background = Container();
    Widget? specialIndicator;

    if (day.isPreviousMonth || day.isNextMonth) {
      textColor = AppColor.btnTextColor.withOpacity(0.3);
    }

    if (day.isToday) {
      background = Container(
          decoration: BoxDecoration(
        color: AppColor.btnTextColor,
        borderRadius: BorderRadius.circular(12),
      ));
      textColor = Colors.white;
    }

    // Add orange circle for special dates
    if (day.isSpecialDay) {
      background = Container(
          decoration: BoxDecoration(
        color: AppColor.accentColor,
        borderRadius: BorderRadius.circular(360),
      ));
      textColor = Colors.white;
    }

    // Add orange circle border for holidays
    if (day.isHoliday) {
      background = Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.accentColor, width: 5),
          shape: BoxShape.circle,
        ),
      );
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        background,
        Text(
          day.day.toString(),
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: day.isToday || day.isSpecialDay
                ? FontWeight.bold
                : FontWeight.normal,
            fontFamily: AppComponents.accentFont,
          ),
        ),
      ],
    );
  }
}
