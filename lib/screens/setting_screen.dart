import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                  onPressed: () {},
                  label: Text('Light Theme',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  icon: Icon(
                    Icons.sunny,
                    color: Colors.black,
                    size: 40,
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize: Size(50, 80),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)))),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                  onPressed: () {},
                  label: Text('Dark Theme',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  icon: Icon(
                    Icons.dark_mode,
                    color: Colors.white,
                    size: 40,
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: Size(50, 80),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)))),
            ],
          ),
          SizedBox(height: 40,),
                    Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                  onPressed: () {},
                  label: Text('Game Theme',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  icon: Icon(
                    Icons.videogame_asset,
                    color: Colors.white,
                    size: 40,
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF107c10),
                      minimumSize: Size(50, 80),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)))),
            ],
          ),
          // DropdownButton(
          //   items: ['Roboto', 'Arial', 'Courier', 'Times New Roman'].map((font) {
          //       return DropdownMenuItem<String>(
          //         value: font,
          //         child: Text(font, style: TextStyle(fontFamily: font)),
          //       );
          //     }).toList(),
          //   onChanged: (value){

          //   }
          // )
        ],
      ),
    );
  }
}
