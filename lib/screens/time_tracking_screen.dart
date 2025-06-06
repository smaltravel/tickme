import 'package:flutter/material.dart';
import 'package:tickme/models/category.dart';

class TimeTrackingScreen extends StatefulWidget {
  final Category category;

  TimeTrackingScreen({Key? key, required this.category}) : super(key: key);

  @override
  _TimeTrackingScreenState createState() => _TimeTrackingScreenState();
}

class _TimeTrackingScreenState extends State<TimeTrackingScreen> {
  DateTime? _startTime;
  bool _isTimerRunning = false;

  void _startTimer() {
    setState(() {
      _isTimerRunning = true;
    });
    _startTime = DateTime.now();
  }

  void _stopTimer() {
    setState(() {
      _isTimerRunning = false;
    });
    print('Timer stopped');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category.name} - Time Tracking'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tracking ${widget.category.name}',
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              onPressed: _isTimerRunning ? null : _startTimer,
              child: Text(_isTimerRunning ? 'Stop' : 'Start'),
            ),
            Text(
              _isTimerRunning
                  ? '${DateTime.now().difference(_startTime!)}'
                  : '',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
