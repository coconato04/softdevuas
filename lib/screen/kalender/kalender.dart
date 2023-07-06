import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:softdevuas/screen/work/content/circle.dart';

class Calendar extends StatefulWidget {
  @override
  _RealtimeCalendarState createState() => _RealtimeCalendarState();
}

class _RealtimeCalendarState extends State<Calendar> {
  late DateTime _currentDate;
  late int _selectedDay;

  @override
  void initState() {
    super.initState();
    _updateCurrentDate();
  }

  void _updateCurrentDate() {
    final now = DateTime.now();
    setState(() {
      _currentDate = now;
      _selectedDay = now.day;
    });
  }

  String _getMonthYearString(DateTime dateTime) {
    final formatter = DateFormat('MMMM yyyy');
    return formatter.format(dateTime);
  }

  Widget _buildCalendarCell(int day, bool isInCurrentMonth) {
    final isSelected = (day == _selectedDay && isInCurrentMonth);
    final isToday = (day == DateTime.now().day && isInCurrentMonth);

    Color textColor = isToday
        ? Colors.white
        : (isInCurrentMonth ? Colors.black : Colors.grey);
    Color backgroundSelectedColor = Colors.blue.shade200;
    Color backgroundTodayColor = Colors.blue.shade900;
    Color backgroundColor = isToday
        ? backgroundTodayColor
        : (isSelected ? backgroundSelectedColor : Colors.transparent);

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Padding(
            padding:
                EdgeInsets.symmetric(vertical: 0), // Ubah nilai padding di sini
            child: Text(
              day.toString(),
              style: TextStyle(
                fontSize: 16,
                color: textColor,
                fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    final daysInWeek = 7;
    final firstDayOfMonth = DateTime(_currentDate.year, _currentDate.month, 1);
    final daysBeforeFirstDay =
        (firstDayOfMonth.weekday - DateTime.monday) % daysInWeek;
    final daysInMonth =
        DateTime(_currentDate.year, _currentDate.month + 1, 0).day;

    final today = DateTime.now();
    final isCurrentMonth =
        (today.year == _currentDate.year && today.month == _currentDate.month);

    return Column(
      children: [
        Row(
          children: List.generate(daysInWeek, (index) {
            final weekday = (index + DateTime.monday) % daysInWeek;
            final weekdayName =
                DateFormat.E().format(DateTime(2021, 1, weekday + 3));
            return Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 0),
                child: Text(
                  weekdayName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: daysInWeek,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            if (index < daysBeforeFirstDay) {
              return Container();
            } else if (index >= daysBeforeFirstDay + daysInMonth) {
              return Container();
            } else {
              final day = index - daysBeforeFirstDay + 1;
              return GestureDetector(
                onTap: () {
                  if (isCurrentMonth) {
                    setState(() {
                      _selectedDay = day;
                    });
                  }
                },
                child: _buildCalendarCell(day, isCurrentMonth),
              );
            }
          },
          itemCount: daysBeforeFirstDay +
              daysInMonth +
              6 -
              ((daysBeforeFirstDay + daysInMonth) % 7),
        ),
      ],
    );
  }

  void _previousMonth() {
    setState(() {
      _currentDate =
          DateTime(_currentDate.year, _currentDate.month - 1, _currentDate.day);
      _selectedDay = -1;
    });
  }

  void _nextMonth() {
    setState(() {
      _currentDate =
          DateTime(_currentDate.year, _currentDate.month + 1, _currentDate.day);
      _selectedDay = -1;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 80), // Menentukan jarak dari atas
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: _previousMonth,
                  icon: Icon(Icons.arrow_left),
                ),
                Text(
                  _getMonthYearString(_currentDate),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: _nextMonth,
                  icon: Icon(Icons.arrow_right),
                ),
              ],
            ),
            SizedBox(
              height: 70,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: _buildCalendar(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Reminder();
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(16.0),
              ),
            ),
            isScrollControlled: true,
          );
        },
        backgroundColor: Colors.blue.shade900,
        child: Icon(Icons.add),
      ),
    );
  }
}
