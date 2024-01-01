import 'package:flutter/material.dart';
import 'package:flutter_application_1/readymade/detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }
  Widget getBody(){
    return SafeArea(child: SingleChildScrollView(child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 30),
      child: Column(
        
        children: <Widget>[
          const SizedBox(height: 40,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
            const Text("Top Designer",style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold
            ),),
            // SvgPicture.asset("assets/images/forward_icon.svg")
          ],),
          const SizedBox(height: 30,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
                      child: Row(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: NetworkImage("https://images.unsplash.com/photo-1525879000488-bff3b1c387cf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60"),fit: BoxFit.cover)
                      ),
                    ),
                    const SizedBox(height: 15,),
                    const Text("Jean-Luis")
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: NetworkImage("https://images.unsplash.com/photo-1517070208541-6ddc4d3efbcb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60"),fit: BoxFit.cover)
                      ),
                    ),
                    const SizedBox(height: 15,),
                    const Text("Phillinpe")
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: NetworkImage("https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60"),fit: BoxFit.cover)
                      ),
                    ),
                    const SizedBox(height: 15,),
                    const Text("Michael")
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: NetworkImage("https://images.unsplash.com/photo-1521572267360-ee0c2909d518?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60"),fit: BoxFit.cover)
                      ),
                    ),
                    const SizedBox(height: 15,),
                    const Text("Lesly Juarez")
                  ],
                ),
              )
            ],),
            
          ),
          const SizedBox(height: 40,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
            const Text("Popular Design",style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold
            ),),
            // SvgPicture.asset("assets/images/forward_icon.svg")
          ],),
          const SizedBox(height: 30,),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_) => const DetailPage()));
            },
                      child: Container(
              width: double.infinity,
              height: 150,
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/image_1.png"))
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                  width: (MediaQuery.of(context).size.width - 80) / 2,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(image: AssetImage("assets/images/image_2.png"),fit: BoxFit.cover)
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  width: (MediaQuery.of(context).size.width - 80) / 2,
                  height: 230,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(image: AssetImage("assets/images/image_3.png"),fit: BoxFit.cover)
                  ),
                ),
                ],
              ),
              const SizedBox(width: 20,),
              Column(
                children: <Widget>[
                  Container(
                  width: (MediaQuery.of(context).size.width - 80) / 2,
                  height: 230,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(image: AssetImage("assets/images/image_4.png"),fit: BoxFit.cover)
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  width: (MediaQuery.of(context).size.width - 80) / 2,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(image: AssetImage("assets/images/image_5.png"),fit: BoxFit.cover)
                  ),
                ),
                ],
              )
            ],
          )
        ],
      ),
    ),));
  }
}