
import 'package:flutter/material.dart';

import 'datosPersonales.dart';

class Cuenta extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MyCuenta();
  }

}

class MyCuenta extends State<Cuenta>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121526),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121526),
        title: Text('Cuenta'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navegar a otra página al presionar este botón
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Datos()),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 80.0), // Establecer una altura mínima
                backgroundColor: Color(0xFF00ACE6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13.0), // Agregar bordes redondeados
                ),
              ),
              child: Text(
                'Datos personales',
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 40.0),


          ],
        ),
      ),
    );
  }

}