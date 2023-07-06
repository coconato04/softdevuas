import 'package:flutter/material.dart';
import 'package:softdevuas/screen/login/signin.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue.shade900, // Mengubah background menjadi warna biru
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  height: 600,
                  width: 600,
                  child: Image.asset(
                    'assets/icon/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SignIn()),
                  );
                },
                child: Text(
                  'Get Started',
                  style: TextStyle(fontSize: 18, color: Colors.blue.shade900),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  primary: Colors.white, // Mengubah warna tombol menjadi putih
                  onPrimary: Colors.grey,
                  padding: EdgeInsets.symmetric(horizontal: 110, vertical: 15),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
