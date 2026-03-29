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
  
  // Define maximum tablet vertical width
  final double maxTabletWidth = 700.0;

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
          "නැකැත් සීට්ටුව - 2026",
          style: TextStyle(
            fontSize: 25,
            
            color: AppColor.btnTextColor,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: AppColor.btnTextColor),
            tooltip: 'Info',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  backgroundColor: Colors.white,
                  title: Text(
                    "සැලකිය යුතු",
                    style: TextStyle(
                      
                      fontSize: 20,
                      color: AppColor.btnTextColor,
                    ),
                  ),
                  content: Text(
                    "මෙම නැකැත් වේලාවන් දැනට සම්මත ඔරලෝසු වේලාවෙන් සකස් කර ඇති අතර මෙම වේලාවන් ශ‍්‍රී ලංකාවේ සියලූ ප‍්‍රදේශවලට නොවෙනස්ව භාවිත කල හැකිය-",
                    style: TextStyle(
                      
                      fontSize: 16,
                      color: AppColor.btnSubTextColor,
                      height: 1.4,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        "වසන්න",
                        style: TextStyle(
                          color: AppColor.btnTextColor,
                          
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: maxTabletWidth),
          child: isLoading
              ? const CircularProgressIndicator(color: AppColor.accentColor)
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
        ),
      ),
    );
  }
}