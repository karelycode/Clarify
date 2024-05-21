import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'camera.dart';
import 'configuration.dart';

final FlutterTts flutterTts = FlutterTts();

class Start extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    flutterTts.speak('Bienvenido a Claify, en este momento te encuentras en la pantalla de cámara');
    return _StartApp();

  }
}


class _StartApp extends State<Start> {
  int _selectedIndex = 0;

  final List<Widget> _children = [
    Camera(),
    Configuration(),
  ];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _speakButtonName(index);
    });
  }

  Future<void> _speakButtonName(int index) async {
    String buttonName;
    switch (index) {
      case 0:
        buttonName = 'Cámara';
        break;
      case 1:
        buttonName = 'Configuración';
        break;
      default:
        buttonName = '';
    }
    await flutterTts.speak('Te encuentras en la pantalla de $buttonName');
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: const Color(0xFF121526),
      body: Center(
        child: _children[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Color(0xFF0A0D21),
        selectedItemColor: Color(0xFF00ACE6),
        unselectedItemColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'Cámara',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configuración',
          ),
        ],
      ),
    );
  }
}
