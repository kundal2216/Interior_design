//import 'package:flutter_application_1/data/data.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/utils.dart';
import 'package:flutter_application_1/Widget/draggable_widget.dart';
import 'package:flutter/material.dart';
import '../Data/Data.dart';

void main() {
  runApp(DragImage());
}


class DragImage extends StatefulWidget {
  @override
  _DraggableAdvancedPageState createState() => _DraggableAdvancedPageState();
}

class _DraggableAdvancedPageState extends State<DragImage> {
  final List<Furniture> all = AllFurniture;
  final List<Furniture> land = [];
  final List<Furniture> air = [];
  final List<Furniture> hall = [];


  final double size = 150;

  void removeAll(Furniture toRemove) {
    all.removeWhere((furniture) => furniture.imageUrl == toRemove.imageUrl);
    land.removeWhere((furniture) => furniture.imageUrl == toRemove.imageUrl);
    air.removeWhere((furniture) => furniture.imageUrl == toRemove.imageUrl);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Dragg'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            buildTarget(
              context,
              text: 'All',
              furnitures: all,
              acceptTypes: FurnitureType.values,
              onAccept: (data) => setState(() {
                removeAll(data);
                all.add(data);
              }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buildTarget(
                  context,
                  text: 'Animals',
                  furnitures: land,
                  acceptTypes: [FurnitureType.land],
                  onAccept: (data) => setState(() {
                    removeAll(data);
                    land.add(data);
                  }),
                ),
                buildTarget(
                  context,
                  text: 'Birds',
                  furnitures: air,
                  acceptTypes: [FurnitureType.air],
                  onAccept: (data) => setState(() {
                    removeAll(data);
                    air.add(data);
                  }),
                ),
              ],
            ),
          ],
        ),
      );

  Widget buildTarget(
    BuildContext context, {
    required String text,
    required List<Furniture> furnitures,
    required List<FurnitureType> acceptTypes,
    required DragTargetAccept<Furniture> onAccept,
  }) =>
      CircleAvatar(
        radius: size / 2,
        child: DragTarget<Furniture>(
          builder: (context, candidateData, rejectedData) => Stack(
            children: [
              ...furnitures
                  .map((furniture) => DraggableWidget(furniture: furniture))
                  .toList(),
              IgnorePointer(child: Center(child: buildText(text))),
            ],
          ),
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
      );

  Widget buildText(String text) => Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.8),
            blurRadius: 12,
          )
        ]),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}
