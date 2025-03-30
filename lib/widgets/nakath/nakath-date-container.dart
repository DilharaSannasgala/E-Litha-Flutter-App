import 'package:e_litha/utils/app-color.dart';
import 'package:e_litha/utils/app-component.dart';
import 'package:flutter/material.dart';

class DateContainer extends StatelessWidget {
  final String month;
  final String day;

  const DateContainer({
    Key? key,
    required this.month,
    required this.day,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
      child: Container(
        width: 75,
        height: 75,
        decoration: BoxDecoration(
          color: AppColor.iconBgColor,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              month,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: AppComponents.accentFont,
                color: AppColor.btnTextColor,
                height: 1.2,
              ),
            ),
            Text(
              day,
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
    );
  }
}