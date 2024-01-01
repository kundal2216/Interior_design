import 'package:flutter/material.dart';
import 'package:flutter_application_1/Data/Data.dart';


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
  final List<furniture> all = Allfurniture;
  final List<furniture> land = [];
  final List<furniture> air = [];
  final List<furniture> hall = [];

  
  
  void removeAll(furniture toRemove) {
    all.removeWhere((furniture) => furniture.imageUrl == toRemove.imageUrl);
    land.removeWhere((furniture) => furniture.imageUrl == toRemove.imageUrl);
    air.removeWhere((furniture) => furniture.imageUrl == toRemove.imageUrl);
  }

  int score = 0 ;
  // String draggableData = 'Assets/Images/sofa10.jpeg';
  // String dragTargetData = 'Assets/Images/hall.jpg'; // Add a variable for DragTarget data

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
            //Image.asset(draggableData),
            //Image.asset(dragTargetData),
            Draggable(
              data: hall,
              feedback: Container(
                width: 100,
                height: 50,
                color: Colors.blue.withOpacity(0.5),
                child: Center(
                  child: Image.asset(
                    hall,
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
                    hall,
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
                      hall,
                      fit: BoxFit.cover,
                      height: 500,
                      width: 1000, // Use the separate variable here
                      //style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
              onWillAccept: (data) => true,
              onAccept: (data) {
            if (acceptTypes.contains(data.type)) {
              Utils.showSnackBar(
                context,
                text: 'This Is Correct 🥳',
                color: Colors.green,
              );
            } else {
              Utils.showSnackBar(
                context,
                text: 'This Looks Wrong 🤔',
                color: Colors.red,
              );
            }

            onAccept(data);
              },
            ),
          ],
        ),
      ),
    );
  }
}


  // Widget buildTarget(
  //   BuildContext context, {
  //   @required List<furniture> furniture,
  //   @required List<furnitureType> acceptTypes,
  //   @required DragTargetAccept<furniture> onAccept,
  // }),
