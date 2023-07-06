import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  TextEditingController _fromEmailController = TextEditingController();
  TextEditingController _subjectController = TextEditingController();
  TextEditingController _messageController = TextEditingController();
  String _ownerEmail = 'ardiansyahjayawinata@gmail.com';
  late FocusNode _messageFocusNode;

  @override
  void initState() {
    super.initState();
    _getUserEmail();
    _messageFocusNode = FocusNode();
  }

  void _getUserEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _fromEmailController.text = user.email ?? '';
      });
    }
  }

  void _sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: _ownerEmail,
      queryParameters: {
        'subject': _subjectController.text,
        'body':
            'From: ${_fromEmailController.text}\n\n${_messageController.text}',
      },
    );

    try {
      await launch(emailUri.toString());
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to send email. Please check your email app.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _fromEmailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    _messageFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kritik dan Saran'),
        backgroundColor: Colors.blue.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _fromEmailController,
              decoration: InputDecoration(
                labelText: 'Dari',
              ),
              enabled: true,
            ),
            SizedBox(height: 16),
            TextField(
              controller: TextEditingController(text: _ownerEmail),
              decoration: InputDecoration(
                labelText: 'Ke',
              ),
              enabled: false,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _subjectController,
              decoration: InputDecoration(
                labelText: 'Subjek',
              ),
            ),
            Expanded(
              child: TextField(
                controller: _messageController,
                focusNode: _messageFocusNode,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _messageFocusNode.requestFocus(); // Fokus ke bagian pesan
                _sendEmail();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue.shade900,
              ),
              child: Text('Kirim'),
            ),
          ],
        ),
      ),
    );
  }
}
