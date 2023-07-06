import 'package:flutter/material.dart';
import 'package:softdevuas/screen/profile/konten/iklan.dart';
import 'package:softdevuas/screen/profile/konten/riwayat.dart';
import 'package:softdevuas/screen/profile/konten/useravatar.dart';

class Profil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          UserAvatar(),
          SizedBox(height: 15),
          History(),
        ],
      ),
    );
  }
}
