import 'package:flutter/material.dart';
import 'package:softdevuas/screen/menu/isi%20menu/dukungan.dart';
import 'package:softdevuas/screen/menu/isi%20menu/kritikdansaran.dart';
import 'package:softdevuas/screen/menu/isi%20menu/pagewidget.dart';
import 'package:softdevuas/screen/menu/isi%20menu/tema.dart';
import 'package:softdevuas/screen/setting/setting.dart';

class Sidebar extends StatefulWidget {
  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  bool _isMenuOpen = false;

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.transparent,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue.shade900,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TO-DO LIST',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Planning & Reminder',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            ExpansionTile(
                leading: Icon(Icons.category, color: Colors.black),
                title: Text(
                  'Kategori',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
                onExpansionChanged: (expanded) {
                  _toggleMenu();
                },
                children: [
                  InkWell(
                    onTap: () {
                      // Aksi yang ingin dilakukan saat tombol ditekan
                    },
                    child: ListTile(
                      leading: Icon(Icons.category, color: Colors.black),
                      title: Text(
                        'Semua',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ),
                  ),
                ]),
            InkWell(
              onTap: _toggleMenu,
              child: ListTile(
                leading: Icon(Icons.add, color: Colors.black),
                title: Text(
                  'Buat Baru',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ThemePage(),
                  ),
                );
              },
              child: ListTile(
                leading: Icon(Icons.color_lens, color: Colors.black),
                title: Text(
                  'Tema',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PageWidget(),
                  ),
                );
              },
              child: ListTile(
                leading: Icon(Icons.widgets, color: Colors.black),
                title: Text(
                  'Widget',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FeedbackPage(),
                  ),
                );
              },
              child: ListTile(
                leading: Icon(Icons.feedback, color: Colors.black),
                title: Text(
                  'Kritik & Saran',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SupportPage(),
                  ),
                );
              },
              child: ListTile(
                leading: Icon(Icons.favorite, color: Colors.black),
                title: Text(
                  'Dukung kami',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PengaturanPage()),
                );
                _toggleMenu();
              },
              child: ListTile(
                leading: Icon(Icons.settings, color: Colors.black),
                title: Text(
                  'Pengaturan',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
