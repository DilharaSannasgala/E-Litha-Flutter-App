import 'package:e_litha/utils/app-color.dart';
import 'package:e_litha/utils/app-component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget nakathButton(
  BuildContext context, {
  required String textTitle,
  required String textYear,
  required VoidCallback onPressed,
}) {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(AppComponents.nakathBtnBg),
        fit: BoxFit.cover,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 10,
          offset: Offset(0, 5),
        ),
      ],
      borderRadius: BorderRadius.circular(14),
    ),
    foregroundDecoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: AppColor.borderLightColor,
        width: 2,
      ),
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColor.isDark ? Colors.black.withOpacity(0.85) : Colors.transparent,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 65,
                        height: 65,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColor.accentColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          AppComponents.nakathIcon,
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              textTitle,
                              style: TextStyle(
                                color: AppColor.btnTextColor.withOpacity(0.8),
                                fontSize: 18,
                                height: 1.2,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              textYear,
                              style: TextStyle(
                                color: AppColor.btnTextColor,
                                fontSize: 34,
                                height: 1.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.accentColor,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColor.cardColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}


