//Importaciones
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:camera/camera.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'image_classification_helper.dart';

//Diccionarios para singular y plural de los objetos
Map<String, String> objetosSingular = {
  "Billete de 20": "billete de 20",
  "Billete de 50": "billete de 50",
  "Billete de 100": "billete de 100",
  "Billete de 200": "billete de 200",
  "Billete de 500": "billete de 500",
  "Billete de 1000": "billete de 1000",
  "Bote": "bote",
  "Celular": "celular",
  "Flor": "flor",
  "Gato": "gato",
  "Perro": "perro",
  "Lentes": "lentes",
  "Llaves": "llaves",
  "Persona": "persona",
  "Teclado": "teclado",
  "Moneda": "moneda",
  "Laptop": "laptop",
  "Silla": "silla",
  "Mesa": "mesa"
};
Map<String, String> objetosPlural = {
  "Billete de 20": "billetes de 20",
  "Billete de 50": "billetes de 50",
  "Billete de 100": "billetes de 100",
  "Billete de 200": "billetes de 200",
  "Billete de 500": "billetes de 500",
  "Billete de 1000": "billetes de 1000",
  "Bote": "botes",
  "Celular": "celulares",
  "Flor": "flores",
  "Gato": "gatos",
  "Perro": "perros",
  "Lentes": "lentes",
  "Llaves": "llaves",
  "Persona": "personas",
  "Teclado": "teclados",
  "Moneda": "monedas",
  "Laptop": "laptops",
  "Silla": "sillas",
  "Mesa": "mesas"
};

//Clase principal del widget de Cámara
class Camera extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CameraState();
  }
}

class _CameraState extends State<Camera> {
  ImageClassificationHelper? imageClassificationHelper;
  Map<String, double>? classification;
  img.Image? image;

  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  final TextRecognizer _textRecognizer =
  TextRecognizer(script: TextRecognitionScript.latin);
  final FlutterTts _flutterTts = FlutterTts();
  String _extractedText = '';
  bool _isProcessing = false;

  @override
  void initState() {
    imageClassificationHelper = ImageClassificationHelper();
    imageClassificationHelper!.initHelper();
    super.initState();
    _initializeControllerFuture = _initializeCamera();
  }

  @override
  void dispose() {
    _controller.dispose();
    _textRecognizer.close();
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    _controller = CameraController(cameras.first, ResolutionPreset.medium);
    return _controller.initialize();
  }

  Future<void> _processImage() async {
    print('_processImage() called');
    if (_isProcessing) return;
    _isProcessing = true;

    try {
      final xfile = await _controller.takePicture();
      final file = File(xfile.path);
      final imageData = await file.readAsBytes();
      final image = img.decodeImage(imageData);
      Map<String, double>? detections = await imageClassificationHelper?.inferenceImage(image!);
      String filteredDetections = createDetectionMessage(detections!, 0.6);

      setState(() {
        _extractedText = filteredDetections.toString();
      });

      await _speakText();
    } catch (e) {
      print('Error: $e');
    }

    _isProcessing = false;
  }

  Future<void> _recognizeText()async{
    if (_isProcessing) return;
    _isProcessing = true;

    try {
      final xfile = await _controller.takePicture();
      final file = File(xfile.path);
      final inputImage = InputImage.fromFile(file);
      final RecognizedText recognizedText = await _textRecognizer.processImage(inputImage);

      setState(() {
        _extractedText = recognizedText.text;
      });

      await _speakText();
    } catch (e) {
      print('Error: $e');
    }

    _isProcessing = false;
  }

  Future<void> _speakText() async {
    await _flutterTts.setLanguage("es-MX");
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.speak("Aquí está el resultado: $_extractedText");
  }
// Función para crear el mensaje de detección
  String createDetectionMessage(Map<String, double> detections, double threshold) {
    // Filtrar las detecciones con base en el porcentaje de confianza
    Map<String, double> filteredDetections = cleanAndFilterDetections(detections, threshold);

    // Si no hay detecciones después del filtrado, retornar mensaje vacío
    if (filteredDetections.isEmpty) {
      return "No se han detectado objetos con suficiente confianza.";
    }
    print("createDetectionMessage 1");
    // Crear una lista de labels sin el número de clase
    List<String> labels = filteredDetections.keys.toList();

    // Contar las ocurrencias de cada label
    Map<String, int> labelCounts = {};
    for (String label in labels) {
      labelCounts[label] = (labelCounts[label] ?? 0) + 1;
    }
    print("createDetectionMessage 2");
    // Crear el mensaje de salida
    String result = labelCounts.length == 1 ? "Se ha detectado" : "Se han detectado";
    List<String> detectedObjects = [];

    // Generar el mensaje con la cantidad y el nombre del objeto en singular o plural
    labelCounts.forEach((label, count) {
      String labelFinal;
      if (count > 1) {
        labelFinal = objetosPlural[label] ?? label;
      } else {
        labelFinal = objetosSingular[label] ?? label;
      }
      detectedObjects.add("$count $labelFinal");
    });

    result += " " + detectedObjects.join(" y ");
    print("Llegó al final de createDetectionMessage");
    print(result);
    return result;
  }

// Función para filtrar y limpiar las detecciones
  Map<String, double> cleanAndFilterDetections(Map<String, double> detections, double threshold) {
    Map<String, double> filteredDetections = {};
    print(detections.toString());
    detections.forEach((key, value) {
      if (value > threshold) {
        // Limpiar la etiqueta eliminando el número de clase al inicio si está presente
        String cleanedLabel = cleanLabel(key);
        filteredDetections[cleanedLabel] = value;
        print("cleanAndFilter dentro del IF");
      }
    });
    print("Llegó al final de cleanAndFilter");
    print(filteredDetections.toString());
    return filteredDetections;
  }

  // Función para limpiar la etiqueta de detección
  String cleanLabel(String label) {
    print("Llegó al final de cleanlabel");
    print(label.replaceFirst(RegExp(r'^\d+\s'), ''));
    return label.replaceFirst(RegExp(r'^\d+\s'), ''); // Eliminar número de clase al inicio
  }

  /*String cleanAndFilterDetections(Map<String, double> detections, double threshold) {
    // Creamos un nuevo mapa para las detecciones filtradas y limpiadas
    String filteredDetections = "";

    detections.forEach((key, value) {
      if (value > threshold) {
        // Quitamos el número de clase al inicio de la etiqueta si está presente
        String label = key.replaceFirst(RegExp(r'^\d+\s'), '');
        filteredDetections+=label+"\n";
      }
    });

    return filteredDetections;
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_controller);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          Positioned(
            bottom: 0.0,
            left: 25,
            right: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 55.0, // Ajusta el radio del botón
                  backgroundColor: Colors.deepPurple, // Color de fondo
                  child: IconButton(
                    icon: Icon(Icons.description, color: Colors.white),
                    iconSize: 70.0,
                    onPressed: () {
                      _flutterTts.speak('Empezará la detección de texto, espera un momento');
                      _recognizeText();
                    },
                  ),
                ),
                Spacer(),
                CircleAvatar(
                  radius: 55.0, // Ajusta el radio del botón
                  backgroundColor: Colors.deepPurple, // Color de fondo
                  child: IconButton(
                    icon: Icon(Icons.camera, color: Colors.white),
                    iconSize: 70.0,
                    onPressed: () {
                      _flutterTts.speak('Empezará la detección de tu entorno, espera un momento');
                      _processImage();
                    },
                  ),
                )

              ],
            ),
          ),
        ],
      ),
    );
  }
}
