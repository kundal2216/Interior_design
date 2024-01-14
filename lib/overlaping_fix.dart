import 'package:flutter/material.dart';

void main() {
  runApp(Overlap());
}

class Overlap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DragAndDropScreen(),
    );
  }
}

class DragAndDropScreen extends StatefulWidget {
  @override
  _DragAndDropScreenState createState() => _DragAndDropScreenState();
}

class _DragAndDropScreenState extends State<DragAndDropScreen> {
  double _firstImageX = 0.0;
  double _firstImageY = 0.0;

  double _secondImageX = 200.0;
  double _secondImageY = 200.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drag and Drop Images'),
      ),
      body: Center(
        child: Stack(
          children: [
            Positioned(
              left: _firstImageX,
              top: _firstImageY,
              child: Draggable(
                data: 'image1',
                child: Image.asset(
                  'Assets/Images/sofa.jpg',
                  width: 100.0,
                  height: 100.0,
                ),
                feedback: Image.asset(
                  'Assets/Images/sofa.jpg',
                  width: 100.0,
                  height: 100.0,
                ),
                onDraggableCanceled: (velocity, offset) {
                  setState(() {
                    _firstImageX = offset.dx;
                    _firstImageY = offset.dy;
                  });
                },
              ),
            ),
            Positioned(
              left: _secondImageX,
              top: _secondImageY,
              child: DragTarget<String>(
                builder: (context, candidateData, rejectedData) {
                  return Image.asset(
                    'Assets/Images/Interior_design.png',
                    width: 100.0,
                    height: 100.0,
                  );
                },
                onWillAccept: (data) {
                  // You can add conditions here if needed
                  return true;
                },
                onAccept: (data) {
                  setState(() {
                    // Handle the drop here, update the position of the second image
                    _secondImageX = _secondImageX + 20.0;
                    _secondImageY = _secondImageY + 20.0;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
