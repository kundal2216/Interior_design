import 'package:flutter_application_1/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/flutter_3d_obj.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth Screen 1',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: kPrimryColor,
        scaffoldBackgroundColor: kBackgroudColor,
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(color:kPrimryColor),
              headlineLarge:
              TextStyle(color: Colors.white,fontWeight: FontWeight.normal),
          ),
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
              decoration: const BoxDecoration(
                image:DecorationImage(
                  image: AssetImage("Assets/Images/south_delhi.jpg"),
                  fit:BoxFit.cover
                ),
              ),
            ),
          ),
         Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    children: [TextSpan(text:"Interior Designs\n",
                    style:Theme.of(context)
                    .textTheme.displayLarge,
                      ),
                      TextSpan(text:"Design the house in your way",
                      style:Theme.of(context).textTheme.headlineLarge)
                    ],
                  ),
                ),
                FittedBox(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const MyFurniture();
                      },
                      ));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 25),
                      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                      decoration: BoxDecoration(borderRadius:BorderRadius.circular(30),
                      color: kPrimryColor,
                      ),
                      child: Row(
                        children: <Widget>[Text(
                          "Design here",
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.black),
                          ),
                          const SizedBox(width: 10),
                          const Icon(
                            Icons.arrow_forward,
                            color: Colors.black,
                            )
                        ],
                      )
                    ),
                  ),
                )
              ],
            ),
          ),
       ],
      ),
    );
  }
}
