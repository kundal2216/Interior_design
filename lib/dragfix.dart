import 'package:flutter/material.dart';


void main() {
  runApp(const MyFurniture());
}

class MyFurniture extends StatelessWidget {
  const MyFurniture({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DragAndDropScreen(),
    );
  }
}

class DragAndDropScreen extends StatefulWidget {
  const DragAndDropScreen({super.key});

  @override
  _DragAndDropScreenState createState() => _DragAndDropScreenState();
}

class _DragAndDropScreenState extends State<DragAndDropScreen> {
  String draggableData = 'Assets/Images/sofa10.jpeg';
  String dragTargetData = 'Assets/Images/hall.jpg'; // Add a variable for DragTarget data


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drag and Drop Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Draggable(
                data: draggableData,
                feedback: Container(
                  width: 100,
                  height: 50,
                  color: Colors.blue.withOpacity(0.5),
                  child: Center(
                    child: Image.asset(
                      draggableData,
                      fit: BoxFit.cover,
                      height: 50,
                      width: 100,
                      //style: const TextStyle(color: Colors.white),
                      ),
                  ),
                ),
                childWhenDragging: Container(),
                child: Container(
                  width: 100,
                  height: 50,
                  color: Colors.blue,
                  child: Center(
                    child: Image.asset(
                      draggableData,
                      fit: BoxFit.cover,
                      height: 50,
                      width: 100,
                      //style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 20),
            DragTarget(
              builder: (BuildContext context, List<String?> candidateData, List<dynamic> rejectedData) {
                return Container(
                  width: 1000,
                  height: 500,
                  color: Colors.green,
                  child: Center(
                    child: Image.asset(
                      dragTargetData,
                      fit: BoxFit.cover,
                      height: 500,
                      width: 1000, // Use the separate variable here
                      //style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
              onAccept: (String data) {
                setState(() {
                  dragTargetData = 'Assets/Images/room interior6.jpg'; // Change the DragTarget data here
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}