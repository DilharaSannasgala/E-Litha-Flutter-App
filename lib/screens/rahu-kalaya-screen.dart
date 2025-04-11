import 'dart:convert';
import 'package:e_litha/models/rahukalaya-model.dart';
import 'package:e_litha/utils/app-color.dart';
import 'package:e_litha/utils/app-component.dart';
import 'package:e_litha/widgets/rahukalaya/rahukalaya-table-widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RahuKalayaScreen extends StatefulWidget {
  const RahuKalayaScreen({Key? key}) : super(key: key);

  @override
  State<RahuKalayaScreen> createState() => _RahuKalayaScreenState();
}

class _RahuKalayaScreenState extends State<RahuKalayaScreen> {
  List<RahuKalayaModel> rahuKalayaData = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final String jsonString =
          await rootBundle.loadString(AppComponents.rahuKalayaData);
      final List<dynamic> jsonData = json.decode(jsonString);

      setState(() {
        rahuKalayaData = jsonData
            .map<RahuKalayaModel>((row) => RahuKalayaModel.fromJson(row))
            .toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error loading data: $e';
        isLoading = false;
      });
      print('Error loading Rahu Kalaya data: $e');
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
          'rdyq ld,h - 2025',
          style: TextStyle(
            fontSize: 25,
            fontFamily: AppComponents.accentFont,
            color: AppColor.btnTextColor,
          ),
        ),
      ),
      body: SafeArea(
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
                      if (isLoading)
                        const Center(
                          child: CircularProgressIndicator(),
                        )
                      else if (errorMessage != null)
                        Center(
                          child: Text(
                            errorMessage!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        )
                      else
                        RahuKalayaTableWidget(rahuKalayaData: rahuKalayaData),
                      const SizedBox(height: 20),
                      Text(
                        'rdyq ld,h ;=, f.oßka msgùu - hula wdrïN lsÍu - YqN jev weröu - m%;sldr wdrïNh wdÈh kqiqÿiqh - iQ¾hQoh wkqj ilia lr.kak - Èjd rd;%S folgu tlfiah ',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: AppComponents.accentFont,
                          color: AppColor.btnSubTextColor,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.justify,
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

