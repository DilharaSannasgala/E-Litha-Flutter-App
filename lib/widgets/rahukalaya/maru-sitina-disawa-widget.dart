import 'package:e_litha/utils/app-color.dart';
import 'package:flutter/material.dart';

class MaruSitinaDisawaWidget extends StatelessWidget {
  const MaruSitinaDisawaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<List<String>> data = [
      ['????? :', '????', '???????: :', '????'],
      ['????? :', '???', '??????: :', '???????'],
      ['???: :', '?????', '???: :', '????????'],
      ['????? :', '?????', '', ''],
    ];

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Table(
        border: TableBorder.all(color: Colors.grey.shade300, width: 1),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: List.generate(data.length, (rowIndex) {
          final row = data[rowIndex];
          return TableRow(
            decoration: BoxDecoration(
              color: rowIndex % 2 == 0 ? Colors.white : const Color(0xFFF9F3E6),
            ),
            children: row.map((cell) => _buildTableCell(cell, isBold: cell.contains(':'))).toList(),
          );
        }),
      ),
    );
  }

  Widget _buildTableCell(String text, {bool isBold = false}) {
    return Container(
      height: 38,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15,
          color: AppColor.btnTextColor,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
