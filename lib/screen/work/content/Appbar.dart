import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Appbar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _AppbarState createState() => _AppbarState();
  Size get preferredSize => Size.fromHeight(50);
}

class _AppbarState extends State<Appbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue.shade900,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 50,
          ),
          Text(
            'Reminder',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) {
              if (value == 'Delete All') {
                deleteAllTasks(); // Memanggil fungsi deleteAllTasks
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                'Delete All',
                'Upgrade Pro',
              ].map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(
                    choice,
                    style: TextStyle(color: Colors.black),
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
    );
  }

  void deleteAllTasks() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      final String? userId = user?.uid;
      final CollectionReference tasksRef = FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('Tasks');
      final QuerySnapshot snapshot = await tasksRef.get();
      for (final doc in snapshot.docs) {
        await doc.reference.delete();
      }
      // Refresh the UI after deleting tasks
      // setState(() {
      //   completedTaskIds.clear();
      // });
    } catch (e) {
      print('Error deleting all tasks: $e');
    }
  }
}
