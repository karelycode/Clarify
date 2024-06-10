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
        textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme).copyWith(
          titleLarge: GoogleFonts.roboto(textStyle: Theme.of(context).textTheme.bodyLarge,fontSize: 30,color: Colors.white, fontWeight: FontWeight.bold),
          bodyLarge: GoogleFonts.roboto(textStyle: Theme.of(context).textTheme.bodyLarge,fontSize: 30,color: Colors.black, fontWeight: FontWeight.bold),
          bodyMedium: GoogleFonts.roboto(textStyle: Theme.of(context).textTheme.bodyMedium,fontSize: 50,color: Colors.black87, fontStyle: FontStyle.italic),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF121526), brightness: Brightness.dark),
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }


}


