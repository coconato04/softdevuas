import 'package:flutter/material.dart';

class IklanPro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue.shade900,
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
        child: InkWell(
          onTap: () {
            // Aksi saat container ditekan
          },
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Menjadi PRO',
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                    SizedBox(height: 6.0),
                    Text(
                      'Buka kunci semua fitur PRO',
                      style: TextStyle(fontSize: 14.0, color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.0),
              ElevatedButton.icon(
                onPressed: () {
                  // Aksi saat tombol ditekan
                },
                icon: Icon(Icons.upgrade, color: Colors.blue.shade900),
                label: Text(
                  'PRO',
                  style: TextStyle(
                    color: Colors.blue.shade900,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.lightBlueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(width: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}
