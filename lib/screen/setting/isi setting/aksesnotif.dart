import 'package:flutter/material.dart';

class Pemberitahuan extends StatefulWidget {
  @override
  _PemberitahuanPageState createState() => _PemberitahuanPageState();
}

class _PemberitahuanPageState extends State<Pemberitahuan> {
  bool _notificationEnabled = true; // Mengubah nilai awal menjadi true

  @override
  void initState() {
    super.initState();
    // Mengecek izin notifikasi saat inisialisasi halaman
    _checkNotificationPermission();
  }

  void _checkNotificationPermission() {
    bool isPermissionGranted = true;
    setState(() {
      _notificationEnabled = isPermissionGranted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pemberitahuan'),
        backgroundColor: Colors.blue.shade900,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Status Notifikasi',
              style: TextStyle(fontSize: 18.0),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _notificationEnabled = !_notificationEnabled;
                });
              },
              child: _notificationEnabled
                  ? Icon(
                      Icons.check_box,
                      size: 36.0,
                      color: Colors.blue,
                    )
                  : Icon(
                      Icons.check_box_outline_blank,
                      size: 36.0,
                      color: Colors.grey,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
