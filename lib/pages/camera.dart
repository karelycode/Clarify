import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:camera/camera.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'image_classification_helper.dart';

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
      classification = await imageClassificationHelper?.inferenceImage(image!);

      setState(() {
        _extractedText = classification.toString();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121526),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121526),
        title: Text('Camera Stream'),
      ),
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
            bottom: 15.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.description, color: Colors.white),
                  iconSize: 60.0,
                  onPressed: () {
                    _flutterTts.speak('Empezará la detección de texto, espera un momento');
                    _recognizeText();
                  },
                ),
                SizedBox(width: 30.0),
                IconButton(
                  icon: Icon(Icons.camera, color: Colors.white),
                  iconSize: 60.0,
                  onPressed: () {
                    _flutterTts.speak('Empezará la detección de tu entorno, espera un momento');
                    _processImage();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
