import 'package:flutter/material.dart';

class Home extends StatefulWidget {
 // const Home({super.key, Super,key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build ( BuildContext context) {
     return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Container(
          child: const Row(
            children: [
              
            ],
          ),
        ),
      ),

     );
  }

}