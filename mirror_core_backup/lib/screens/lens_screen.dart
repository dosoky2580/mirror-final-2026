import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../services/mirror_lens.dart';

class LensScreen extends StatefulWidget {
  @override
  _LensScreenState createState() => _LensScreenState();
}

class _LensScreenState extends State<LensScreen> {
  CameraController? _controller;
  final MirrorLens _lens = MirrorLens();
  String _translatedResult = "وجه العدسة نحو النص";

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    _controller = CameraController(cameras[0], ResolutionPreset.high);
    await _controller!.initialize();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) return Container();
    return Scaffold(
      body: Stack(
        children: [
          CameraPreview(_controller!),
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Container(
              padding: EdgeInsets.all(15),
              color: Colors.black54,
              child: Text(_translatedResult, style: TextStyle(color: Colors.white)),
            ),
          ),
          Positioned(
            bottom: 120,
            right: 30,
            child: FloatingActionButton(
              onTap: () async {
                final image = await _controller!.takePicture();
                final result = await _lens.scanAndTranslate(image, "ar");
                setState(() { _translatedResult = result; });
              },
              child: Icon(Icons.translate),
            ),
          )
        ],
      ),
    );
  }
}
