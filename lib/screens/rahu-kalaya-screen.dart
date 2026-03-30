import 'dart:convert';
import 'package:e_litha/models/rahukalaya-model.dart';
import 'package:e_litha/utils/app-color.dart';
import 'package:e_litha/utils/app-component.dart';
import 'package:e_litha/widgets/rahukalaya/rahukalaya-table-widget.dart';
import 'package:e_litha/widgets/rahukalaya/maru-sitina-disawa-widget.dart';
import 'package:e_litha/widgets/rahukalaya/kala-horawa-widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RahuKalayaScreen extends StatefulWidget {
  const RahuKalayaScreen({super.key});

  @override
  State<RahuKalayaScreen> createState() => _RahuKalayaScreenState();
}

class _RahuKalayaScreenState extends State<RahuKalayaScreen> with SingleTickerProviderStateMixin {
  List<RahuKalayaModel> rahuKalayaData = [];
  bool isLoading = true;
  String? errorMessage;
  
  // Define maximum tablet vertical width
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
    loadData();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
      _animationController.forward();
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
          icon: Icon(Icons.arrow_back, color: AppColor.btnTextColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'රාහු කාලය - 2026',
          style: TextStyle(
            fontSize: 25,
            
            color: AppColor.btnTextColor,
          ),
        ),
      ),
      body: Align(
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
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          if (isLoading)
                            CircularProgressIndicator(color: AppColor.accentColor)
                          else if (errorMessage != null)
                            Text(
                              errorMessage!,
                              style: const TextStyle(color: Colors.red),
                            )
                          else
                            RahuKalayaTableWidget(rahuKalayaData: rahuKalayaData),
                          const SizedBox(height: 20),
                          Text(
                            'රාහු කාලය තුල ගෙදරින් පිටවීම - යමක් ආරම්භ කිරීම - ශුභ වැඩ ඇරඹීම - ප‍්‍රතිකාර ආරම්භය ආදිය නුසුදුසුය - සූර්යූදය අනුව සකස් කරගන්න - දිවා රාත‍්‍රී දෙකටම එකසේය ',
                            style: TextStyle(
                              fontSize: 16,
                              
                              color: AppColor.btnSubTextColor,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(height: 30),
                          Text(
                            'සත් දිනට මරු සිටින දිසාව',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColor.btnTextColor,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const MaruSitinaDisawaWidget(),
                          const SizedBox(height: 30),
                          Text(
                            'කාල හෝරාව',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColor.btnTextColor,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const KalaHorawaWidget(),
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

