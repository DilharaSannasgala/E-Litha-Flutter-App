import 'package:e_litha/models/moon-phase-info-model.dart';
import 'package:e_litha/utils/app-color.dart';
import 'package:e_litha/utils/app-component.dart';
import 'package:e_litha/utils/custom-date-time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MoonPhaseRow extends StatelessWidget {
  final List<MoonPhaseInfo> moonPhases;

  const MoonPhaseRow({
    Key? key,
    required this.moonPhases,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (moonPhases.isEmpty) {
      return SizedBox.shrink();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: moonPhases
          .map((moonPhase) => MoonPhaseItem(
                phase: moonPhase.phase,
                date: moonPhase.day.toString(),
                month: CustomDateTime().getCustomMonthShort(moonPhase.month),
                name: moonPhase.name,
              ))
          .toList(),
    );
  }
}

class MoonPhaseItem extends StatelessWidget {
  final String phase;
  final String date;
  final String month;
  final String name;

  const MoonPhaseItem({
    Key? key,
    required this.phase,
    required this.date,
    required this.month,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: _getMoonPhaseWidget(),
          ),
          SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                month,
                style: TextStyle(
                  fontSize: 16,
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
        ],
      ),
    );
  }

  Widget _getMoonPhaseWidget() {
    switch (phase) {
      case "half_left":
        return Container(
          width: 30,
          height: 30,
          child: SvgPicture.asset(
            AppComponents.halfLeftMoon,
          ),
        );
      case "half_right":
        return Container(
          width: 30,
          height: 30,
          child: SvgPicture.asset(
            AppComponents.halfRightMoon,
          ),
        );
      case "none":
        return Container(
          width: 35,
          height: 35,
          child: SvgPicture.asset(
            AppComponents.noMoon,
          ),
        );
      default:
        return Container();
    }
  }
}
