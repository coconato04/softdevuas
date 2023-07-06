import 'package:flutter/material.dart';
import 'package:softdevuas/screen/menu/isi%20menu/dukungan.dart';
import 'package:softdevuas/screen/menu/isi%20menu/kritikdansaran.dart';
import 'package:softdevuas/screen/menu/isi%20menu/pagewidget.dart';
import 'package:softdevuas/screen/menu/isi%20menu/tema.dart';
import 'package:softdevuas/screen/setting/isi%20setting/Sync.dart';
import 'package:softdevuas/screen/setting/isi%20setting/aksesnotif.dart';
import 'package:softdevuas/screen/setting/isi%20setting/bahasa.dart';
import 'package:softdevuas/screen/setting/isi%20setting/format%20tanggal.dart';
import 'package:softdevuas/screen/setting/isi%20setting/format%20waktu.dart';
import 'package:softdevuas/screen/setting/isi%20setting/kebijakanprivasi.dart';

class PengaturanPage extends StatefulWidget {
  @override
  _PengaturanPageState createState() => _PengaturanPageState();
}

class _PengaturanPageState extends State<PengaturanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Pengaturan'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              'Kostumasi',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Sinkron(),
                ),
              );
            },
            leading: Icon(Icons.sync),
            title: Text('Sinkron Akun'),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PageWidget(),
                ),
              );
            },
            leading: Icon(Icons.widgets),
            title: Text('Widget'),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Pemberitahuan(),
                ),
              );
            },
            leading: Icon(Icons.notifications),
            title: Text('Pemberitahuan'),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ThemePage(),
                ),
              );
            },
            leading: Icon(Icons.color_lens),
            title: Text('Tema'),
          ),
          Divider(thickness: 1),
          ListTile(
            title: Text(
              'Tanggal AAAA Waktu',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DateFormatPage(),
                ),
              );
            },
            leading: Icon(Icons.calendar_today),
            title: Text('Format Tanggal'),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TimeFormatPage(),
                ),
              );
            },
            leading: Icon(Icons.access_time),
            title: Text('Format Waktu'),
          ),
          Divider(thickness: 1),
          ListTile(
            title: Text(
              'Tentang',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LanguagePage(),
                ),
              );
            },
            leading: Icon(Icons.language),
            title: Text('Bahasa'),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SupportPage(),
                ),
              );
            },
            leading: Icon(Icons.favorite),
            title: Text('Dukung Kami'),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FeedbackPage(),
                ),
              );
            },
            leading: Icon(Icons.chat),
            title: Text('Kritik dan Saran'),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PrivacyPolicy(),
                ),
              );
            },
            leading: Icon(Icons.privacy_tip),
            title: Text('Kebijakan Privasi'),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Versi Aplikasi : 1.02.24.0407.1'),
          ),
        ],
      ),
    );
  }
}
