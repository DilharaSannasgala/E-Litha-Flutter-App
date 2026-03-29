import 'dart:convert';
import 'package:e_litha/models/subha-dawasa-model.dart';
import 'package:e_litha/utils/app-color.dart';
import 'package:e_litha/widgets/subha_dawasa/subha-dawasa-card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/app-component.dart';

class SubhaDawasaScreen extends StatefulWidget {
  const SubhaDawasaScreen({Key? key}) : super(key: key);

  @override
  State<SubhaDawasaScreen> createState() => _SubhaDawasaScreenState();
}

class _SubhaDawasaScreenState extends State<SubhaDawasaScreen> {
  List<SubhaDawasaMonth> monthData = [];
  bool isLoading = false;
  
  final double maxTabletWidth = 700.0;

  @override
  void initState() {
    super.initState();
    _loadSubhaDawasaData();
  }

  Future<void> _loadSubhaDawasaData() async {
    try {
      setState(() => isLoading = true);
      final String jsonString = await rootBundle.loadString(AppComponents.subhaDawasaData);
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      setState(() {
        monthData = (jsonData['months'] as List?)
                ?.map((item) => SubhaDawasaMonth.fromJson(item))
                .toList() ??
            [];
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading subha dawasa data: $e');
      setState(() => isLoading = false);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load subha dawasa data: ${e.toString()}'),
            duration: const Duration(seconds: 5),
          ),
        );
      }
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
          'iqN ojia - 2026',
          style: TextStyle(
            fontSize: 25,
            fontFamily: AppComponents.accentFont,
            color: AppColor.btnTextColor,
          ),
        ),
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: maxTabletWidth),
          child: isLoading
              ? const CircularProgressIndicator(color: AppColor.accentColor)
              : SafeArea(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: monthData.length,
                    itemBuilder: (context, index) {
                      final month = monthData[index];
                      return CollapsibleSubhaDawasaCard(month: month);
                    },
                  ),
                ),
        ),
      ),
    );
  }
}