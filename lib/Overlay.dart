import 'package:flutter/material.dart';

void main() {
  runApp(OverImage());
}

class OverImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImageOverlayScreen(),
    );
  }
}

class ImageOverlayScreen extends StatefulWidget {
  @override
  _ImageOverlayScreenState createState() => _ImageOverlayScreenState();
}

class _ImageOverlayScreenState extends State<ImageOverlayScreen> {
  double overlayX = 100.0;
  double overlayY = 100.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Overlay Example'),
      ),
      body: Stack(
        children: [
          Image.asset(
            'Assets/Images/Emptyroom3.jpg', // Background image
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: overlayY,
            left: overlayX,
            child: Draggable(
              child: GestureDetector(
                onTap: () {
                  // Handle tap on the overlay image
                  print('Overlay image tapped');
                },
                child: Image.asset(
                  'Assets/Images/bed2.jpg', // Overlay image
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              feedback: Image.asset(
                'Assets/Images/bed2.jpg', // Overlay image (during drag)
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              onDraggableCanceled: (velocity, offset) {
                setState(() {
                  // Update the position when dragging is complete
                  overlayX = offset.dx;
                  overlayY = offset.dy;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
