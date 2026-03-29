import 'package:e_litha/utils/app-color.dart';
import 'package:flutter/material.dart';

class KalaHorawaWidget extends StatelessWidget {
  const KalaHorawaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<List<String>> data = [
      ['?????\n(???)', '?????', '?????', '???', '?????', '???????', '????', '???'],
      ['06.00-07.00', '???', '???????', '???', '???', '????', '????', '???'],
      ['07.00-08.00', '????', '???', '???', '???????', '???', '???', '????'],
      ['08.00-09.00', '???', '????', '????', '???', '???', '???????', '???'],
      ['09.00-10.00', '???????', '???', '???', '????', '????', '???', '???'],
      ['10.00-11.00', '???', '???', '???????', '???', '???', '????', '????'],
      ['11.00-12.00', '????', '????', '???', '???', '???????', '???', '???'],
      ['?????', '', '', '', '', '', '', ''],
      ['12.00-01.00', '???', '???', '????', '????', '???', '???', '???????'],
      ['01.00-02.00', '???', '???????', '???', '???', '????', '????', '???'],
    ];

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
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(1.2),
          3: FlexColumnWidth(1),
          4: FlexColumnWidth(1),
          5: FlexColumnWidth(1.2),
          6: FlexColumnWidth(1),
          7: FlexColumnWidth(1),
        },
        children: List.generate(data.length, (rowIndex) {
          final row = data[rowIndex];
          final isHeaderRow = rowIndex == 0 || rowIndex == 7;
          
          if (rowIndex == 7) {
             return TableRow(
              decoration: BoxDecoration(
                color: const Color(0xFFF9F3E6),
              ),
              children: [
                 _buildTableCell('?????', isHeader: true),
                 _buildTableCell(''),
                 _buildTableCell(''),
                 _buildTableCell(''),
                 _buildTableCell(''),
                 _buildTableCell(''),
                 _buildTableCell(''),
                 _buildTableCell(''),
              ]
             );
          }

          return TableRow(
            decoration: BoxDecoration(
              color: rowIndex == 0 
                  ? AppColor.accentColor.withOpacity(0.1) 
                  : (rowIndex % 2 == 0 ? Colors.white : const Color(0xFFF9F3E6)),
            ),
            children: row.map((cell) => _buildTableCell(cell, isHeader: isHeaderRow)).toList(),
          );
        }),
      ),
    );
  }

  Widget _buildTableCell(String text, {bool isHeader = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 1), 
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: AppColor.btnTextColor,
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
