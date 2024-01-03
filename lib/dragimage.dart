import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(OverlapFix());
}

class OverlapFix extends StatelessWidget {
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
      Furniture('Sofa 1', 'Assets/Images/sofa.jpg'),
      Furniture('Sofa 2', 'Assets/Images/sofa2.jpg'),
    ],
    'vase': [
      Furniture('vase 1', 'Assets/Images/vase.jpg'),
      Furniture('vase 2', 'Assets/Images/Vase2.png'),
    ],
    'Tv': [
      Furniture('Table 1', 'Assets/Images/Tv.jpg'),
      Furniture('Table 2', 'Assets/Images/Tv2.jpg'),
    ],
    'bed': [
      Furniture('bed 1', 'Assets/Images/bed1.jpg'),
      Furniture('bed 2', 'Assets/Images/bed2.jpg'),
    ],
    // Add more categories and furniture items as needed
  };

  List<PlacedFurniture> placedFurniture = [];

  String? backgroundImage;

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
                itemCount: furnitureCategories.keys.length,
                itemBuilder: (context, index) {
                  String category = furnitureCategories.keys.elementAt(index);
                  return Column(
                    children: [
                      Text(category),
                      ...furnitureCategories[category]!.map((furniture) {
                        return Draggable(
                          data: furniture,
                          child: FurnitureItemWidget(furniture),
                          feedback: FurnitureItemWidget(furniture, isDragging: true),
                          childWhenDragging: Container(),
                        );
                      }).toList(),
                    ],
                  );
                },
              ),
            ),
            // Room Canvas
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Select Background Image Button
                  ElevatedButton(
                    onPressed: () async {
                      String? selectedImage = await selectBackgroundImage();
                      if (selectedImage != null) {
                        print('Selected image path: ${selectedImage}');
                        setState(() {
                          backgroundImage = selectedImage;
                        });
                      }
                    },
                    child: Text('Select Background Image'),
                  ),
                  // Room Canvas with Background Image
                  Expanded(
                    child: DragTarget<Furniture>(
                      builder: (context, candidateData, rejectedData) {
                        return Container(
                         // color: Colors.grey[300],
                          decoration: backgroundImage != null
                              ? BoxDecoration(
                                  image: DecorationImage(
                                    image: FileImage(File(backgroundImage!)),
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
          ],
        ),
      ),
    );
  }

  Future<String?> selectBackgroundImage() async {
    final imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    return file?.path;
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
