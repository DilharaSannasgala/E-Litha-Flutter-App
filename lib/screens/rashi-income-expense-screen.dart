import 'dart:convert';
import 'package:e_litha/utils/app-color.dart';
import 'package:e_litha/utils/app-component.dart';
import 'package:e_litha/widgets/rashi/rashi-table-widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RashiTableScreen extends StatefulWidget {
  const RashiTableScreen({super.key});

  @override
  State<RashiTableScreen> createState() => _RashiTableScreenState();
}

class _RashiTableScreenState extends State<RashiTableScreen> with SingleTickerProviderStateMixin {
  List<List<String>> tableData = [];
  bool isLoading = true;

  final double maxTabletWidth = 800.0;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.05), end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _loadRashiTableData();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
      _animationController.forward();
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
          'රාශි අය වැය (2026/27)',
          style: TextStyle(
            fontSize: 25,
            
            color: AppColor.btnTextColor,
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: AppColor.accentColor))
          : Align(
              alignment: Alignment.topCenter,
              child: Container(
                constraints: BoxConstraints(maxWidth: maxTabletWidth),
                child: SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
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
                                      'රාශි අය වැය මගින් මෙම වසරෙ ඔබගේ රාශියට අනුව අය වැය පෙන්වයි',
                                      style: TextStyle(
                                        fontSize: 18,
                                        
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
                  ),
                ),
              ),
            ),
    );
  }
}
