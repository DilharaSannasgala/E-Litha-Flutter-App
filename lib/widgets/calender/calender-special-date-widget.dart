import 'package:e_litha/models/holiday-info-model.dart';
import 'package:e_litha/models/special-date-info.dart';
import 'package:e_litha/utils/app-color.dart';
import 'package:e_litha/utils/app-component.dart';
import 'package:e_litha/utils/custom-date-time.dart';
import 'package:flutter/material.dart';

class SpecialDatesInfo extends StatelessWidget {
  final List<SpecialDateInfo> specialDates;
  final List<HolidayInfo> holidays;

  const SpecialDatesInfo({
    Key? key,
    required this.specialDates,
    required this.holidays,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Combine and sort all special dates and holidays
    final allEvents = [
      ...specialDates.map((e) => _EventItem(
            date: e.day,
            month: e.month,
            description: e.description,
            isHoliday: false,
          )),
      ...holidays.map((e) => _EventItem(
            date: e.day,
            month: e.month,
            description: e.description,
            isHoliday: true,
          )),
    ]..sort((a, b) => a.date.compareTo(b.date));

    if (allEvents.isEmpty) {
      return SizedBox.shrink();
    }

    return Column(
      children: [
        for (final event in allEvents) ...[
          SpecialDateCard(
            date: event.date.toString(),
            month: event.month,
            description: event.description,
            isHoliday: event.isHoliday,
          ),
          SizedBox(height: 10),
        ],
      ],
    );
  }
}

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

class SpecialDateCard extends StatelessWidget {
  final String date;
  final int month;
  final String description;
  final bool isHoliday;

  const SpecialDateCard({
    Key? key,
    required this.date,
    required this.month,
    required this.description,
    required this.isHoliday,
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
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColor.iconBgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      CustomDateTime().getCustomMonthShort(month),
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: AppComponents.accentFont,
                        color: AppColor.btnTextColor,
                        height: 1.0,
                      ),
                    ),
                    Text(
                      date,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppComponents.accentFont,
                        color: AppColor.btnTextColor,
                        height: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: AppComponents.accentFont,
                      color: AppColor.btnTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
