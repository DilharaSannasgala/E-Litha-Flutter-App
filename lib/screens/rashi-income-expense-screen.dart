import 'dart:convert';
import 'package:e_litha/utils/app-color.dart';
import 'package:e_litha/utils/app-component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RashiTableScreen extends StatefulWidget {
  const RashiTableScreen({Key? key}) : super(key: key);

  @override
  State<RashiTableScreen> createState() => _RashiTableScreenState();
}

class _RashiTableScreenState extends State<RashiTableScreen> {
  List<List<String>> tableData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRashiTableData();
  }

  Future<void> _loadRashiTableData() async {
    try {
      final jsonString =
          await rootBundle.loadString(AppComponents.rashiTableData);
      final jsonMap = json.decode(jsonString);
      setState(() {
        tableData = List<List<String>>.from(
          jsonMap['rashiTable'].map<List<String>>(
            (row) => List<String>.from(row),
          ),
        );
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Error loading Rashi table: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: AppBar(
        backgroundColor: AppColor.bgColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColor.btnTextColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'rdYs wh jeh',
          style: TextStyle(
            fontSize: 25,
            fontFamily: AppComponents.accentFont,
            color: AppColor.btnTextColor,
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        border: Border.all(
                          color: AppColor.borderLightColor,
                          width: 2,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            RashiTableWidget(tableData: tableData),
                            const SizedBox(height: 20),
                            Text(
                              'rdYs wh jeh u.ska fuu jifr Tnf.a rdYshg wkqj wh jeh fmkajhs',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: AppComponents.accentFont,
                                color: AppColor.btnSubTextColor,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class RashiTableWidget extends StatelessWidget {
  final List<List<String>> tableData;

  const RashiTableWidget({Key? key, required this.tableData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Table(
        border: TableBorder.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: const {
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(1),
          3: FlexColumnWidth(2),
          4: FlexColumnWidth(1),
          5: FlexColumnWidth(1),
        },
        children: List.generate(tableData.length, (rowIndex) {
          bool isHeader = rowIndex == 0;
          return TableRow(
            decoration: BoxDecoration(
              color: isHeader
                  ? AppColor.btnTextColor
                  : (rowIndex % 2 == 0
                      ? Colors.white
                      : const Color(0xFFF9F3E6)),
            ),
            children: List.generate(6, (colIndex) {
              return Container(
                height: isHeader ? 40 : 35,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                child: Text(
                  tableData[rowIndex][colIndex],
                  style: TextStyle(
                    fontFamily: AppComponents.accentFont,
                    fontSize: isHeader ? 18 : 16,
                    color: isHeader ? Colors.white : AppColor.btnTextColor,
                    fontWeight: isHeader || colIndex == 0 || colIndex == 3
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }),
          );
        }),
      ),
    );
  }
}

// Responsive Table Cell (optional alternative implementation)
class TableCellWidget extends StatelessWidget {
  final String text;
  final bool isHeader;
  final bool isRashiName;

  const TableCellWidget({
    Key? key,
    required this.text,
    this.isHeader = false,
    this.isRashiName = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isHeader ? 45 : 35,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: AppComponents.accentFont,
          fontSize: isHeader ? 20 : 16,
          color: isHeader ? Colors.white : AppColor.btnTextColor,
          fontWeight:
              isHeader || isRashiName ? FontWeight.bold : FontWeight.normal,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
