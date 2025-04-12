import 'dart:convert';
import 'package:e_litha/models/annual-prediction-model.dart';
import 'package:e_litha/models/annual-summary-model.dart';
import 'package:e_litha/utils/app-color.dart';
import 'package:e_litha/utils/app-component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AnnualSummaryScreen extends StatefulWidget {
  const AnnualSummaryScreen({Key? key}) : super(key: key);

  @override
  State<AnnualSummaryScreen> createState() => _AnnualSummaryScreenState();
}

class _AnnualSummaryScreenState extends State<AnnualSummaryScreen> {
  late AnnualSummaryModel summaryData;
  late List<AnnualPredictionModel> predictionsData;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final String summaryJsonString =
          await rootBundle.loadString(AppComponents.annualSummaryData);
      final Map<String, dynamic> summaryJson = json.decode(summaryJsonString);

      final String predictionsJsonString =
          await rootBundle.loadString(AppComponents.annualPredictionsData);
      final List<dynamic> predictionsJson = json.decode(predictionsJsonString);

      setState(() {
        summaryData = AnnualSummaryModel.fromJson(summaryJson);
        predictionsData = predictionsJson
            .map<AnnualPredictionModel>(
                (item) => AnnualPredictionModel.fromJson(item))
            .toList();
        isLoading = false;
      });
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
      appBar: AppBar(
        backgroundColor: AppColor.bgColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColor.btnTextColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'ixj;air m,dm,',
          style: TextStyle(
            fontSize: 25,
            fontFamily: AppComponents.accentFont,
            color: AppColor.btnTextColor,
          ),
        ),
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: AppColor.accentColor,
              ))
            : errorMessage != null
                ? Center(
                    child: Text(
                      errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _buildSummarySection(),
                        const SizedBox(height: 20),
                        _buildPredictionsSection(),
                      ],
                    ),
                  ),
      ),
    );
  }

  Widget _buildSummarySection() {
    return Container(
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
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColor.btnTextColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
            ),
            height: 50,
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(
              summaryData.title,
              style: const TextStyle(
                fontSize: 22,
                fontFamily: AppComponents.accentFont,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  summaryData.content,
                  style: const TextStyle(
                    fontSize: 20,
                    fontFamily: AppComponents.accentFont,
                    color: AppColor.btnSubTextColor,
                    height: 1.5,
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

  Widget _buildPredictionsSection() {
    return Container(
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
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColor.btnTextColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
            ),
            height: 50,
            width: double.infinity,
            alignment: Alignment.center,
            child: const Text(
              'l%s-j-2025 ixj;air m,dm,',
              style: TextStyle(
                fontSize: 22,
                fontFamily: AppComponents.accentFont,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: List.generate(
                predictionsData.length,
                (index) => Column(
                  children: [
                    Text(
                      predictionsData[index].content,
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: AppComponents.accentFont,
                        color: AppColor.btnSubTextColor,
                        height: 1.5,
                      ),
                      textAlign: index == predictionsData.length - 1
                          ? TextAlign.start
                          : TextAlign.justify,
                    ),
                    if (index < predictionsData.length - 1)
                      const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
