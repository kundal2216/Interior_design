import 'package:flutter/material.dart';

void main() {
  runApp(DragImage());
}

class DragImage extends StatelessWidget {
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

class DraggableItem extends StatelessWidget {
  final String imagePath;
  final bool dragging;

  const DraggableItem({required this.imagePath, this.dragging = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: dragging ? Colors.transparent : Colors.blue,
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _DragAndDropScreenState extends State<DragAndDropScreen> {
  List<String> imagePaths = [
    'Assets/Images/sofa.jpg',
    'Assets/Images/diningtable5.jpg',
    'Assets/Images/interior_design.png',
    // Add more image paths as needed
  ];

  List<DraggableItemData> draggedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drag and Drop Images'),
      ),
      body: Stack(
        children: [
          for (int i = 0; i < draggedItems.length; i++)
            Positioned(
              left: draggedItems[i].position.dx,
              top: draggedItems[i].position.dy,
              child: Draggable(
                data: draggedItems[i],
                child: DraggableItem(imagePath: draggedItems[i].imagePath),
                feedback: DraggableItem(
                  imagePath: draggedItems[i].imagePath,
                  dragging: true,
                ),
                childWhenDragging: Container(),
                onDraggableCanceled: (_, __) {
                  setState(() {
                    draggedItems[i].position = Offset(__.dx, __.dy);
                  });
                },
              ),
            ),
        ],
      ),
    );
  }
}



class DraggableItemData {
  String imagePath;
  Offset position;

  DraggableItemData({required this.imagePath, required this.position});
}
