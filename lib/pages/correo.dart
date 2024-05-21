import 'package:flutter/material.dart';

import 'cuenta.dart';
import 'datosPersonales.dart';

class Correo extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MyCorreo();
  }

}

class MyCorreo extends State<Correo>{
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
                  MaterialPageRoute(builder: (context) => Correo()),
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
                'Cambiar correo',
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: () {
                // Navegar a otra página al presionar este botón
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Cuenta()),
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
                'Restaurar información',
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 200.0),
            ElevatedButton(
              onPressed: () {
                // Navegar a otra página al presionar este botón
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Cuenta()),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 80.0), // Establecer una altura mínima
                backgroundColor: Color(0xFF4C5EE6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13.0), // Agregar bordes redondeados
                ),
              ),
              child: Text(
                'Guardar cambios',
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20.0),

          ],
        ),
      ),
    );
  }
}