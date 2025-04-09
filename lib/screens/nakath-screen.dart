import 'dart:convert';
import 'package:e_litha/models/special-nakath-date-info.dart';
import 'package:e_litha/utils/app-color.dart';
import 'package:e_litha/utils/app-component.dart';
import 'package:e_litha/widgets/nakath/nakath-card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Main screen widget
class NakathScreen extends StatefulWidget {
  const NakathScreen({Key? key}) : super(key: key);

  @override
  State<NakathScreen> createState() => _NakathScreenState();
}

class _NakathScreenState extends State<NakathScreen> {
  List<SpecialNakathDateInfo> specialDates = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNakathData();
  }

  Future<void> _loadNakathData() async {
    try {
      final String jsonString =
          await rootBundle.loadString(AppComponents.nakathData);
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      setState(() {
        specialDates = (jsonData['specialDates'] as List?)
                ?.map((item) => SpecialNakathDateInfo.fromJson(item))
                .toList() ??
            [];
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading nakath data: $e');
      setState(() => isLoading = false);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load nakath data: ${e.toString()}'),
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColor.btnTextColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "kele;a iSÜgqj - 2025",
          style: TextStyle(
            fontSize: 25,
            fontFamily: AppComponents.accentFont,
            color: AppColor.btnTextColor,
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppColor.accentColor))
          : SafeArea(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: specialDates.length,
                itemBuilder: (context, index) {
                  return CollapsibleNakathCard(
                      specialDate: specialDates[index]);
                },
              ),
            ),
    );
  }
}

