import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Furniture {
  final String name;
  final String imageUrl;

  Furniture({required this.name, required this.imageUrl});
}

class FurnitureList {
  static List<Furniture> getFurnitureList() {
    return [
      Furniture(name: "Chair", imageUrl: "https://example.com/chair.jpg"),
      Furniture(name: "Table", imageUrl: "https://example.com/table.jpg"),
      Furniture(name: "Sofa", imageUrl: "https://example.com/sofa.jpg"),
      // Add more furniture items as needed
    ];
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drag and Drop Furniture',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FurnitureScreen(),
    );
  }
}

class FurnitureScreen extends StatefulWidget {
  @override
  _FurnitureScreenState createState() => _FurnitureScreenState();
}

class _FurnitureScreenState extends State<FurnitureScreen> {
  List<Furniture> furnitureList = FurnitureList.getFurnitureList();
  List<Furniture> selectedFurniture = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drag and Drop Furniture'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 200.0,
                  child: DragTarget<Furniture>(
                    builder: (context, candidateData, rejectedData) {
                      return Container(
                        color: Colors.grey[300],
                        child: Center(
                          child: Text(
                            'Drop Zone',
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                      );
                    },
                    onWillAccept: (data) {
                      return true;
                    },
                    onAccept: (data) {
                      setState(() {
                        selectedFurniture.add(data);
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: furnitureList.length,
              itemBuilder: (context, index) {
                return Draggable<Furniture>(
                  data: furnitureList[index],
                  child: FurnitureItem(furniture: furnitureList[index]),
                  feedback: FurnitureItem(furniture: furnitureList[index]),
                  childWhenDragging: Container(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FurnitureItem extends StatelessWidget {
  final Furniture furniture;

  FurnitureItem({required this.furniture});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(
            furniture.imageUrl,
            height: 80.0,
            width: 80.0,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 8.0),
          Text(
            furniture.name,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
