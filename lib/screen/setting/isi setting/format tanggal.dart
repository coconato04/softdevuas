import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFormatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    final formattedDate = DateFormat('dd MMMM yyyy').format(currentDate);

    return Scaffold(
      appBar: AppBar(
        title: Text('Format Tanggal'),
        backgroundColor: Colors.blue.shade900,
      ),
      body: Center(
        child: Text(
          formattedDate,
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
