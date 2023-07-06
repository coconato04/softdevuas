import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Sinkron extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sinkron Akun'),
        backgroundColor: Colors.blue.shade900,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              onTap: () {},
              leading: Icon(
                Icons.add_to_drive_outlined,
                color: Colors.black,
              ), // Ikon Google Drive
              title: Text(
                user?.email ?? 'User email not available', // Email pengguna
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
