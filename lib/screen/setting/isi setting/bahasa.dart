import 'package:flutter/material.dart';

class LanguagePage extends StatelessWidget {
  final List<String> languages = [
    'Afrikaans',
    'Albanian',
    'Arabic',
    'Armenian',
    'Bengali',
    'Chinese',
    'Czech',
    'Danish',
    'Dutch',
    'English',
    'Estonian',
    'Finnish',
    'French',
    'German',
    'Greek',
    'Hindi',
    'Hungarian',
    'Indonesian',
    'Italian',
    'Japanese',
    'Korean',
    'Malay',
    'Norwegian',
    'Persian',
    'Polish',
    'Portuguese',
    'Russian',
    'Spanish',
    'Swedish',
    'Thai',
    'Turkish',
    'Ukrainian',
    'Vietnamese',
  ];

  final List<String> languageCodes = [
    'af',
    'sq',
    'ar',
    'hy',
    'bn',
    'zh',
    'cs',
    'da',
    'nl',
    'en',
    'et',
    'fi',
    'fr',
    'de',
    'el',
    'hi',
    'hu',
    'id',
    'it',
    'ja',
    'ko',
    'ms',
    'no',
    'fa',
    'pl',
    'pt',
    'ru',
    'es',
    'sv',
    'th',
    'tr',
    'uk',
    'vi',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Bahasa'),
        backgroundColor: Colors.blue.shade900,
      ),
      body: ListView.builder(
        itemCount: languages.length,
        itemBuilder: (context, index) {
          final language = languages[index];
          final languageCode = languageCodes[index];
          return ListTile(
            title: Text(language),
            trailing: Text(
              languageCode,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
              ),
            ),
            onTap: () {
              // Lakukan sesuatu ketika bahasa dipilih
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Bahasa Dipilih'),
                    content:
                        Text('Anda memilih bahasa $language ($languageCode).'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Tutup'),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
