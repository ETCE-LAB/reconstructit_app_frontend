import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../components/AppIconButton.dart';
import 'abstract_camera_body.dart';

/// cameras available of the device, initialized in main
late List<CameraDescription> cameras;

/// This Widget represents the CameraScreen, initializes the camera controller
///
/// This screen makes it possible to take a picture
/// Screen provides two additional actions:
/// - use this image and call [toNextScreenWithImage], most likely
///   go to the preview screen
/// - not take an image [toNextScreenWithoutImage] if null, the opportunity is
///   not given
class CameraScreen extends StatefulWidget {
  final Function(String) toNextScreenWithImage;
  final Function()? toNextScreenWithoutImage;

  const CameraScreen({
    super.key,
    this.toNextScreenWithoutImage,
    required this.toNextScreenWithImage,
  });

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  late Future<void> _cameraValue;
  bool isCameraFront = false;
  final picker = ImagePicker();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(
      cameras[currentIndex],
      ResolutionPreset.high,
      enableAudio: false,
    );
    _cameraValue = _cameraController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return AbstractCameraBody(
      imagePreview: FutureBuilder(
        future: _cameraValue,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return AspectRatio(
              aspectRatio: 1 / _cameraController!.value.aspectRatio,
              child: _cameraController!.buildPreview(),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),

      photoTaken: false,
      children: [

        AppIconButton(
          onPressed: () {
            takePhoto(context);
          },
          icon: const Icon(Icons.circle_outlined, size: 42),
        ),
        const SizedBox(width: 40),
        AppIconButton(
          onPressed: () {
            _pickImage();
          },
          icon: const Icon(Icons.image_outlined, size: 42),
        ),
      ],
    );
  }

  void _onImageSelected(BuildContext context, String? imagePath) {
    if (imagePath != null && imagePath.isNotEmpty) {
      widget.toNextScreenWithImage(imagePath);
    }
  }

  void toggleCameraFront() {
    setState(() {
      isCameraFront = !isCameraFront;
    });
    int cameraPos = isCameraFront ? 0 : 1;
    _cameraController = CameraController(
      cameras[cameraPos],
      ResolutionPreset.high,
      enableAudio: false,
    );
    _cameraValue = _cameraController.initialize();
  }

  void takePhoto(BuildContext context) async {
    XFile file = await _cameraController.takePicture();
    if (!mounted) return;
    _onImageSelected(context, file.path);
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _onImageSelected(context, pickedFile.path);
        //_image = File(pickedFile.path);  // Set the picked image to the state variable
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController.dispose();
  }
}
