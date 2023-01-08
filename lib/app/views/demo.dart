import 'package:flutter/material.dart';

class Screen extends StatefulWidget {
  const Screen({Key? key}) : super(key: key);

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 200.0,
      child: ListView.builder(
      itemCount: 10,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
      return Container(
      width: MediaQuery.of(context).size.width - 140,
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
      image: const DecorationImage(
      image: NetworkImage(
      "https://i.ibb.co/S32HNjD/no-image.jpg",
      ),
      fit: BoxFit.cover,
      ),
     
    
      ),
      );
      },
      ));
    
  }
}
