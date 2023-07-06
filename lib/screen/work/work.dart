import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:softdevuas/screen/work/content/Appbar.dart';
import 'package:softdevuas/screen/work/content/Edittask.dart';
import 'package:softdevuas/screen/work/content/circle.dart';
import 'package:intl/intl.dart';
import 'package:event_bus/event_bus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final InitializationSettings initializationSettings = InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    iOS: DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {},
    ),
  );
  flutterLocalNotificationsPlugin.initialize(initializationSettings);
  runApp(
      Work(flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin));
}

class Work extends StatelessWidget {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  const Work({Key? key, required this.flutterLocalNotificationsPlugin})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(),
      body: All(
        flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
      ),
    );
  }
}

class NotificationDisplayedEvent {
  final String taskId;
  final bool isCompleted;

  NotificationDisplayedEvent(this.taskId, this.isCompleted);
}

class All extends StatefulWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  All({required this.flutterLocalNotificationsPlugin});

  @override
  _AllState createState() => _AllState();
}

class _AllState extends State<All> {
  final List<String> completedTaskIds = [];
  final eventBus = EventBus();

  @override
  void initState() {
    super.initState();
    // Mendengarkan event NotificationDisplayedEvent
    eventBus.on<NotificationDisplayedEvent>().listen((event) {
      completeTask(event.taskId, true);
    });
  }

  void deleteAllTasks() async {
    try {
      final User? user = widget._auth.currentUser;
      final String? userId = user?.uid;
      final CollectionReference tasksRef = FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('Tasks');
      final QuerySnapshot snapshot = await tasksRef.get();
      for (final doc in snapshot.docs) {
        await doc.reference.delete();
      }
      setState(() {
        completedTaskIds.clear();
      });
    } catch (e) {
      print('Error deleting all tasks: $e');
    }
  }

  void sortTasksByCategory() {
    final User? user = widget._auth.currentUser;
    final String? userId = user?.uid;
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('Tasks')
        .orderBy('Category')
        .get()
        .then((snapshot) {
      final tasks = snapshot.docs;
      setState(() {});
    }).catchError((error) {
      print('Error sorting tasks by category: $error');
    });
  }

  Future<void> completeTask(String taskId, bool isCompleted,
      [bool done = false]) async {
    try {
      final User? user = widget._auth.currentUser;
      final String? userId = user?.uid;

      final DocumentReference taskRef = FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('Tasks')
          .doc(taskId);

      final DocumentSnapshot taskSnapshot = await taskRef.get();
      NotificationDisplayedEvent(taskId, isCompleted = true);
      if (taskSnapshot.exists) {
        final bool isCompleted = done
            ? true
            : (taskSnapshot.data() as Map<String, dynamic>)
                    .containsKey('isCompleted')
                ? (taskSnapshot.data() as Map<String, dynamic>)['isCompleted']
                    as bool
                : false;

        await taskRef.update({'isCompleted': !isCompleted});

        setState(() {
          if (!isCompleted) {
            completedTaskIds.add(taskId);
          } else {
            completedTaskIds.remove(taskId);
          }
        });
      }
    } catch (e) {
      print('Error completing task: $e');
      // Tampilkan pesan kesalahan atau tangani kesalahan sesuai kebutuhan
    }
  }

  @override
  Widget build(BuildContext context) {
    final User? user = widget._auth.currentUser;
    final String? userId = user?.uid;

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(userId)
            .collection('Tasks')
            .orderBy('Date')
            .snapshots(),
        builder: (context, snapshot) {
          Future<void> deleteTask(String taskId) async {
            try {
              await FirebaseFirestore.instance
                  .collection('Users')
                  .doc(userId)
                  .collection('Tasks')
                  .doc(taskId)
                  .delete();
            } catch (e) {
              print('Error deleting task: $e');
              // Tampilkan pesan kesalahan atau tangani kesalahan sesuai kebutuhan
            }
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData) {
            final tasks = snapshot.data!.docs;
            tasks.sort((a, b) =>
                (b['Date'] as Timestamp).compareTo(a['Date'] as Timestamp));
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index].data() as Map<String, dynamic>;
                final taskId = tasks[index].id;
                final subTask = task['SubTask'] as String?;
                final description = task['Description'] as String?;
                final category = task['Category'] as String?;
                final isRemind = task['isRemind'] as bool? ?? false;
                final isCompleted = task['isCompleted'] as bool? ?? false;
                final indicatorColor = isCompleted
                    ? Colors.green
                    : (isRemind ? Colors.blue : Colors.grey);
                final date = task['Date'] as Timestamp?;

                return Dismissible(
                  key: Key(taskId),
                  onDismissed: (direction) {
                    deleteTask(taskId);
                  },
                  background: Container(
                    color: Colors.red,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditTaskPage(
                            taskId: taskId,
                            subTask: subTask,
                            description: description,
                            category: category,
                            isRemind: isRemind,
                            date: DateTime.now(),
                            flutterLocalNotificationsPlugin:
                                widget.flutterLocalNotificationsPlugin,
                            user: user,
                            time: TimeOfDay.now(),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                margin: EdgeInsets.only(right: 8.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: indicatorColor,
                                ),
                              ),
                              Text(
                                category ?? '',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Spacer(),
                              PopupMenuButton<String>(
                                icon: Icon(Icons.more_horiz),
                                onSelected: (value) {
                                  if (value == 'edit') {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditTaskPage(
                                          taskId: taskId,
                                          subTask: subTask,
                                          description: description,
                                          category: category,
                                          isRemind: isRemind,
                                          date: DateTime.now(),
                                          flutterLocalNotificationsPlugin: widget
                                              .flutterLocalNotificationsPlugin,
                                          user: user,
                                          time: TimeOfDay.now(),
                                        ),
                                      ),
                                    );
                                  } else if (value == 'delete') {
                                    deleteTask(taskId);
                                  } else if (value == 'markAsCompleted') {
                                    completeTask(taskId, false);
                                  }
                                },
                                itemBuilder: (BuildContext context) =>
                                    <PopupMenuEntry<String>>[
                                  const PopupMenuItem<String>(
                                    value: 'markAsCompleted',
                                    child: ListTile(
                                      leading: Icon(Icons.check),
                                      title: Text('Mark as Completed'),
                                    ),
                                  ),
                                  const PopupMenuItem<String>(
                                    value: 'edit',
                                    child: ListTile(
                                      leading: Icon(Icons.edit),
                                      title: Text('Edit'),
                                    ),
                                  ),
                                  const PopupMenuItem<String>(
                                    value: 'delete',
                                    child: ListTile(
                                      leading: Icon(Icons.delete),
                                      title: Text('Delete'),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(),
                          SizedBox(height: 5.0),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      subTask ?? '',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        decoration: isCompleted
                                            ? TextDecoration.lineThrough
                                            : null,
                                      ),
                                    ),
                                    SizedBox(height: 4.0),
                                    Text(
                                      description ?? '',
                                      style: TextStyle(
                                        decoration: isCompleted
                                            ? TextDecoration.lineThrough
                                            : null,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (date != null)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      DateFormat.yMd().format(date.toDate()),
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      DateFormat.Hm().format(date.toDate()),
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return Center(
            child: Text('No tasks found.'),
          );
        },
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
