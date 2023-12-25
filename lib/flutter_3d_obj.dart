import 'package:flutter/material.dart';

void main() {
  runApp(const MyFurniture());
}

class MyFurniture extends StatelessWidget {
  const MyFurniture({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('3D Sofa Drag and Drop'),
        ),
        body: const FurnitureScreen(),
      ),
    );
  }
}

class FurnitureScreen extends StatefulWidget {
  const FurnitureScreen({super.key});

  @override
  _FurnitureScreenState createState() => _FurnitureScreenState();
}

class _FurnitureScreenState extends State<FurnitureScreen> {
  String selectedSofaModel = 'Assets/sofa11.avif';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Drag Source
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Draggable<String>(
                data: 'Assets/sofa11.avif',
                feedback: const DraggableItem(item: 'Sofa', isDragging: true),
                childWhenDragging: Container(),
                child: const DraggableItem(item: 'Sofa'),
              ),
            ],
          ),
          // Drag Target
          DragTarget<String>(
            onAccept: (data) {
              setState(() {
                selectedSofaModel = data;
              });
            },
            builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
            ) {
              return Container(
                width: 200.0,
                height: 200.0,
                color: Colors.grey[300],
                child: Center(
                  child: Object3D(
                    size: const Size(150.0, 150.0),
                    path: selectedSofaModel,
                    asset: true,
                         ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
  
  Object3D({required Size size, required String path, required bool asset}) {}
}

class DraggableItem extends StatelessWidget {
  final String item;
  final bool isDragging;

  const DraggableItem({super.key, required this.item, this.isDragging = false});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isDragging ? 0.5 : 1.0,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(16.0),
        color: Colors.blue,
        child: Text(
          item,
          style: const TextStyle(color: Colors.white, fontSize: 18.0),
        ),
      ),
    );
  }
}
