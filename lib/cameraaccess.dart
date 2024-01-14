import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(Camera());
}

class Camera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}


class HomeScreen extends StatefulWidget{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}
class HomeScreenState extends State<HomeScreen>{
  String selectedImagePath = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade800,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            selectedImagePath == ''
                ? Image.asset('Assets/Images/image_placeholder.png',height: 200, width: 200, fit: BoxFit.fill)
                : Image.file(File(selectedImagePath),height: 200, width: 200,fit: BoxFit.fill, ),
            Text(
              'Select Image',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.pink),
                padding:
                  MaterialStateProperty.all(const EdgeInsets.all(20)),
                textStyle: MaterialStateProperty.all(
                  const TextStyle(fontSize: 14, color: Colors.grey))),
              onPressed: () async {
                selectImage();
                setState(() {});
              },
              child: const Text('Select'),

            ),
            const SizedBox(height: 10,),
          ],
        ),

      ),
    );
  }

  Future selectImage() {
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              height: 200,
              child: Column(
                children: [
                  Text(
                    'select Image from',
                    style: TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold),

                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          selectedImagePath = await selectImageFromGallery();
                          print('Image_Path:-');
                          print(selectedImagePath);
                          if(selectedImagePath != '') {
                            Navigator.pop(context);
                            setState(() {});
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('No image selected'),
                            ));
                          }
          },
          child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.asset(
              'Assets/Images/gallery.png',
              height: 60,
              width: 60,
              ),
            Text('Gallery'),
          ],
          ),
          ),
          ),
                      ),
          GestureDetector(
            onTap: () async {
              selectedImagePath = await selectImageFromCamera();
              print('Image Path:-');
              print(selectedImagePath);

              if(selectedImagePath != ''){
                Navigator.pop(context);
                setState(() {});
              }else{
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('No image captured'),
                ));
                   
              }
            },
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/camera.png',
                      height: 60,
                      width: 60,
                  ),
                  Text('Camera'),
          ],
          ),
          ),
          ),

          )



                    ],
                  )

                ],
              ),
            ),
          );
        });
}

selectImageFromGallery() async {
  XFile? file = await ImagePicker()
      .pickImage(source: ImageSource.gallery, imageQuality: 10);
  if (file != null) {
    return file.path;
  } else {
    return '';
  }
}
selectImageFromCamera() async {
  XFile? file = await ImagePicker()
      .pickImage(source: ImageSource.camera,imageQuality: 10);
  if(file != null){
    return file.path;
  }else{
    return '';
  }
}
}
