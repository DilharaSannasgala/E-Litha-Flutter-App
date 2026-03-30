import 'package:e_litha/models/subha-dawasa-model.dart';
import 'package:e_litha/utils/app-color.dart';
import 'package:flutter/material.dart';

class CollapsibleSubhaDawasaCard extends StatefulWidget {
  final SubhaDawasaMonth month;

  const CollapsibleSubhaDawasaCard({
    Key? key,
    required this.month,
  }) : super(key: key);

  @override
  State<CollapsibleSubhaDawasaCard> createState() =>
      _CollapsibleSubhaDawasaCardState();
}

class _CollapsibleSubhaDawasaCardState extends State<CollapsibleSubhaDawasaCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(begin: 0.0, end: 0.5).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      margin: const EdgeInsets.only(bottom: 16),
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
      ),
      foregroundDecoration: BoxDecoration(
        border: Border.all(
          color: AppColor.borderLightColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: _toggleExpanded,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with month name and arrow
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        widget.month.monthName,
                        style: TextStyle(
                          fontSize: 24,
                          
                          fontWeight: FontWeight.w400,
                          color: AppColor.btnTextColor,
                          height: 1.2,
                        ),
                      ),
                    ),
                    // Circle with arrow icon
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColor.accentColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: RotationTransition(
                          turns: _rotationAnimation,
                          child: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: AppColor.cardColor,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Days list (animated)
              ClipRect(
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: _isExpanded && widget.month.days.isNotEmpty 
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: widget.month.days
                                .map(
                                  (day) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: AppColor.accentColor
                                          .withAlpha(25), // 10% opacity
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      child: Text(
                                        day.day,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.accentColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(height: 12),
                                        Text(
                                          day.time,
                                          style: TextStyle(
                                            fontSize: 18,
                                            
                                            color: AppColor.subTextColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  )
                  : const SizedBox(width: double.infinity, height: 0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



