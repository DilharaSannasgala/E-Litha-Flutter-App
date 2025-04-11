import 'package:e_litha/screens/event-time-screen.dart';
import 'package:e_litha/screens/rahu-kalaya-screen.dart';
import 'package:e_litha/screens/rashi-income-expense-screen.dart';
import 'package:e_litha/utils/app-color.dart';
import 'package:e_litha/utils/app-component.dart';
import 'package:e_litha/utils/custom-date-time.dart';
import 'package:e_litha/widgets/home/home-calender-btn.dart';
import 'package:e_litha/widgets/home/home-nakath-btn.dart';
import 'package:e_litha/widgets/home/home-sun-btn.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final CustomDateTime customDateTime = CustomDateTime();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                int columnsCount = 2; // Default for mobile
                if (constraints.maxWidth > 600 && constraints.maxWidth <= 900) {
                  columnsCount = 3; // For tablets in portrait
                } else if (constraints.maxWidth > 900) {
                  columnsCount = 4; // For tablets in landscape and larger
                }
                // Maximum content width for tablets and larger screens
                double maxContentWidth = 900;
                double currentWidth = constraints.maxWidth;
                double usedWidth = currentWidth > maxContentWidth
                    ? maxContentWidth
                    : currentWidth;
                return Center(
                  child: Container(
                    width: usedWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildHeaderSection(),
                        SizedBox(height: 20),
                        calenderButton(
                          context,
                          textTitle: 'Èk o¾Ykh',
                          textYear: "2025",
                          onPressed: () {
                            Navigator.pushNamed(context, '/calendar');
                          },
                        ),
                        SizedBox(height: 20),
                        _buildMainSectionTitle(),
                        SizedBox(height: 20),
                        nakathButton(
                          context,
                          textTitle: 'w¨;a wjqreÿ',
                          textYear: 'kele;a iSÜgqj',
                          onPressed: () {
                            Navigator.pushNamed(context, '/nakath');
                          },
                        ),
                        SizedBox(height: 20),
                        GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: columnsCount,
                              childAspectRatio: 1.5,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                            ),
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              List<Map<String, dynamic>> buttonData = [
                                {
                                  "first": "iqN",
                                  "second": "ojia",
                                  "screen": EventTimeScreen()
                                },
                                {
                                  "first": "iqN",
                                  "second": "uqyq¾",
                                  "screen": EventTimeScreen()
                                },
                                {
                                  "first": "rdyq",
                                  "second": "ld,h",
                                  "screen": RahuKalayaScreen()
                                },
                                {
                                  "first": "rdYs",
                                  "second": "wh jeh",
                                  "screen": RashiTableScreen()
                                },
                              ];

                              return buildSunButton(
                                context,
                                buttonData[index]["first"],
                                buttonData[index]["second"],
                                buttonData[index]["screen"],
                              );
                            }),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    DateTime now = DateTime.now();
    String customDay = customDateTime.getCustomDay(now.weekday);
    String customMonth = customDateTime.getCustomMonth(now.month);
    int customYear = customDateTime.getCustomYear(now.year);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'wdhqfndajka',
          style: TextStyle(
              fontFamily: AppComponents.titleFont,
              fontSize: 50,
              color: AppColor.titleTextColor,
              fontWeight: FontWeight.w600,
              letterSpacing: 1),
        ),
        Text(
          '${now.day} ${customDay} ${customMonth} ${now.year} \$ Y%S nqoaO j¾Y ${customYear}',
          style: TextStyle(
            fontFamily: AppComponents.subTextFont,
            fontSize: 20,
            color: AppColor.titleTextColor,
          ),
        ),
      ],
    );
  }

  Widget _buildMainSectionTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, bottom: 10.0, top: 15.0),
      child: Text(
        'm,dm, ,s;',
        style: TextStyle(
          fontSize: 28,
          fontFamily: AppComponents.accentFont,
          color: AppColor.subTextColor,
        ),
      ),
    );
  }
}
