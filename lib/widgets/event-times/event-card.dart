import 'package:e_litha/models/event-time-model.dart';
import 'package:e_litha/utils/app-color.dart';
import 'package:e_litha/utils/app-component.dart';
import 'package:e_litha/widgets/event-times/event-card-expandable-section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CollapsibleEventCard extends StatefulWidget {
  final EventTimeInfo eventTimeInfo;

  const CollapsibleEventCard({
    Key? key,
    required this.eventTimeInfo,
  }) : super(key: key);

  @override
  State<CollapsibleEventCard> createState() => _CollapsibleEventCardState();
}

class _CollapsibleEventCardState extends State<CollapsibleEventCard>
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
        color: Colors.white,
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon container
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, top: 16, bottom: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          widget.eventTimeInfo.icon,
                          width: 60,
                          height: 60,
                        ),
                      ),
                    ),
                  ),

                  // Event title
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                widget.eventTimeInfo.title,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontFamily: AppComponents.accentFont,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.btnTextColor,
                                  height: 1.2,
                                ),
                              ),
                            ),
                          ),

                          // Circle with arrow icon
                          Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: AppColor.accentColor,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: RotationTransition(
                                turns: _rotationAnimation,
                                child: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Dates list (animated)
              ClipRect(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: _isExpanded && widget.eventTimeInfo.dates.isNotEmpty
                      ? null // Auto height
                      : 0, // Collapsed
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Column(
                      children: widget.eventTimeInfo.dates.map((date) {
                        return EventDateRow(date: date);
                      }).toList(),
                    ),
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