import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:event_bus/event_bus.dart';

class Reminder extends StatefulWidget {
  @override
  _ReminderState createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  String selectedCategory = 'Kerja';
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  TextEditingController subTaskController = TextEditingController();
  TextEditingController reminderController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  late User? user; // Menyimpan data pengguna saat ini
  final EventBus eventBus = EventBus();

  bool isRemind = false;

  List<String> categoryOptions = [
    'Kerja',
    'Pribadi',
    'Wishlist',
  ];

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser; // Mendapatkan pengguna saat ini
    initializeNotifications();
  }

  void initializeNotifications() {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.7,
      child: Container(
        color: Colors.grey.shade50,
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 10),
            Text(
              "Create Task",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
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
              onPressed: saveTask,
              style: ElevatedButton.styleFrom(
                primary: Colors.blue.shade900,
              ),
              child: Text('Save'),
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
                        selectedCategory = option;
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
                        selectedCategory = newCategory;
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

  Future<void> saveTask() async {
    final subTask = subTaskController.text;
    final reminder = reminderController.text;
    final category = selectedCategory;
    final date = selectedDate;
    final time = selectedTime;

    final dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    String taskId = FirebaseFirestore.instance.collection('Users').doc().id;

    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user!.uid)
          .collection('Tasks')
          .doc()
          .set({
        'SubTask': subTask,
        'Description': reminder,
        'Category': category,
        'Date': dateTime,
        'isRemind': isRemind,
        'isCompleted': false, // Menambahkan isCompleted dengan nilai awal false
      });

      if (isRemind) {
        // Mengonversi waktu yang dipilih menjadi objek DateTime
        final scheduledDateTime = DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        );

        const AndroidNotificationDetails androidPlatformChannelSpecifics =
            AndroidNotificationDetails(
          'your_channel_id',
          'your_channel_name',
          importance: Importance.high,
          priority: Priority.high,
          playSound: true,
          enableVibration: true,
        );

        const NotificationDetails platformChannelSpecifics =
            NotificationDetails(android: androidPlatformChannelSpecifics);

        await flutterLocalNotificationsPlugin.schedule(
          0,
          '$subTask',
          '$reminder',
          scheduledDateTime,
          platformChannelSpecifics,
          androidAllowWhileIdle: true,
          payload: ('$taskId'), // Menggunakan taskId sebagai payload notifikasi
        );

        // Mengirim informasi notifikasi ditampilkan dan mengubah isCompleted menjadi true
        // After updating the task document
        eventBus.fire(NotificationDisplayedEvent(taskId, true));
      }

      Navigator.of(context).pop();
    } catch (e) {
      print('Error saving task: $e');
      // Tampilkan pesan kesalahan atau tangani kesalahan sesuai kebutuhan
    }
  }
}

class NotificationDisplayedEvent {
  final String taskId;
  final bool isCompleted;

  NotificationDisplayedEvent(this.taskId, this.isCompleted);
}
