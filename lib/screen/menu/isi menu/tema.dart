import 'package:flutter/material.dart';

class ThemePage extends StatefulWidget {
  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  bool isRedSelected = false;
  bool isBlueSelected = false;
  bool isGreenSelected = false;
  bool isLimeSelected = false;
  bool isIndigoSelected = false;
  bool isYellowSelected = false;
  bool isPurpleSelected = false;
  bool isBlueGreySelected = false;
  bool isOrangeSelected = false;
  bool isBlackSelected = false;

  bool isTexture1Selected = false;
  bool isTexture2Selected = false;
  bool isTexture3Selected = false;
  bool isTexture4Selected = false;

  bool isScenery1Selected = false;
  bool isScenery2Selected = false;
  bool isScenery3Selected = false;
  bool isScenery4Selected = false;
  bool isScenery5Selected = false;
  bool isScenery6Selected = false;
  bool isScenery7Selected = false;
  bool isScenery8Selected = false;

  void selectColor(int colorIndex) {
    setState(() {
      isRedSelected = colorIndex == 1 ? !isRedSelected : false;
      isBlueSelected = colorIndex == 2 ? !isBlueSelected : false;
      isGreenSelected = colorIndex == 3 ? !isGreenSelected : false;
      isLimeSelected = colorIndex == 4 ? !isLimeSelected : false;
      isIndigoSelected = colorIndex == 5 ? !isIndigoSelected : false;
      isYellowSelected = colorIndex == 6 ? !isYellowSelected : false;
      isPurpleSelected = colorIndex == 7 ? !isPurpleSelected : false;
      isBlueGreySelected = colorIndex == 8 ? !isBlueGreySelected : false;
      isOrangeSelected = colorIndex == 9 ? !isOrangeSelected : false;
      isBlackSelected = colorIndex == 10 ? !isBlackSelected : false;
    });
  }

  void selectTexture(int textureIndex) {
    setState(() {
      isTexture1Selected = textureIndex == 1 ? !isTexture1Selected : false;
      isTexture2Selected = textureIndex == 2 ? !isTexture2Selected : false;
      isTexture3Selected = textureIndex == 3 ? !isTexture3Selected : false;
      isTexture4Selected = textureIndex == 4 ? !isTexture4Selected : false;
    });
  }

  void selectScenery(int sceneryIndex) {
    setState(() {
      isScenery1Selected = sceneryIndex == 1 ? !isScenery1Selected : false;
      isScenery2Selected = sceneryIndex == 2 ? !isScenery2Selected : false;
      isScenery3Selected = sceneryIndex == 3 ? !isScenery3Selected : false;
      isScenery4Selected = sceneryIndex == 4 ? !isScenery4Selected : false;
      isScenery5Selected = sceneryIndex == 5 ? !isScenery5Selected : false;
      isScenery6Selected = sceneryIndex == 6 ? !isScenery6Selected : false;
      isScenery7Selected = sceneryIndex == 7 ? !isScenery7Selected : false;
      isScenery8Selected = sceneryIndex == 8 ? !isScenery8Selected : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Tema'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Text(
            'Warna Polos',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => selectColor(1),
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 30,
                    foregroundColor:
                        isRedSelected ? Colors.yellow : Colors.transparent,
                    child: isRedSelected
                        ? Icon(Icons.check, color: Colors.black)
                        : null,
                  ),
                ),
                SizedBox(width: 16),
                GestureDetector(
                  onTap: () => selectColor(2),
                  child: CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 30,
                    foregroundColor:
                        isBlueSelected ? Colors.yellow : Colors.transparent,
                    child: isBlueSelected
                        ? Icon(Icons.check, color: Colors.black)
                        : null,
                  ),
                ),
                SizedBox(width: 16),
                GestureDetector(
                  onTap: () => selectColor(3),
                  child: CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 30,
                    foregroundColor:
                        isGreenSelected ? Colors.yellow : Colors.transparent,
                    child: isGreenSelected
                        ? Icon(Icons.check, color: Colors.black)
                        : null,
                  ),
                ),
                SizedBox(width: 16),
                GestureDetector(
                  onTap: () => selectColor(4),
                  child: CircleAvatar(
                    backgroundColor: Colors.lime,
                    radius: 30,
                    foregroundColor:
                        isLimeSelected ? Colors.yellow : Colors.transparent,
                    child: isLimeSelected
                        ? Icon(Icons.check, color: Colors.black)
                        : null,
                  ),
                ),
                SizedBox(width: 16),
                GestureDetector(
                  onTap: () => selectColor(5),
                  child: CircleAvatar(
                    backgroundColor: Colors.indigo,
                    radius: 30,
                    foregroundColor:
                        isIndigoSelected ? Colors.yellow : Colors.transparent,
                    child: isIndigoSelected
                        ? Icon(Icons.check, color: Colors.black)
                        : null,
                  ),
                ),
                SizedBox(width: 16),
                GestureDetector(
                  onTap: () => selectColor(6),
                  child: CircleAvatar(
                    backgroundColor: Colors.yellow,
                    radius: 30,
                    foregroundColor:
                        isYellowSelected ? Colors.yellow : Colors.transparent,
                    child: isYellowSelected
                        ? Icon(Icons.check, color: Colors.black)
                        : null,
                  ),
                ),
                SizedBox(width: 16),
                GestureDetector(
                  onTap: () => selectColor(7),
                  child: CircleAvatar(
                    backgroundColor: Colors.deepPurple,
                    radius: 30,
                    foregroundColor:
                        isPurpleSelected ? Colors.yellow : Colors.transparent,
                    child: isPurpleSelected
                        ? Icon(Icons.check, color: Colors.black)
                        : null,
                  ),
                ),
                SizedBox(width: 16),
                GestureDetector(
                  onTap: () => selectColor(8),
                  child: CircleAvatar(
                    backgroundColor: Colors.blueGrey,
                    radius: 30,
                    foregroundColor:
                        isBlueGreySelected ? Colors.yellow : Colors.transparent,
                    child: isBlueGreySelected
                        ? Icon(Icons.check, color: Colors.black)
                        : null,
                  ),
                ),
                SizedBox(width: 16),
                GestureDetector(
                  onTap: () => selectColor(9),
                  child: CircleAvatar(
                    backgroundColor: Colors.orange,
                    radius: 30,
                    foregroundColor:
                        isOrangeSelected ? Colors.yellow : Colors.transparent,
                    child: isOrangeSelected
                        ? Icon(Icons.check, color: Colors.black)
                        : null,
                  ),
                ),
                SizedBox(width: 16),
                GestureDetector(
                  onTap: () => selectColor(10),
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 30,
                    foregroundColor:
                        isBlackSelected ? Colors.yellow : Colors.transparent,
                    child: isBlackSelected
                        ? Icon(Icons.check, color: Colors.black)
                        : null,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 32),
          Text(
            'Tekstur',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => selectTexture(1),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/item/p1.jpeg'),
                  radius: 30,
                  foregroundColor:
                      isTexture1Selected ? Colors.yellow : Colors.transparent,
                  child: isTexture1Selected
                      ? Icon(Icons.check, color: Colors.black)
                      : null,
                ),
              ),
              GestureDetector(
                onTap: () => selectTexture(2),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/item/p2.jpeg'),
                  radius: 30,
                  foregroundColor:
                      isTexture2Selected ? Colors.yellow : Colors.transparent,
                  child: isTexture2Selected
                      ? Icon(Icons.check, color: Colors.black)
                      : null,
                ),
              ),
              GestureDetector(
                onTap: () => selectTexture(3),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/item/p3.jpeg'),
                  radius: 30,
                  foregroundColor:
                      isTexture3Selected ? Colors.yellow : Colors.transparent,
                  child: isTexture3Selected
                      ? Icon(Icons.check, color: Colors.black)
                      : null,
                ),
              ),
              GestureDetector(
                onTap: () => selectTexture(4),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/item/p4.jpeg'),
                  radius: 30,
                  foregroundColor:
                      isTexture4Selected ? Colors.yellow : Colors.transparent,
                  child: isTexture4Selected
                      ? Icon(Icons.check, color: Colors.black)
                      : null,
                ),
              ),
            ],
          ),
          SizedBox(height: 32),
          Text(
            'Pemandangan',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => selectScenery(1),
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color:
                          isScenery1Selected ? Colors.yellow : Colors.blueGrey,
                    ),
                    child: Stack(
                      children: [
                        Image.asset('assets/item/p2.jpeg'),
                        if (isScenery1Selected)
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Icon(Icons.check, color: Colors.black),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => selectScenery(2),
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color:
                          isScenery2Selected ? Colors.yellow : Colors.blueGrey,
                    ),
                    child: Stack(
                      children: [
                        Image.asset('assets/item/p3.jpeg'),
                        if (isScenery2Selected)
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Icon(Icons.check, color: Colors.black),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => selectScenery(3),
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color:
                          isScenery3Selected ? Colors.yellow : Colors.blueGrey,
                    ),
                    child: Stack(
                      children: [
                        Image.asset('assets/item/p4.jpeg'),
                        if (isScenery3Selected)
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Icon(Icons.check, color: Colors.black),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => selectScenery(4),
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color:
                          isScenery4Selected ? Colors.yellow : Colors.blueGrey,
                    ),
                    child: Stack(
                      children: [
                        Image.asset('assets/item/p5.jpeg'),
                        if (isScenery4Selected)
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Icon(Icons.check, color: Colors.black),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => selectScenery(5),
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color:
                          isScenery5Selected ? Colors.yellow : Colors.blueGrey,
                    ),
                    child: Stack(
                      children: [
                        Image.asset('assets/item/p6.jpeg'),
                        if (isScenery5Selected)
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Icon(Icons.check, color: Colors.black),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => selectScenery(6),
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color:
                          isScenery6Selected ? Colors.yellow : Colors.blueGrey,
                    ),
                    child: Stack(
                      children: [
                        Image.asset('assets/item/p7.jpeg'),
                        if (isScenery6Selected)
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Icon(Icons.check, color: Colors.black),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => selectScenery(7),
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color:
                          isScenery7Selected ? Colors.yellow : Colors.blueGrey,
                    ),
                    child: Stack(
                      children: [
                        Image.asset('assets/item/p8.jpeg'),
                        if (isScenery7Selected)
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Icon(Icons.check, color: Colors.black),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => selectScenery(8),
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color:
                          isScenery8Selected ? Colors.yellow : Colors.blueGrey,
                    ),
                    child: Stack(
                      children: [
                        Image.asset('assets/item/p1.jpeg'),
                        if (isScenery8Selected)
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Icon(Icons.check, color: Colors.black),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
