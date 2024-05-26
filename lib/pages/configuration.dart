
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'cuenta.dart';

class Configuration extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MyConfiguration();
  }

}


class MyConfiguration extends State<Configuration> {
  final FlutterTts _flutterTts = FlutterTts();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121526),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121526),
        title: Text('Configuración'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _flutterTts.speak('Configuración de la cuenta');
                // Navegar a otra página al presionar este botón
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Cuenta()),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 80.0),// Establecer una altura mínima
                backgroundColor: Color(0xFF00ACE6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13.0), // Agregar bordes redondeados
                ),
              ),

              child: Text(
                  'Cuenta',
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 40.0),
            
            ElevatedButton(
              onPressed: () {
                _flutterTts.speak('Ayuda');
                // Navegar a otra página al presionar este botón
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Cuenta()),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 80.0),// Establecer una altura mínima
                backgroundColor: Color(0xFF00ACE6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13.0), // Agregar bordes redondeados
                ),
              ),
              child: Text(
                  'Ayuda',
                  style: TextStyle(
                  fontSize: 40.0,
                    color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 250.0),

          ],
        ),
      ),
    );
  }

}