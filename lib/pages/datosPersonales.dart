import 'package:flutter/material.dart';

import 'cuenta.dart';

class Datos extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MyDatos();
  }

}

class MyDatos extends State<Datos> {
  final _nameController = TextEditingController();
  final _birthdateController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121526),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121526),
        title: Text('Datos personales'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildEditableTextField('Nombre', _nameController),
            SizedBox(height: 12.0),
            _buildEditableTextField('Fecha de nacimiento', _birthdateController),
            SizedBox(height: 12.0),
            _buildEditableTextField('Teléfono', _phoneController),
            SizedBox(height: 150.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isEditing = !_isEditing;
                });
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 80.0), // Establecer una altura mínima
                backgroundColor: Color(0xFF4C5EE6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13.0), // Agregar bordes redondeados
                ),
              ),
              child: Text(
                _isEditing ? 'Guardar cambios' : 'Editar',
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableTextField(String title, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 30.0, // Ajustar el tamaño de la fuente a 20.0
            fontWeight: FontWeight.bold,
            color: Colors.white, // Cambiar el color del texto a blanco
          ),
        ),
        SizedBox(height: 5.0),
        TextField(
          enabled: _isEditing,
          controller: controller,
          style: TextStyle(color: Colors.white), // Cambiar el color del texto dentro del TextField a negro
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13.0),
                borderSide: BorderSide(color: Color(0xFF00ACE6)),
            ),
            filled: true, // Rellenar el TextField
            fillColor:Color(0xFF00ACE6).withOpacity(0.6), // Cambiar el color de fondo del TextField a gris claro
          ),
        ),
      ],
    );
  }
}

