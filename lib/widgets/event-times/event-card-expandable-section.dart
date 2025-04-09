import 'package:e_litha/models/event-time-model.dart';
import 'package:e_litha/utils/app-color.dart';
import 'package:e_litha/utils/app-component.dart';
import 'package:e_litha/utils/custom-date-time.dart';
import 'package:flutter/material.dart';

class EventDateRow extends StatelessWidget {
  final EventDate date;

  const EventDateRow({
    Key? key,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date container
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColor.iconBgColor,
                width: 2,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  CustomDateTime().getCustomMonthShort(date.month),
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: AppComponents.accentFont,
                    color: AppColor.btnTextColor,
                    height: 1.0,
                  ),
                ),
                Text(
                  date.day.toString(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontFamily: AppComponents.accentFont,
                    fontWeight: FontWeight.bold,
                    color: AppColor.btnTextColor,
                    height: 1.0,
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
                  fontSize: 18,
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