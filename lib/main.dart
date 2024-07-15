//Importaciones
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:prueba/pages/splash.dart";

//Método main de la aplicación
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        //Establecemos el tema de la aplicación
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue, brightness: Brightness.light),
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }


}


