import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:softdevuas/screen/kalender/kalender.dart';
import 'package:softdevuas/screen/menu/sidebar.dart';
import 'package:softdevuas/screen/profile/profil.dart';
import 'package:softdevuas/screen/work/work.dart';

class Navbar extends StatefulWidget {
  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> with SingleTickerProviderStateMixin {
  bool _sidebarOpen = false;
  late AnimationController _animationController;
  late Animation<double> _animation;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  int _currentIndex = 1;
  late List<Widget> _widgetOptions;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _widgetOptions = [
      Sidebar(),
      Work(flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin),
      Calendar(),
      Profil(),
    ];
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleSidebar() {
    setState(() {
      _sidebarOpen = !_sidebarOpen;
      if (_sidebarOpen) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      _toggleSidebar();
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: Center(
              child: _widgetOptions[_currentIndex],
            ),
          ),
          if (_sidebarOpen)
            GestureDetector(
              onTap: () {
                _toggleSidebar();
              },
              child: Container(
                color: Colors.black.withOpacity(0.6),
              ),
            ),
          Positioned(
            top: 0,
            bottom: 0,
            left: _sidebarOpen ? 0 : -300,
            width: 300,
            child: Sidebar(),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'Menu',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Tugas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Kalender',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
          selectedItemColor: Colors.blue.shade900,
          unselectedItemColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 10.0,
          selectedFontSize: 12.0,
          unselectedFontSize: 12.0,
        ),
      ),
    );
  }
}
