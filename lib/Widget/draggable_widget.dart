import 'package:flutter/material.dart';
import '../Data/Data.dart';


class DraggableWidget extends StatelessWidget {
  final Furniture furniture;

  const DraggableWidget({
   //Key key,
    required this.furniture,
  }); 
  //: super (key:key);

  //static double size = 150;

  @override
  Widget build(BuildContext context) => Draggable<Furniture>(
    data: furniture,
    feedback: buildroom(),
    child: buildroom(),
    childWhenDragging: Container(height: 500, width: 1000),
  );

  Widget buildroom() => Container(
    height: 500,
    width: 1000,
    decoration: BoxDecoration(
    border: Border.all(
      color: Colors.white,
    ),
    ),
    child: Image.asset(furniture.imageUrl),
  );

}
