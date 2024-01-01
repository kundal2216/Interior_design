import 'package:flutter/material.dart';
import 'package:flutter_application_1/Data/Data.dart';
import 'package:flutter_application_1/Widget/draggable_widget.dart';
import '../data/data.dart';

void main() {
  runApp(Overlap_fix());
}

class Overlap_fix extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InteriorDesignScreen(),
    );
  }
}

class InteriorDesignScreen extends StatefulWidget {
  @override
  _InteriorDesignScreenState createState() => _InteriorDesignScreenState();
}

class _InteriorDesignScreenState extends State<InteriorDesignScreen> {
  List<FurnitureItem> furnitureItems = [
  ];

  List<FurnitureItem> Table = [];


    //   FurnitureItem('Sofa', 'Assets/Images/sofa.jpg'),
    // FurnitureItem('Bed', 'Assets/Images/chair5.jpg'),
    // FurnitureItem('Table', 'Assets/Images/lamps.jpg'),
    // // Add more furniture items as needed

  List<PlacedFurniture> placedFurniture = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Interior Design App'),
      ),
      body: Center(
        child: Row(
          children: [
            // Furniture List
            Container(
              width: 150.0,
              child: ListView.builder(
                itemCount: furnitureItems.length,
                itemBuilder: (context, index) {
                  return Draggable(
                    data: furnitureItems[index],
                    child: FurnitureItemWidget(furnitureItems[index]),
                    feedback: FurnitureItemWidget(furnitureItems[index], isDragging: true),
                    childWhenDragging: Container(),
                  );
                },
              ),
            ),
            // Room Canvas
            Expanded(
              child: DragTarget<FurnitureItem>(
                builder: (context, candidateData, rejectedData) {
                  return Container(
                    color: Colors.grey[300],
                    child: Stack(
                      children: placedFurniture.map((furniture) {
                        return Positioned(
                          left: furniture.x,
                          top: furniture.y,
                          child: Draggable(
                            data: furniture,
                            child: FurnitureItemWidget(furniture.item),
                            feedback: FurnitureItemWidget(furniture.item, isDragging: true),
                            childWhenDragging: Container(),
                            onDraggableCanceled: (velocity, offset) {
                              setState(() {
                                furniture.x = offset.dx;
                                furniture.y = offset.dy;
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
                onWillAccept: (data) {
                  // You can add conditions here if needed
                  return true;
                },
                onAccept: (data) {
                  setState(() {
                    placedFurniture.add(PlacedFurniture(data, 0, 0));
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

class FurnitureItem {
  final String name;
  final String imageUrl;

  FurnitureItem(this.name, this.imageUrl);
}

class PlacedFurniture {
  final FurnitureItem item;
  double x;
  double y;

  PlacedFurniture(this.item, this.x, this.y);
}

class FurnitureItemWidget extends StatelessWidget {
  final FurnitureItem item;
  final bool isDragging;

  FurnitureItemWidget(this.item, {this.isDragging = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(item.imageUrl),
          fit: BoxFit.cover,
        ),
        border: Border.all(
          color: isDragging ? Colors.blue : Colors.black,
          width: 2.0,
        ),
      ),
      child: Center(
        child: Text(
          item.name,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
