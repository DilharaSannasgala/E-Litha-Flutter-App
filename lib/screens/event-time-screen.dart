import 'package:e_litha/models/event-time-model.dart';
import 'package:e_litha/utils/app-color.dart';
import 'package:e_litha/widgets/event-times/event-card.dart';
import 'package:flutter/material.dart';
import '../utils/app-component.dart';

class EventTimeScreen extends StatefulWidget {
  const EventTimeScreen({Key? key}) : super(key: key);

  @override
  State<EventTimeScreen> createState() => _EventTimeScreenState();
}

class _EventTimeScreenState extends State<EventTimeScreen> {
  List<EventTimeInfo> eventTimes = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // For demo we'll use dummy data instead of loading from assets
    _loadDummyData();
  }

  void _loadDummyData() {
    // Dummy data for demonstration
    setState(() {
      eventTimes = [
        EventTimeInfo(
          title: 'lka ú§u',
          icon: AppComponents.earPierced,
          dates: [],
        ),
        EventTimeInfo(
          title: 'ysifla lemSu',
          icon: AppComponents.hairCut,
          dates: [
            EventDate(
              day: 30,
              month: 1, // January
              description: 'ckjdß 30 n%yiam;skaod Wfoa 9-32 g W;=r n,d',
            ),
            EventDate(
              day: 19,
              month: 3, // March
              description: 'ud¾;= 19 nodod Wfoa 10-01 g kef.kysr n,d',
            ),
          ],
        ),
        EventTimeInfo(
          title: 'n;a leùu',
          icon: AppComponents.feedRice,
          dates: [],
        ),
      ];
      isLoading = false;
    });
  }

  // In a real implementation, you would load data from assets like this:
  /*
  Future<void> _loadEventTimeData() async {
    try {
      setState(() => isLoading = true);
      final String jsonString = await rootBundle.loadString('assets/data/event_times.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      setState(() {
        eventTimes = (jsonData['eventTimes'] as List?)
                ?.map((item) => EventTimeInfo.fromJson(item))
                .toList() ??
            [];
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading event time data: $e');
      setState(() => isLoading = false);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load event time data: ${e.toString()}'),
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }
  */

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
          'iqN uqyq¾; - 2025',
          style: TextStyle(
            fontSize: 25,
            fontFamily: AppComponents.accentFont,
            color: AppColor.btnTextColor,
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppColor.accentColor))
          : SafeArea(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: eventTimes.length,
                itemBuilder: (context, index) {
                  return CollapsibleEventCard(
                    eventTimeInfo: eventTimes[index],
                  );
                },
              ),
            ),
    );
  }
}

