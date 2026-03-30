import 'dart:convert';
import 'package:e_litha/models/annual-summary-model.dart';
import 'package:e_litha/utils/app-color.dart';
import 'package:e_litha/utils/app-component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AnnualSummaryScreen extends StatefulWidget {
  const AnnualSummaryScreen({super.key});

  @override
  State<AnnualSummaryScreen> createState() => _AnnualSummaryScreenState();
}

class _AnnualSummaryScreenState extends State<AnnualSummaryScreen> with SingleTickerProviderStateMixin {
  late AnnualSummaryModel summaryData;
  bool isLoading = true;
  String? errorMessage;
  
  final double maxTabletWidth = 700.0;

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
    loadData();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> loadData() async {
    try {
      final String summaryJsonString =
          await rootBundle.loadString(AppComponents.annualSummaryData);
      final Map<String, dynamic> summaryJson = json.decode(summaryJsonString);

      setState(() {
        summaryData = AnnualSummaryModel.fromJson(summaryJson);
        isLoading = false;
      });
      _animationController.forward();
    } catch (e) {
      setState(() {
        errorMessage = 'Error loading data: $e';
        isLoading = false;
      });
      print('Error loading Annual Summary data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: AppColor.accentColor,
              ),
            )
          : errorMessage != null
              ? Center(
                  child: Text(
                    errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              : CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      backgroundColor: AppColor.bgColor,
                      expandedHeight: 200.0,
                      floating: false,
                      pinned: true,
                      elevation: 0,
                      leading: IconButton(
                        icon: Icon(Icons.arrow_back, color: AppColor.btnTextColor),
                        onPressed: () => Navigator.pop(context),
                      ),
                      flexibleSpace: FlexibleSpaceBar(
                        title: Text(
                          "සංවත්සර පලාපල",
                          style: TextStyle(
                            fontSize: 22,
                            color: AppColor.btnTextColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        centerTitle: true,
                        background: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppColor.accentColor.withOpacity(0.3),
                                AppColor.bgColor,
                              ],
                            ),
                          ),
                          child: Icon(
                            Icons.wb_sunny_rounded,
                            size: 100,
                            color: AppColor.accentColor.withOpacity(0.2),
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SafeArea(
                        top: false,
                        child: Center(
                          child: Container(
                            constraints: BoxConstraints(maxWidth: maxTabletWidth),
                            child: FadeTransition(
                              opacity: _fadeAnimation,
                              child: SlideTransition(
                                position: _slideAnimation,
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: _buildSummarySection(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }

  Widget _buildSummarySection() {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.cardColor,
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
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColor.btnTextColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            width: double.infinity,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  summaryData.title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColor.cardColor,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Text(
                  summaryData.content,
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColor.btnSubTextColor,
                    height: 1.8,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



