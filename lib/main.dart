import 'package:flutter_application_1/constant.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth Scrren 1',
      theme: ThemeData(
        primaryColor: kPrimryColor,
        scaffoldBackgroundColor: kBackgroudColor,
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image:DecorationImage(
                  image: AssetImage("Assets/south_delhi.jpeg"),
                  fit:BoxFit.cover
                ),
              ),
            ),
          ),
         Expanded(
            child: Column(children: <Widget>[RichText(text: TextSpan(children: [TextSpan(text:)]),
                ),
              ],
            )
          )       
       ],
      ),
    );
  }
}
