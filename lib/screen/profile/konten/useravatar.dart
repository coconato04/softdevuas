import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String displayName = user != null ? user.email!.split('@')[0] : '';
    String? photoUrl = user?.photoURL;

    return Container(
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20.0,
                backgroundImage:
                    photoUrl != null ? NetworkImage(photoUrl) : null,
                child: photoUrl == null ? Icon(Icons.person) : null,
              ),
              SizedBox(width: 16.0),
              Text(
                'Halo, $displayName',
                style: TextStyle(fontSize: 20.0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
