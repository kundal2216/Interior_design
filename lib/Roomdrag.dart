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
      Furniture('', 'Assets/Images/sofa.jpg'),
      Furniture('', 'Assets/Images/sofa2.jpg'),
    ],
    'vase': [
      Furniture('vase 1', 'Assets/Images/vase.jpg'),
      Furniture('vase 2', 'Assets/Images/Vase2.png'),
    ],
    'Tv': [
      Furniture('Tv 1', 'Assets/Images/tv.jpg'),
      Furniture('TV 2', 'Assets/Images/tv2.jpg'),
    ],
    'bed': [
      Furniture('bed 1', 'Assets/Images/bed1.jpg'),
      Furniture('bed 2', 'Assets/Images/bed2.jpg'),
    ],
    // Add room furniture images and categories as needed
  };

  List<PlacedFurniture> placedFurniture = [];

  XFile? backgroundImage;
  bool isDragging = false;

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
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Select Background Image Button
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
                                  feedback: FurnitureItemWidget(furniture.item,
                                      isDragging: true),
                                  childWhenDragging: Container(),
                                  // onDraggableCanceled: (velocity, offset) {
                                  //    print(
                                  //       'Dragging cancel at ${velocity} $offset');
                                  //       if (offset.dx.abs() > 150 || offset.dy.abs() > 150) {
                                  //       setState(() {
                                  //         placedFurniture.removeLast();
                                  //         isDragging = false;
                                  //       });
                                  //     }
                                  // },
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

                                      // Remove the previous image if it was just dragged to a new position
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
                                  // onDraggableCanceled: (velocity, offset) {
                                  //   print('Draggable canceled with velocity $velocity, offset $offset');
                                  // },
                                  // onDragEnd: (details) {
                                  //   print(
                                  //       'Drag ended with primaryDelta: ${details.offset}');
                                  //   setState(() {
                                  //     // Update furniture position on drag end.
                                  //     placedFurniture.last.x +=
                                  //         details.offset!.dx;
                                  //     placedFurniture.last.y +=
                                  //         details.offset!.dy;
                                  //   });
                                  // },

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
