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
            SvgPicture.asset("Assets/Images/forward_icon.svg"), // Adjusted the path to lowercase
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
                      NetworkImage('https://images.unsplash.com/photo-1521572267360-ee0c2909d518?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mjd8fHByb2ZpbGV8ZW58MHx8MHx8fDA%3D'),
                      fit: BoxFit.cover
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

