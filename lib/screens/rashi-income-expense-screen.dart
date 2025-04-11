import 'dart:convert';
import 'package:e_litha/utils/app-color.dart';
import 'package:e_litha/utils/app-component.dart';
import 'package:e_litha/widgets/rashi/rashi-table-widget.dart';
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