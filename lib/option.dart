import 'package:flutter/material.dart';
import 'package:flutter_application_1/HallDrag.dart';
import 'package:flutter_application_1/Roomdrag.dart';
import 'package:flutter_application_1/Kitchendrag.dart';

void main() {
  runApp(Option());
}

class Option extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImageButtonsPage(),
    );
  }
}

class ImageButtonsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select room to Design'),
      ),
      backgroundColor: Color.fromARGB(255, 0, 17, 26), // Set your desired background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildShapedImageButton(
              context,
              'Assets/Images/Roominteriordesign.jpg',
              'Bed Room',
              Roomdrag(),
              CircleClipper(),
              Colors.orange, // Set your desired button color
            ),
            SizedBox(height: 20),
            buildShapedImageButton(
              context,
              'Assets/Images/HallInteriordesign.jpg',
              'Hall',
              HallDrag(),
              CircleClipper(),
              Colors.green, // Set your desired button color
            ),
            SizedBox(height: 20),
            buildShapedImageButton(
              context,
              'Assets/Images/Kitcheninteriordesign.jpg',
              'Kitchen',
              KitchenDrag(),
              CircleClipper(),
              Colors.pink, // Set your desired button color
            ),
          ],
        ),
      ),
    );
  }

  Widget buildShapedImageButton(
    BuildContext context,
    String imagePath,
    String buttonText,
    Widget pageToNavigate,
    CustomClipper<Path> clipper,
    Color buttonColor,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => pageToNavigate,
          ),
        );
      },
      child: ClipPath(
        clipper: clipper,
        child: Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
            color: buttonColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(
                fontSize: 16,
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

class CircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.addOval(Rect.fromCircle(center: size.center(Offset.zero), radius: size.width / 2));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
