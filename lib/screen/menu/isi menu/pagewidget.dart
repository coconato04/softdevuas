import 'package:flutter/material.dart';

class PageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Widget'),
        backgroundColor: Colors.blue.shade900,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Klik tombol TAMBAH untuk menambahkan widget ke Layar Beranda mu. Widget adalah cara cepat dan mudah untuk memeriksa dan membuat tugasmu',
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ContainerWidget(
                text: 'Standar\nUkuran: 3x3',
                buttonText: 'Tambah',
                isTransparent: true,
              ),
              SizedBox(
                width: 12,
              ),
              ContainerWidget(
                text: 'Widget 1',
              ),
              ContainerWidget(
                text: 'Widget 1',
              ),
              ContainerWidget(
                text: 'Lite\nUkuran: 3x2',
                buttonText: 'Tambah',
                isTransparent: true,
              ),
              SizedBox(
                width: 12,
              ),
              ContainerWidget(
                text: 'Widget 2',
              ),
              ContainerWidget(
                text: 'Widget 2',
              ),
              ContainerWidget(
                text: 'Bulan\nUkuran: 4x4',
                buttonText: 'Tambah',
                isTransparent: true,
              ),
              SizedBox(
                width: 12,
              ),
              ContainerWidget(
                text: 'Widget 3',
              ),
              ContainerWidget(
                text: 'Widget 3',
              ),
              ContainerWidget(
                text: 'Minggu\nUkuran: 4x4',
                buttonText: 'Tambah',
                isTransparent: true,
              ),
              SizedBox(
                width: 12,
              ),
              ContainerWidget(
                text: 'Widget 4',
              ),
              ContainerWidget(
                text: 'Widget 4',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ContainerWidget extends StatelessWidget {
  final String text;
  final String buttonText;
  final bool isTransparent;

  const ContainerWidget({
    required this.text,
    this.buttonText = '',
    this.isTransparent = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: isTransparent ? Colors.transparent : Colors.grey[300],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          if (buttonText.isNotEmpty)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade900,
              ),
              onPressed: () {},
              child: Text(buttonText),
            ),
        ],
      ),
    );
  }
}
