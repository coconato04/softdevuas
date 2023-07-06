import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:softdevuas/screen/login/welcomepage.dart';
import 'package:softdevuas/screen/setting/isi%20setting/Sync.dart';
import 'package:softdevuas/screen/setting/isi%20setting/aksesnotif.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<Map<String, dynamic>> completedTasks = [];
  List<Map<String, dynamic>> incompletedTasks = [];

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // User not logged in, handle accordingly
      return Center(
        child: Text('User not logged in.'),
      );
    }

    bool isLoggedIn = true; // Status login pengguna

    void logout(BuildContext context) {
      // Lakukan operasi logout di sini
      // Misalnya, menghapus data login pengguna atau mengatur status login ke false

      // Contoh operasi logout:
      // Menghapus data login pengguna
      // dataLogin = null;

      setState(() {
        isLoggedIn = false; // Mengubah status login menjadi false
      });

      // Navigasi kembali ke halaman welcome
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => WelcomePage()),
        (route) => false,
      );
    }

    final String userId = user.uid;

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('Tasks')
          .snapshots(),
      builder: (context, snapshot) {
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

        final tasks = snapshot.data!.docs;
        completedTasks.clear();
        incompletedTasks.clear();

        tasks.forEach((task) {
          final taskData = task.data() as Map<String, dynamic>;
          final isCompleted = taskData['isCompleted'] as bool?;
          if (isCompleted == true) {
            completedTasks.add(taskData);
          } else {
            incompletedTasks.add(taskData);
          }
        });

        final totalCompletedTasks = completedTasks.length;
        final totalIncompletedTasks = incompletedTasks.length;
        final totalTasks = totalCompletedTasks + totalIncompletedTasks;

        final currentMonth = DateFormat.MMMM().format(DateTime.now());
        final currentMonthTasks = completedTasks.where((task) {
          final taskMonth = DateFormat.MMMM().format(
            (task['Date'] as Timestamp).toDate(),
          );
          return taskMonth == currentMonth;
        }).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 8.0, bottom: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 8.0, bottom: 8.0),
                          child: Column(
                            children: [
                              Text(
                                totalCompletedTasks.toString(),
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Tugas Selesai',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 8.0, bottom: 8.0),
                          child: Column(
                            children: [
                              Text(
                                totalIncompletedTasks.toString(),
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Tugas Masuk',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 8.0, bottom: 8.0),
              child: ExpansionTile(
                title: Text(
                  'Total Tugas berdasarkan Bulan',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                initiallyExpanded: true,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 8.0, bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                currentMonth,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                '$totalCompletedTasks/$totalTasks',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ExpansionTile(
                title: Text(
                  'Tugas Tertunda',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                initiallyExpanded: true,
                children: incompletedTasks.isNotEmpty
                    ? incompletedTasks.map((task) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            task['SubTask'] as String? ?? '',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          SizedBox(height: 4.0),
                                          Text(
                                            task['Description'] as String? ??
                                                '',
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          task['Date'] != null
                                              ? DateFormat.yMd().format(
                                                  (task['Date'] as Timestamp)
                                                      .toDate())
                                              : '',
                                        ),
                                        Text(
                                          task['Date'] != null
                                              ? DateFormat.Hm().format(
                                                  (task['Date'] as Timestamp)
                                                      .toDate())
                                              : '',
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.0),
                              ],
                            ),
                          ),
                        );
                      }).toList()
                    : [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(
                              'Tidak ada tugas tertunda',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ),
                        ),
                      ],
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                leading: Icon(Icons.notifications),
                title: Text('Pemberitahuan'),
                onTap: () {
                  // Navigasi ke halaman pemberitahuan
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Pemberitahuan(),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                leading: Icon(Icons.sync),
                title: Text('Sinkron Akun'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Sinkron(),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                title: Text(
                  'Log Out',
                  selectionColor: Colors.black,
                ),
                onTap: () {
                  logout(context);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
