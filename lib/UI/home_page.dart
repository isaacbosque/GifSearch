import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _search;
  int _offset = 0;

  Future<Map> getGif() async {
    http.Response response;
    if (_search == null)
      response = await http.get(
          "https://api.giphy.com/v1/gifs/trending?api_key=U4NRiGTO74MYyOiV753ZUg1kCt1MV1rp&limit=20&rating=G");
    else
      response = await http.get(
          "https://api.giphy.com/v1/gifs/search?api_key=U4NRiGTO74MYyOiV753ZUg1kCt1MV1rp&q=$_search&limit=20&offset=$_offset&rating=G&lang=en");
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Image(
          image: AssetImage("Assets/logo.png")
        ),
        centerTitle: true,
      ),
    );
  }
}
