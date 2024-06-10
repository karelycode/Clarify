//Importaciones
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'cuenta.dart';

//Clase principal del widget de Configuración
class Configuration extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MyConfiguration();
  }

}

// Estado del widget de Configuración
class MyConfiguration extends State<Configuration> {
  // Instancia del paquete de síntesis de voz Flutter TTS
  final FlutterTts _flutterTts = FlutterTts();
  //Menu de configuración
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
                // Reproduce el texto "Configuración de la cuenta" utilizando síntesis de voz
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
            
            SizedBox(height: 250.0),

          ],
        ),
      ),
    );
  }

}