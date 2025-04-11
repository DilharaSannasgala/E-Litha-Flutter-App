import 'package:e_litha/models/rahukalaya-model.dart';
import 'package:e_litha/utils/app-color.dart';
import 'package:e_litha/utils/app-component.dart';
import 'package:flutter/material.dart';

class RahuKalayaTableWidget extends StatelessWidget {
  final List<RahuKalayaModel> rahuKalayaData;

  const RahuKalayaTableWidget({Key? key, required this.rahuKalayaData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Table(
        border: TableBorder.all(color: Colors.grey.shade300, width: 1),
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
              color: rowIndex % 2 == 0 ? Colors.white : const Color(0xFFF9F3E6),
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
          fontFamily: AppComponents.accentFont,
          fontSize: isDay ? 16 : 15,
          color: AppColor.btnTextColor,
          fontWeight: isDay ? FontWeight.bold : FontWeight.normal,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
