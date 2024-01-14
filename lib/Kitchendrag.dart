import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(KitchenDrag());
}

class KitchenDrag extends StatelessWidget {
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
  Map<String, List<Furniture>> furnitureCategories = {
    'Flower pot': [
      Furniture('', 'Assets/Images/flowerpot3.jpeg'),
      Furniture('', 'Assets/Images/flowerpot4.jpeg'),
    ],
    'Ceiling Lamp': [
      Furniture('', 'Assets/Images/ceilinglamp2.jpeg'),
      Furniture('', 'Assets/Images/ceilinglamp4.jpeg'),
    ],
    'Lamp': [
      Furniture('', 'Assets/Images/lamp1.jpeg'),
      Furniture('', 'Assets/Images/lamp2.jpg'),
    ],
    'Dining Table': [
      Furniture('', 'Assets/Images/diningtable4.jpeg'),
      Furniture('', 'Assets/Images/diningtable5.jpeg'),
    ],
    // Add more categories and furniture items as needed
  };
  

  List<PlacedFurniture> placedFurniture = [];

  XFile? backgroundImage;
  bool isDragging = false;

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Interior Design App'),
        elevation: 0, // Remove appbar shadow
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2c3e50), Color(0xFF3498db)],
          ),
        ),
        child: Center(
          child: Row(
            children: [
             // Furniture List
              Container(
                width: 150.0,
                decoration: BoxDecoration(
                  color: Color(0xFF34495e),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(-2, 0),
                      blurRadius: 4.0,
                    ),
                  ],
                ),
                child: ListView.builder(
                  itemCount: furnitureCategories.keys.length,
                  itemBuilder: (context, index) {
                    String category = furnitureCategories.keys.elementAt(index);
                    return Column(
                      children: [
                        SizedBox(height: 16.0),
                        Text(
                          category,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                        ...furnitureCategories[category]!.map((furniture) {
                          return Draggable(
                            data: furniture,
                            feedback:
                                FurnitureItemWidget(furniture, isDragging: true),
                            childWhenDragging: Container(),
                            child: FurnitureItemWidget(furniture),
                          );
                        }).toList(),
                      ],
                    );
                  },
                ),
              ),
              // Room Canvas
              // Room Canvas
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        XFile? selectedImage = await selectBackgroundImage();
                        if (selectedImage != null) {
                          print('Selected image path: ${selectedImage}');
                          setState(() {
                            backgroundImage = selectedImage;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF2980b9),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        'Select Background Image',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: DragTarget<Furniture>(
                        builder: (context, candidateData, rejectedData) {
                          return Container(
                            decoration: backgroundImage != null
                                ? BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                          FileImage(File(backgroundImage!.path)),
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : null,
                            child: Stack(
                              children: placedFurniture.map((furniture) {
                                return Positioned(
                                  left: furniture.x,
                                  top: furniture.y,
                                  child: Draggable(
                                    data: furniture.item,
                                    feedback: FurnitureItemWidget(
                                        furniture.item, isDragging: true),
                                    childWhenDragging: Container(),
                                    onDraggableCanceled: (velocity, offset) {
                                      if (isDragging) {
                                        setState(() {
                                          placedFurniture.removeLast();
                                          isDragging = false;
                                        });
                                      }
                                    },
                                    onDragEnd: (details) {
                                      setState(() {
                                        isDragging = false;
                                        placedFurniture.last.x +=
                                            details.offset.dx;
                                        placedFurniture.last.y +=
                                            details.offset.dy;
                                        if (placedFurniture.length > 1) {
                                          placedFurniture.removeAt(
                                              placedFurniture.length - 2);
                                        }
                                      });
                                    },
                                    onDragStarted: () {
                                      print('Drag started!');
                                      setState(() {
                                        isDragging = true;
                                      });
                                    },
                                    onDragUpdate: (details) {
                                      print(
                                          'Dragging at ${details.globalPosition}');
                                      setState(() {
                                        furniture.x = details.globalPosition!.dx;
                                        furniture.y = details.globalPosition!.dy;
                                      });
                                    },
                                    onDragCompleted: () {
                                      print('Drag completed!');
                                      setState(() {
                                        isDragging = false;
                                      });
                                    },
                                    child: FurnitureItemWidget(
                                      furniture.item,
                                      isDragging: isDragging,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          );
                        },
                        onWillAccept: (data) {
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
            ],
          ),
        ),
      ),
    );
  }

  Future<XFile?> selectBackgroundImage() async {
    final imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    return file!;
  }
}

class Furniture {
  final String name;
  final String imageUrl;

  Furniture(this.name, this.imageUrl);
}

class PlacedFurniture {
  final Furniture item;
  double x;
  double y;

  PlacedFurniture(this.item, this.x, this.y);
}

class FurnitureItemWidget extends StatelessWidget {
  final Furniture item;
  final bool isDragging;

  FurnitureItemWidget(this.item, {this.isDragging = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      child: InteractiveViewer(
        boundaryMargin: EdgeInsets.all(0),
        minScale: 0.5,
        maxScale: 4.0,
        child: Container(
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
        ),
      ),
    );
  }
}