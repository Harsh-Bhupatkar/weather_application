//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/main_screen.dart';

void main(){
  runApp(const weather_app());
}
class weather_app extends StatelessWidget {
  const weather_app({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: "Weather",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: const main_screen(),
    );
  }
}
