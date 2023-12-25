import 'package:flutter/material.dart';

void main() {
  runApp(const DesignerPage());
}

class DesignerPage extends StatefulWidget{
  const DesignerPage({super.key});

  @override
  _DesignerPageState createState() => _DesignerPageState(); 
}

class _DesignerPageState extends State<DesignerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody() {
    return const SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Removed the extra period
          children: <Widget>[
            Row(
              children: <Widget>[
               Text(
                "Top Designer",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SvgPicture.asset('Assets/Images/forward_icon.svg'), // Adjusted the path to lowercase
          ],
        ),
        SizedBox(height: 30,),
        Row(children: <Widget> [
            Column(
              children: <Widget> [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: 
                      AssetImage('Assets/Images/erik.avif'),
                   ),
                 ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SvgPicture {
  const SvgPicture();
  
  static asset(String s) {}
}

