import 'package:flutter/material.dart';
import 'package:gif_search/UI/home_page.dart';

void main() {
  runApp(MaterialApp(
    title: "gif search",
    home: HomePage(),
    theme: ThemeData(
      hintColor: Colors.white,
      primaryColor: Colors.white
    ),
  ));
}
