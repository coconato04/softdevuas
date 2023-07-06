import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_bus/event_bus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class EditTaskPage extends StatefulWidget {
  final String taskId;
  final String? subTask;
  final String? description;
  final String? category;
  final bool isRemind;
  final DateTime? date;
  final TimeOfDay? time;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final User? user;

  EditTaskPage({
    required this.taskId,
    required this.subTask,
    required this.description,
    required this.category,
    required this.isRemind,
    required this.date,
    required this.time,
    required this.flutterLocalNotificationsPlugin,
    required this.user,
  });

  @override
  _EditTaskPageState createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  TextEditingController subTaskController = TextEditingController();
  TextEditingController reminderController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  bool isRemind = false;
  final EventBus eventBus = EventBus();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  List<String> categoryOptions = [
    'Kerja',
    'Pribadi',
    'Wishlist',
  ];

  @override
  void initState() {
    super.initState();
    subTaskController.text = widget.subTask ?? '';
    reminderController.text = widget.description ?? '';
    categoryController.text = widget.category ?? '';
    isRemind = widget.isRemind;
    if (widget.date != null) {
      selectedDate = widget.date!;
    }
    if (widget.time != null) {
      selectedTime = widget.time!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Text('Edit Task'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 10),
            TextFormField(
              controller: subTaskController,
              decoration: InputDecoration(labelText: 'SubTask'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: reminderController,
              decoration: InputDecoration(labelText: 'Reminder'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: categoryController,
              decoration: InputDecoration(labelText: 'Category'),
              onTap: () {
                showCategoryDialog();
              },
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Icon(Icons.calendar_today),
                SizedBox(width: 16.0),
                Expanded(
                  child: Text(
                    selectedDate.toString().split(' ')[0],
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    ).then((pickedDate) {
                      if (pickedDate != null) {
                        setState(() {
                          selectedDate = pickedDate;
                        });
                      }
                    });
                  },
                  child: Text('Select Date'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Icon(Icons.access_time),
                SizedBox(width: 16.0),
                Expanded(
                  child: Text(
                    selectedTime.format(context),
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    ).then((pickedTime) {
                      if (pickedTime != null) {
                        setState(() {
                          selectedTime = pickedTime;
                        });
                      }
                    });
                  },
                  child: Text('Select Time'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isRemind = !isRemind;
                      });
                    },
                    child: Row(
                      children: [
                        Checkbox(
                          value: isRemind,
                          onChanged: (_) {},
                        ),
                        SizedBox(width: 8.0),
                        Text('Ingatkan saya'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: updateTask,
              style: ElevatedButton.styleFrom(
                primary: Colors.blue.shade900,
              ),
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }

  void showCategoryDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newCategory = '';

        return AlertDialog(
          title: Text('Pilih Kategori'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                ...categoryOptions.map((option) {
                  return ListTile(
                    title: Text(option),
                    onTap: () {
                      setState(() {
                        categoryController.text = option;
                      });
                      Navigator.of(context).pop();
                    },
                  );
                }).toList(),
                ListTile(
                  title: TextField(
                    onChanged: (value) {
                      setState(() {
                        newCategory = value;
                        categoryController.text = newCategory;
                      });
                    },
                    decoration: InputDecoration(labelText: 'Kategori Baru'),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> updateTask() async {
    final subTask = subTaskController.text;
    final reminder = reminderController.text;
    final category = categoryController.text;

    final dateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );
    String taskId = FirebaseFirestore.instance.collection('Users').doc().id;

    if (isRemind) {
      // Mengonversi waktu yang dipilih menjadi objek DateTime
      final scheduledDateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'your_channel_id',
        'your_channel_name',
        importance: Importance.high,
        priority: Priority.high,
        enableVibration: true,
        playSound: true,
        styleInformation: BigTextStyleInformation(''),
      );

      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
      // Menjadwalkan notifikasi menggunakan plugin flutter_local_notifications
      await widget.flutterLocalNotificationsPlugin.schedule(
        widget.taskId.hashCode,
        '$subTask',
        '$reminder',
        scheduledDateTime,
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        payload: '$taskId',
      );
      // After updating the task document
      eventBus.fire(NotificationDisplayedEvent(widget.taskId, true));
    } else {
      // Batalkan notifikasi jika pengguna tidak ingin diingatkan
      await widget.flutterLocalNotificationsPlugin
          .cancel(widget.taskId.hashCode);
    }

    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.user!.uid)
          .collection('Tasks')
          .doc(widget.taskId)
          .update({
        'SubTask': subTask,
        'Description': reminder,
        'Category': category,
        'Date': dateTime,
        'isRemind': isRemind,
        'isCompleted': false,
      });

      Navigator.of(context).pop();
    } catch (e) {
      print('Error updating task: $e');
      // Tampilkan pesan kesalahan atau tangani kesalahan sesuai kebutuhan
    }
  }
}

class NotificationDisplayedEvent {
  final String taskId;
  final bool isCompleted;

  NotificationDisplayedEvent(this.taskId, this.isCompleted);
}
