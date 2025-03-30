import 'package:e_litha/models/special-nakath-date-info.dart';
import 'package:e_litha/utils/app-color.dart';
import 'package:e_litha/utils/app-component.dart';
import 'package:e_litha/utils/custom-date-time.dart';
import 'package:e_litha/widgets/nakath/nakath-date-container.dart';
import 'package:flutter/material.dart';

class CollapsibleNakathCard extends StatefulWidget {
  final SpecialNakathDateInfo specialDate;

  const CollapsibleNakathCard({
    Key? key,
    required this.specialDate,
  }) : super(key: key);

  @override
  State<CollapsibleNakathCard> createState() => _CollapsibleNakathCardState();
}

class _CollapsibleNakathCardState extends State<CollapsibleNakathCard>
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
                  // Date container
                  DateContainer(
                    month: CustomDateTime()
                        .getCustomMonthShort(widget.specialDate.month),
                    day: widget.specialDate.day.toString(),
                  ),

                  // Event details
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
                                widget.specialDate.name,
                                style: const TextStyle(
                                    fontSize: 24,
                                    fontFamily: AppComponents.accentFont,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.btnTextColor,
                                    height: 1.2),
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

              // Description (animated)
              ClipRect(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height:
                      _isExpanded && widget.specialDate.description.isNotEmpty
                          ? null // Auto height
                          : 0, // Collapsed
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Text(
                      widget.specialDate.description,
                      style: TextStyle(
                        fontFamily: AppComponents.accentFont,
                        fontSize: 20,
                        color: AppColor.btnSubTextColor,
                      ),
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