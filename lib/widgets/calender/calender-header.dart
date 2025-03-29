import 'package:flutter/material.dart';
import 'package:e_litha/utils/app-color.dart';
import 'package:e_litha/utils/app-component.dart';

class CalendarHeader extends StatelessWidget {
  final String title;
  final VoidCallback onBackPressed;

  const CalendarHeader({
    Key? key,
    required this.title,
    required this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColor.btnTextColor,
            size: 28,
          ),
          onPressed: onBackPressed,
        ),
        SizedBox(width: 16),
        Text(
          title,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: AppComponents.accentFont,
            color: AppColor.btnTextColor,
          ),
        ),
      ],
    );
  }
}