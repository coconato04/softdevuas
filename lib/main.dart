import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:softdevuas/screen/login/welcomepage.dart';
import 'package:softdevuas/screen/navbar/navbottombar.dart';
import 'package:softdevuas/services/Notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  NotificationHelper()
      .initializeNotifications(); // Tambahkan ini untuk inisialisasi notifikasi
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Ariel',
      ),
      home: const AuthenticationWrapper(),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance
          .authStateChanges(), // Menggunakan authStateChanges dari FirebaseAuth
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          if (user == null) {
            // Jika pengguna belum masuk, tampilkan halaman masuk atau pendaftaran
            return WelcomePage();
          } else {
            // Jika pengguna sudah masuk, tampilkan halaman utama aplikasi
            return Navbar();
          }
        } else {
          // Tampilkan loading screen atau animasi jika status koneksi masih dalam proses
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
