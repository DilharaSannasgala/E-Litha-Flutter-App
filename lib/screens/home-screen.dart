import 'package:e_litha/utils/app-color.dart';
import 'package:e_litha/utils/custom-date-time.dart';
import 'package:e_litha/widgets/home/home-calender-btn.dart';
import 'package:e_litha/widgets/home/home-nakath-btn.dart';
import 'package:e_litha/widgets/home/home-sun-btn.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final CustomDateTime customDateTime = CustomDateTime();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 1.0, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.05), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 1.0, curve: Curves.easeOut),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                int columnsCount = 2; // Default for mobile
                if (constraints.maxWidth > 600 && constraints.maxWidth <= 900) {
                  columnsCount = 3; // For tablets in portrait
                } else if (constraints.maxWidth > 900) {
                  columnsCount = 4; // For tablets in landscape and larger
                }
                // Maximum content width for tablets and larger screens
                double maxContentWidth = 900;
                double currentWidth = constraints.maxWidth;
                double usedWidth = currentWidth > maxContentWidth
                    ? maxContentWidth
                    : currentWidth;
                return Center(
                  child: Container(
                    width: usedWidth,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildHeaderSection(),
                            SizedBox(height: 25),
                            calenderButton(
                              context,
                              textTitle: 'දින දර්ශනය',
                              textYear: "2026",
                              onPressed: () {
                                Navigator.pushNamed(context, '/calendar');
                              },
                            ),
                            SizedBox(height: 25),
                            _buildMainSectionTitle(),
                            SizedBox(height: 20),
                            nakathButton(
                              context,
                              textTitle: 'අලුත් අවුරුදු',
                              textYear: 'නැකැත් සීට්ටුව',
                              onPressed: () {
                                Navigator.pushNamed(context, '/nakath');
                              },
                            ),
                            SizedBox(height: 25),
                            GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: columnsCount,
                              childAspectRatio: 1.5,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                            ),
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              List<Map<String, dynamic>> buttonData = [
                                {
                                  "first": "සංවත්සර",
                                  "second": "පලාපල",
                                  "route": "/summary"
                                },
                                {
                                  "first": "සුභ",
                                  "second": "දවස්",
                                  "route": "/subhaDawasa"
                                },
                                {
                                  "first": "රාහු",
                                  "second": "කාලය",
                                  "route": "/rahukalaya"
                                },
                                {
                                  "first": "රාශි",
                                  "second": "අය වැය",
                                  "route": "/rashiIncomeExpense"
                                },
                              ];
                              return buildSunButton(
                                context,
                                buttonData[index]["first"],
                                buttonData[index]["second"],
                                buttonData[index]["route"],
                              );
                            }),
                      ],
                    ),
                  ),
                ),
                ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    DateTime now = DateTime.now();
    String customDay = customDateTime.getCustomDay(now.weekday);
    String customMonth = customDateTime.getCustomMonth(now.month);
    int customYear = customDateTime.getCustomYear(now.year);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ආයුබෝවන්',
          style: TextStyle(
              fontSize: 48,
              color: AppColor.titleTextColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColor.accentColor.withOpacity(0.3)),
          ),
          child: Text(
            '${now.day} $customDay $customMonth ${now.year} ~ ශ්‍රී බුද්ධ වර්ෂ $customYear',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColor.accentColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMainSectionTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 5.0, top: 10.0),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 24,
            decoration: BoxDecoration(
              color: AppColor.accentColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'පලාපල ලිත',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: AppColor.titleTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
