import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(HallDrag());
}

class HallDrag extends StatelessWidget {
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
    'Sofa': [
      Furniture('', 'Assets/Images/sofa.jpeg'),
      Furniture('', 'Assets/Images/sofa2.jpeg'),
    ],
    'Table': [
      Furniture('', 'Assets/Images/tableHALL.jpeg'),
      Furniture('', 'Assets/Images/tableHALL2.jpeg'),
    ],
    'Decorative': [
      Furniture('', 'Assets/Images/painting2.jpeg'),
      Furniture('', 'Assets/Images/Decorative.jpeg'),
    ],
    'lamp': [
      Furniture('', 'Assets/Images/lamp3.jpeg'),
      Furniture('', 'Assets/Images/lamp4.jpeg'),
    ],
  };

  List<PlacedFurniture> placedFurniture = [];

  XFile? backgroundImage;
  bool isMenuVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Interior Design App'),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              setState(() {
                isMenuVisible = !isMenuVisible;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF2c3e50), Color(0xFF3498db)],
            ),
          ),
          child: Column(
            children: [
              // Furniture List
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
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
                child: Column(
                  children: [
                    if (!isMenuVisible) // Show only if menu is not visible
                      ...furnitureCategories.keys.map((category) {
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
                            Container(
                              height: 100.0,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: furnitureCategories[category]!.map((furniture) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Draggable(
                                      data: furniture,
                                      feedback: FurnitureItemWidget(furniture),
                                      childWhenDragging: Container(),
                                      child: FurnitureItemWidget(furniture),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        );
                      }),
                  ],
                ),
              ),

              // Room Canvas
              Container(
                width: double.infinity,
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
                    Container(
                      height: MediaQuery.of(context).size.height * 0.6,
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
                                    data: furniture,
                                    feedback: FurnitureItemWidget(furniture.item),
                                    childWhenDragging: Container(),
                                    onDraggableCanceled: (velocity, offset) {
                                      setState(() {
                                        // Remove the isDragging flag
                                        placedFurniture.removeLast();
                                      });
                                    },
                                    onDragEnd: (details) {
                                      setState(() {
                                        furniture.x += details.offset.dx;
                                        furniture.y += details.offset.dy;
                                      });
                                    },
                                    onDragStarted: () {
                                      print('Drag started!');
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
                                    },
                                    child: FurnitureItemWidget(furniture.item),
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

              // Menu Bar
              if (isMenuVisible)
                Container(
                  height: 120.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: placedFurniture.map((furniture) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Draggable(
                          data: furniture,
                          feedback: FurnitureItemWidget(furniture.item),
                          childWhenDragging: Container(),
                          child: FurnitureItemWidget(furniture.item),
                        ),
                      );
                    }).toList(),
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
    return file;
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

  FurnitureItemWidget(this.item);

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
              color: Colors.black,
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
