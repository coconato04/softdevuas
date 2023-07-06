import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kebijakan Privasi'),
        backgroundColor: Colors.blue.shade900,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'TO-DO LIST : Planning & Reminder',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Aplikasi ini dibuat sebagai Project akhir untuk UAS Software Developer',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Aplikasi to-do list adalah aplikasi yang dirancang untuk membantu pengguna dalam mengatur dan mengelola tugas-tugas harian, pekerjaan, atau proyek-proyek tertentu. Tujuan utama dari aplikasi to-do list adalah membantu pengguna dalam merencanakan dan mengingat tugas-tugas yang perlu dilakukan.',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16.0),
            Text(
              'Aplikasi to-do list yang saya buat sudah memiliki fitur-fitur berikut:',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '1. ',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Pembuatan Tugas: Pengguna dapat membuat daftar tugas dengan judul, deskripsi, dan tenggat waktu.',
                          style: TextStyle(fontSize: 16.0),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '2. ',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Pengelompokan Tugas: Tugas dapat dikelompokkan ke dalam kategori atau proyek tertentu untuk membantu pengguna dalam mengorganisasi dan memprioritaskan tugas-tugas mereka.',
                          style: TextStyle(fontSize: 16.0),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '3. ',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Pengingat: Aplikasi to-do list sudah dilengkapi dengan fitur pengingat untuk memberi tahu pengguna tentang tugas yang harus dilakukan melalui notifikasi atau pemberitahuan.',
                          style: TextStyle(fontSize: 16.0),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '4. ',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Penyelesaian Tugas: Pengguna dapat menandai tugas sebagai selesai ketika sudah selesai dikerjakan.',
                          style: TextStyle(fontSize: 16.0),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '5. ',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Tampilan Jadwal: Aplikasi to-do list memiliki tampilan jadwal atau kalender yang menampilkan tugas-tugas yang perlu dilakukan pada tanggal atau waktu tertentu.',
                          style: TextStyle(fontSize: 16.0),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Dengan aplikasi to-do list, pengguna dapat mengatur jadwal, mengingat tugas-tugas yang perlu dilakukan, dan lebih terorganisir dalam menyelesaikan pekerjaan atau proyek mereka.',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
