import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'camera.dart';
import 'configuration.dart';

final FlutterTts flutterTts = FlutterTts();

class Start extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    flutterTts.speak('Bienvenido a Claify, en este momento te encuentras en la pantalla de inicio, puedes comenzar la detección presionando los botones o llamando a tu asistente clarify');
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
        buttonName = 'Inicio';
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
      body: Center(
        child: _children[_selectedIndex],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox.fromSize(
        size: Size.square(110),
        child: FloatingActionButton(
          onPressed: (){},
          child: Icon(Icons.mic, size: 70.0,),
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          shape: const CircleBorder(),
        )

      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Theme.of(context).colorScheme.surface,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: colorScheme.onSurface.withOpacity(.80),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled, size: 50),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, size: 50,),
            label: 'Configuración',
          ),
        ],
      ),
    );
  }
}
