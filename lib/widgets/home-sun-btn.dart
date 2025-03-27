import 'package:e_litha/utils/app-color.dart';
import 'package:e_litha/utils/app-component.dart';
import 'package:flutter/material.dart';

Widget buildSunButton(
    BuildContext context, String firstLine, String secondLine) {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(AppComponents.sunBtnBg),
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 10,
          offset: Offset(0, 5),
        ),
      ],
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          // Add navigation logic
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  Text(
                    firstLine,
                    style: TextStyle(
                      fontFamily: AppComponents.accentFont,
                      color: AppColor.btnTextColor,
                      fontSize: 22,
                      height: 1.2,
                    ),
                  ),
                  Text(
                    secondLine,
                    style: TextStyle(
                      fontFamily: AppComponents.accentFont,
                      color: AppColor.btnTextColor,
                      fontSize: 30,
                      height: 1.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.accentColor,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
