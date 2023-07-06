import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:event_bus/event_bus.dart';

class _ChangeCircleColorToGreenEvent {}

class NotificationHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Meminta izin akses notifikasi
    // Periksa jika izin akses notifikasi sudah diberikan
    PermissionStatus permissionStatus = await Permission.notification.status;
    if (permissionStatus.isGranted) {
      // Jika izin sudah diberikan, buat saluran notifikasi
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(AndroidNotificationChannel(
            'channel_id',
            'Channel Name',
            importance: Importance.max,
            vibrationPattern: Int64List.fromList([0, 1000, 500, 1000]),
            playSound: true,
          ));
    }
  }

  void checkPermissionStatus() async {
    // Periksa status izin akses notifikasi
    PermissionStatus status = await Permission.notification.status;

    if (status.isGranted) {
      // Izin telah diberikan, tampilkan notifikasi
      _showNotification('', '');
    } else {
      // Izin belum diberikan, minta izin akses notifikasi
      if (await Permission.notification.request().isGranted) {
        // Izin telah diberikan setelah permintaan
        _showNotification('', '');
      } else {
        // Izin ditolak oleh pengguna
        // Tambahkan penanganan kasus ketika izin ditolak
      }
    }
  }

  void _showNotification(String subtask, String description) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel_id',
      'Channel Name',
      importance: Importance.max,
      enableVibration: true,
      playSound: true,
      styleInformation: BigTextStyleInformation(''),
      actions: [
        AndroidNotificationAction(
          'complete_action',
          'Selesai',
          //icon: 'complete_icon',
        ),
        AndroidNotificationAction(
          'snooze_action',
          'Tunda',
          //icon: 'snooze_icon',
        ),
      ],
    );

    final notificationTitle = subtask;
    final notificationBody = description;

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      notificationTitle,
      notificationBody,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  final EventBus eventBus = EventBus();
  Future selectNotification(String? payload) async {
    if (payload == 'complete_action') {
      // Tindakan ketika notifikasi selesai dipilih
      eventBus.fire(_ChangeCircleColorToGreenEvent());
    } else if (payload == 'snooze_action') {
      // Tindakan ketika notifikasi tunda dipilih
      // Tampilkan notifikasi kembali sesuai opsi tunda waktunya
      await showSnoozeNotification();
    }
  }

  Future<void> showSnoozeNotification() async {
    final selectedDelay = await showSnoozeOptionsDialog();
    if (selectedDelay != null) {
      final int delaySeconds = getDelaySeconds(selectedDelay);
      await scheduleSnoozeNotification(delaySeconds);
    }
  }

  Future<String?> showSnoozeOptionsDialog() async {
    // Implementasikan logika untuk menampilkan dialog dengan pilihan tunda
    // dan mengembalikan pilihan yang dipilih oleh pengguna
    // Misalnya, menggunakan showDialog atau package lainnya
    return null;
  }

  int getDelaySeconds(String selectedDelay) {
    switch (selectedDelay) {
      case '1 Menit':
        return 60;
      case '5 Menit':
        return 300;
      case '15 Menit':
        return 900;
      case '1 Jam':
        return 3600;
      default:
        return 0;
    }
  }

  Future<void> scheduleSnoozeNotification(int delaySeconds) async {
    // Implementasikan logika untuk menjadwalkan notifikasi tunda sesuai dengan opsi yang dipilih
    // Gunakan flutterLocalNotificationsPlugin untuk menjadwalkan notifikasi dengan penundaan tertentu
    // Misalnya, gunakan metode flutterLocalNotificationsPlugin.zonedSchedule untuk menjadwalkan notifikasi dengan zona waktu yang ditentukan
  }
}
