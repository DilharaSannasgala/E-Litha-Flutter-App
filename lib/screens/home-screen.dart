import 'package:e_litha/utils/app-color.dart';
import 'package:e_litha/utils/app-component.dart';
import 'package:e_litha/utils/custom-date-time.dart';
import 'package:e_litha/widgets/home-calender-btn.dart';
import 'package:e_litha/widgets/home-nakath-btn.dart';
import 'package:e_litha/widgets/home-sun-btn.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final CustomDateTime customDateTime = CustomDateTime();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeaderSection(),
                SizedBox(height: 20),
                _buildYearButton(context),
                SizedBox(height: 20),
                _buildMainSectionTitle(),
                SizedBox(height: 20),
                _buildNakathButton(context),
                SizedBox(height: 20),
                _buildMainGridButtons(context),
              ],
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
          ),
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

  Widget _buildYearButton(BuildContext context) {
    return calenderButton(
      context,
      textTitle: 'Èk o¾Ykh',
      textYear: '2025',
      onPressed: () {
        // Add navigation logic
      },
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

  Widget _buildNakathButton(BuildContext context) {
    return nakathButton(
      context,
      textTitle: 'w¨;a wjqreÿ',
      textYear: 'kele;a iSÜgqj',
      onPressed: () {
        // Add navigation logic
      },
    );
  }

  Widget _buildMainGridButtons(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.8,
      mainAxisSpacing: 16,
      crossAxisSpacing: 20,
      children: [
        buildSunButton(context, 'iqN', 'ojia'),
        buildSunButton(context, 'iqN', 'uqyq¾;'),
        buildSunButton(context, 'rdyq', 'ld,h'),
        buildSunButton(context, 'rdYs', 'wh jeh'),
      ],
    );
  }
}
