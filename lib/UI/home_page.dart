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

  Future<Map> _getGif() async {
    http.Response response;
    if (_search == null)
      response = await http.get(
          "https://api.giphy.com/v1/gifs/trending?api_key=U4NRiGTO74MYyOiV753ZUg1kCt1MV1rp&limit=20&rating=G");
    else
      response = await http.get(
          "https://api.giphy.com/v1/gifs/search?api_key=U4NRiGTO74MYyOiV753ZUg1kCt1MV1rp&q=$_search&limit=20&offset=$_offset&rating=G&lang=en");
    return jsonDecode(response.body);
  }

  Widget UI() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: TextField(
            decoration: InputDecoration(
              labelText: "Pesquise seu GIF! <3",
              labelStyle: TextStyle(
                  fontSize: 30, fontFamily: "Consolas", color: Colors.white),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        FutureBuilder(
          future: _getGif(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Container(
                  width: 200,
                  height: 200,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    strokeWidth: 5.0,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                );
              case ConnectionState.done:
              default:
                return Container();
            }
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Image(image: AssetImage("Assets/logo.png")),
        centerTitle: true,
      ),
      backgroundColor: Color.fromARGB(255, 69, 26, 188),
      body: UI(),
    );
  }
}
