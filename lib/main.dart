import 'package:dionys/home/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.purple,
    ),
    title: "Login App",
    home: const Home(),
  ));
}
