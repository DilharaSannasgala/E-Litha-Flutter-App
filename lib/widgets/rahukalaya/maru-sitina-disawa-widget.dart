import 'package:e_litha/utils/app-color.dart';
import 'dart:ui';
import 'package:flutter/material.dart';

class MaruSitinaDisawaWidget extends StatelessWidget {
  const MaruSitinaDisawaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<List<String>> data = [
      ['ඉරිදා :', 'උතුර', 'බ්‍රහස්පතින්දා :', 'දකුණ'],
      ['සඳුදා :', 'වයඹ', 'සිකුරාදා :', 'ගිනිකොණ'],
      ['අඟහරුවාදා :', 'බටහිර', 'සෙනසුරාදා :', 'නැගෙනහිර'],
      ['බදාදා :', 'නිරිත', '', ''],
    ];

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
        children: List.generate(data.length, (rowIndex) {
          final row = data[rowIndex];
          return TableRow(
            decoration: BoxDecoration(
              color: rowIndex % 2 == 0 ? AppColor.tableRowColor1 : AppColor.tableRowColor2,
            ),
            children: row.map((cell) => _buildTableCell(cell, isBold: cell.contains(':'))).toList(),
          );
        }),
      ),
        ),
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
