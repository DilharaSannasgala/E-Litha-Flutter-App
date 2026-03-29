import 'package:e_litha/utils/app-color.dart';
import 'package:flutter/material.dart';

class KalaHorawaWidget extends StatelessWidget {
  const KalaHorawaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<List<String>> data = [
      ['වේලාව\n(පෙ.ව)', 'ඉරිදා', 'සඳුදා', 'අඟහ.', 'බදාදා', 'බ්‍රහස්ප.', 'සිකුරා.', 'සෙන.'],
      ['06.00-07.00', 'රවි', 'සඳු', 'කුජ', 'බුධ', 'ගුරු', 'සිකු', 'ශනි'],
      ['07.00-08.00', 'සිකු', 'ශනි', 'රවි', 'සඳු', 'කුජ', 'බුධ', 'ගුරු'],
      ['08.00-09.00', 'බුධ', 'ගුරු', 'සිකු', 'ශනි', 'රවි', 'සඳු', 'කුජ'],
      ['09.00-10.00', 'සඳු', 'කුජ', 'බුධ', 'ගුරු', 'සිකු', 'ශනි', 'රවි'],
      ['10.00-11.00', 'ශනි', 'රවි', 'සඳු', 'කුජ', 'බුධ', 'ගුරු', 'සිකු'],
      ['11.00-12.00', 'ගුරු', 'සිකු', 'ශනි', 'රවි', 'සඳු', 'කුජ', 'බුධ'],
      ['ප.ව', '', '', '', '', '', '', ''],
      ['12.00-01.00', 'කුජ', 'බුධ', 'ගුරු', 'සිකු', 'ශනි', 'රවි', 'සඳු'],
      ['01.00-02.00', 'රවි', 'සඳු', 'කුජ', 'බුධ', 'ගුරු', 'සිකු', 'ශනි'],
      ['02.00-03.00', 'සිකු', 'ශනි', 'රවි', 'සඳු', 'කුජ', 'බුධ', 'ගුරු'],
      ['03.00-04.00', 'බුධ', 'ගුරු', 'සිකු', 'ශනි', 'රවි', 'සඳු', 'කුජ'],
      ['04.00-05.00', 'සඳු', 'කුජ', 'බුධ', 'ගුරු', 'සිකු', 'ශනි', 'රවි'],
      ['05.00-06.00', 'ශනි', 'රවි', 'සඳු', 'කුජ', 'බුධ', 'ගුරු', 'සිකු'],
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
                 _buildTableCell('ප.ව', isHeader: true),
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
