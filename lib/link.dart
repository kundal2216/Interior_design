import "package:flutter/material.dart";

void main() {
  runApp(
    const MaterialApp(
      title: "Navigation Test",
      home: MyNavigation(),
    )
  );
}

class MyNavigation extends StatefulWidget {
  const MyNavigation({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyNavigation();
  }
}

class _MyNavigation extends State<MyNavigation>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Navigation Tutorial"),
      ),
      body: const Center(),
 //       child: RaisedButton(
 //         child: Text("Design here"),
   //       onPressed: null
        );
 //   );
  }
}

RaisedButton({required Text child, required onPressed}) {
}


