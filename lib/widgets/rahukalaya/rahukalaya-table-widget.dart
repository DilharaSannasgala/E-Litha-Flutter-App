import 'package:e_litha/models/rahukalaya-model.dart';
import 'package:e_litha/utils/app-color.dart';
import 'dart:ui';
import 'package:flutter/material.dart';

class RahuKalayaTableWidget extends StatelessWidget {
  final List<RahuKalayaModel> rahuKalayaData;

  const RahuKalayaTableWidget({Key? key, required this.rahuKalayaData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.tableBorderColor, width: 1.5),
            borderRadius: BorderRadius.circular(8),
            color: AppColor.isDark ? Colors.black.withOpacity(0.2) : Colors.white.withOpacity(0.3),
          ),
          child: Table(
            border: TableBorder.all(color: AppColor.tableBorderColor, width: 1),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: const {
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(1.5),
          2: FlexColumnWidth(1.0),
          3: FlexColumnWidth(1.5),
          4: FlexColumnWidth(1.25),
        },
        children: List.generate(rahuKalayaData.length, (rowIndex) {
          final data = rahuKalayaData[rowIndex];
          return TableRow(
            decoration: BoxDecoration(
              color: rowIndex % 2 == 0 ? AppColor.tableRowColor1 : AppColor.tableRowColor2,
            ),
            children: [
              _buildTableCell(data.day, isDay: true),
              _buildTableCell(data.startTime),
              _buildTableCell(data.conjunction),
              _buildTableCell(data.endTime),
              _buildTableCell(data.until),
            ],
          );
        }),
      ),
        ),
      ),
    );
  }

  Widget _buildTableCell(String text, {bool isDay = false}) {
    return Container(
      height: 38,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
      child: Text(
        text,
        style: TextStyle(
          
          fontSize: isDay ? 16 : 15,
          color: AppColor.btnTextColor,
          fontWeight: isDay ? FontWeight.bold : FontWeight.normal,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
