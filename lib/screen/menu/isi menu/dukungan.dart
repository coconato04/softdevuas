import 'package:flutter/material.dart';

class SupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SupportBody(),
    );
  }
}

class SupportBody extends StatefulWidget {
  @override
  _SupportBodyState createState() => _SupportBodyState();
}

class _SupportBodyState extends State<SupportBody> {
  String selectedSupport = '';
  IconData? selectedIcon;

  void showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Icon(
            selectedIcon,
            size: 60,
            color: Colors.blue.shade900,
          ),
          content: Text('Terima kasih telah mendukung kami!'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 16),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Dukung Tim To-do List',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Ini adalah halaman donasi. Anda bisa mentraktir kami makan atau secangkir kopi di sini. '
            'Kami akan sangat berterima kasih atas dorongan baik Anda. '
            'Bagaimanapun, kami merasa berterima kasih kepada Anda menyumbang atau tidak.',
            textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: 32),
        SupportItem(
          icon: Icons.emoji_food_beverage,
          text: 'Sebuah Teh',
          onPressed: () {
            setState(() {
              selectedSupport = 'Teh';
              selectedIcon = Icons.emoji_food_beverage;
            });
          },
          isSelected: selectedSupport == 'Teh',
          selectedColor: Colors.blue.shade900,
        ),
        SizedBox(
          height: 10,
        ),
        SupportItem(
          icon: Icons.emoji_emotions,
          text: 'Sebuah Emoji',
          onPressed: () {
            setState(() {
              selectedSupport = 'Emoji';
              selectedIcon = Icons.emoji_emotions;
            });
          },
          isSelected: selectedSupport == 'Emoji',
          selectedColor: Colors.red,
        ),
        SizedBox(
          height: 10,
        ),
        SupportItem(
          icon: Icons.coffee,
          text: 'Sebuah Kopi',
          onPressed: () {
            setState(() {
              selectedSupport = 'Kopi';
              selectedIcon = Icons.coffee;
            });
          },
          isSelected: selectedSupport == 'Kopi',
          selectedColor: Colors.green,
        ),
        SizedBox(
          height: 10,
        ),
        SupportItem(
          icon: Icons.fastfood,
          text: 'Sebuah Burger',
          onPressed: () {
            setState(() {
              selectedSupport = 'Burger';
              selectedIcon = Icons.fastfood;
            });
          },
          isSelected: selectedSupport == 'Burger',
          selectedColor: Colors.yellow.shade700,
        ),
        SizedBox(
          height: 10,
        ),
        SupportItem(
          icon: Icons.restaurant,
          text: 'Makan malam besar',
          onPressed: () {
            setState(() {
              selectedSupport = 'Makan Malam';
              selectedIcon = Icons.restaurant;
            });
          },
          isSelected: selectedSupport == 'Makan Malam',
          selectedColor: Colors.orange,
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ElevatedButton(
            onPressed: () {
              if (selectedIcon != null) {
                showConfirmationDialog();
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Pilih Dukungan'),
                      content: Text(
                          'Harap pilih salah satu dukungan sebelum mengirim.'),
                    );
                  },
                );
              }
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 10),
              backgroundColor: Colors.blue.shade900,
            ),
            child: Text('DUKUNG', style: TextStyle(fontSize: 18)),
          ),
        ),
      ],
    );
  }
}

class SupportItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  final bool isSelected;
  final Color selectedColor;

  const SupportItem({
    required this.icon,
    required this.text,
    required this.onPressed,
    required this.isSelected,
    required this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelected ? selectedColor : Colors.transparent,
          border: Border.all(
            color: isSelected ? selectedColor : Colors.blue.shade900,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              size: 40,
              color: isSelected ? Colors.white : null,
            ),
            SizedBox(width: 16),
            Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.white : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
