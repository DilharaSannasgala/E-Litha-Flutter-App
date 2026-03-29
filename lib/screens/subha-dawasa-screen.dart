import 'dart:convert';
import 'package:e_litha/models/subha-dawasa-model.dart';
import 'package:e_litha/utils/app-color.dart';
import 'package:e_litha/widgets/subha_dawasa/subha-dawasa-card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/app-component.dart';

class SubhaDawasaScreen extends StatefulWidget {
  const SubhaDawasaScreen({super.key});

  @override
  State<SubhaDawasaScreen> createState() => _SubhaDawasaScreenState();
}

class _SubhaDawasaScreenState extends State<SubhaDawasaScreen> with SingleTickerProviderStateMixin {
  List<SubhaDawasaMonth> monthData = [];
  bool isLoading = false;
  
  final double maxTabletWidth = 700.0;

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _loadSubhaDawasaData();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
      _animationController.forward();
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
          'සුභ දවස් - 2026',
          style: TextStyle(
            fontSize: 25,
            
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
                      final double start = (index * 0.1).clamp(0.0, 0.8);
                      final double end = (start + 0.2).clamp(0.0, 1.0);
                      
                      final Animation<double> itemFade = Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                          parent: _animationController,
                          curve: Interval(start, end, curve: Curves.easeOut),
                        ),
                      );
                      
                      final Animation<Offset> itemSlide = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
                        CurvedAnimation(
                          parent: _animationController,
                          curve: Interval(start, end, curve: Curves.easeOut),
                        ),
                      );

                      return FadeTransition(
                        opacity: itemFade,
                        child: SlideTransition(
                          position: itemSlide,
                          child: CollapsibleSubhaDawasaCard(month: month),
                        ),
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }
}