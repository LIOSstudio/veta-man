import 'package:flutter/material.dart';
import 'package:flutter_timetable_view/flutter_timetable_view.dart';

class Timetable extends StatefulWidget {
  const Timetable({Key? key}) : super(key: key);

  @override
  State<Timetable> createState() => _TimetableState();
}

class _TimetableState extends State<Timetable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/logo.png',
              fit: BoxFit.contain,
              height: 35,
            )
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: TimetableView(
        laneEventsList: _buildLaneEvents(),
        timetableStyle: TimetableStyle(),
      ),
    );
  }

  List<LaneEvents> _buildLaneEvents() {
    return [
      LaneEvents(
        lane: Lane(name: '월요일'),
        events: [
          TableEvent(
            title: '프로그래밍I',
            start: TableEventTime(hour: 8, minute: 0),
            end: TableEventTime(hour: 10, minute: 0),
          ),
          TableEvent(
            backgroundColor: Colors.purple,
            title: '바다의 이해',
            start: TableEventTime(hour: 12, minute: 0),
            end: TableEventTime(hour: 13, minute: 20),
          ),
          TableEvent(
            backgroundColor: Colors.green,
            title: '서양의 역사와 문화',
            start: TableEventTime(hour: 15, minute: 0),
            end: TableEventTime(hour: 17, minute: 0),
          ),
        ],
      ),
      LaneEvents(
        lane: Lane(name: '화요일'),
        events: [
          TableEvent(
            title: '캡스톤 프로젝트',
            backgroundColor: Colors.indigo,
            start: TableEventTime(hour: 10, minute: 0),
            end: TableEventTime(hour: 12, minute: 45),
          ),
          TableEvent(
            title: '데이터과학',
            backgroundColor: Colors.purple,
            start: TableEventTime(hour: 14, minute: 0),
            end: TableEventTime(hour: 15, minute: 45),
          ),
        ],
      ),
      LaneEvents(
        lane: Lane(name: '수요일'),
        events: [
          TableEvent(
            title: '팀모임',
            start: TableEventTime(hour: 14, minute: 30),
            end: TableEventTime(hour: 17, minute: 45),
          ),
        ],
      ),
    ];
  }
}
