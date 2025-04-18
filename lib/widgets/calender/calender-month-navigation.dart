import 'package:flutter/material.dart';
import 'package:e_litha/utils/app-color.dart';
import 'package:e_litha/utils/app-component.dart';

class MonthNavigation extends StatelessWidget {
  final String month;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const MonthNavigation({
    Key? key,
    required this.month,
    required this.onPrevious,
    required this.onNext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        foregroundDecoration: BoxDecoration(
          border: Border.all(
            color: AppColor.borderLightColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColor.accentColor,
                size: 18,
              ),
              onPressed: onPrevious,
            ),
            Text(
              month,
              style: TextStyle(
                fontSize: 18,
                fontFamily: AppComponents.accentFont,
                color: AppColor.btnTextColor,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                color: AppColor.accentColor,
                size: 18,
              ),
              onPressed: onNext,
            ),
          ],
        ),
      ),
    );
  }
}
