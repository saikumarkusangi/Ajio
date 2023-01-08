import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_tutorials/app/views/demo.dart';
import 'package:provider_tutorials/providers/cart_provider.dart';
import 'app/views/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>CartProvider(),
      child: Builder(
        builder: (BuildContext context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Ajio',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home:  Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Screen(),
                 Screen(),
              ],
            ),
          );
        }
      ),
    );
  }
}
