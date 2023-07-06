import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeFormatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentTime = DateTime.now();
    final userTimeZone = DateTime.now().timeZoneOffset;

    return Scaffold(
      appBar: AppBar(
        title: Text('Format Waktu'),
        backgroundColor: Colors.blue.shade900,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Waktu saat ini:',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text(
              DateFormat('HH:mm:ss').format(currentTime),
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Zona waktu:',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'GMT ${userTimeZone.inHours >= 0 ? '+' : ''}${userTimeZone.inHours}',
              style: TextStyle(fontSize: 24.0),
            ),
          ],
        ),
      ),
    );
  }
}
