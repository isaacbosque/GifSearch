import 'package:flutter/material.dart';
import 'package:gif_search/UI/gif_page.dart';
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
  final _searchControl = TextEditingController();

  Future<Map> _getGif() async {
    http.Response response;
    if (_search == null)
      response = await http.get(
          "https://api.giphy.com/v1/gifs/trending?api_key=U4NRiGTO74MYyOiV753ZUg1kCt1MV1rp&limit=20&rating=G");
    else
      response = await http.get(
          "https://api.giphy.com/v1/gifs/search?api_key=U4NRiGTO74MYyOiV753ZUg1kCt1MV1rp&q=$_search&limit=19&offset=$_offset&rating=G&lang=en");
    return jsonDecode(response.body);
  }

  void _searchGif(text) {
    setState(() {
      if (text != "") {
        _search = text;
        _offset = 0;
      } else {
        _search = null;
        _offset = 0;
      }
    });
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
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _searchControl,
              decoration: InputDecoration(
                labelText: "Pesquise seu GIF! <3",
                labelStyle: TextStyle(
                    fontSize: 30, fontFamily: "Consolas", color: Colors.white),
                border: OutlineInputBorder(),
              ),
              onChanged: _searchGif,
            ),
          ),
          Expanded(
            child: FutureBuilder(
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
                  default:
                    if (snapshot.hasError)
                      return Container();
                    else
                      return _createTableGif(context, snapshot);
                }
              },
            ),
          )
        ],
      ),
    );
  }

  int _getCount(List data) {
    if (_search == null)
      return data.length;
    else {
      return data.length + 1;
    }
  }

  Widget _createTableGif(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
        padding: EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10.0, mainAxisSpacing: 10.0),
        itemCount: _getCount(snapshot.data["data"]),
        itemBuilder: (context, index) {
          if (_search == null || index < snapshot.data["data"].length) {
            return GestureDetector(
              child: Image.network(
                snapshot.data["data"][index]["images"]["fixed_height"]["url"],
                height: 20,
                fit: BoxFit.cover,
              ),
              onTap: () {
                return Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            gif_page(snapshot.data["data"][index])));
              },
            );
          } else {
            return Container(
              child: GestureDetector(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.add, color: Colors.white, size: 70.0),
                    Text(
                      "Carregar mais icones",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
                onTap: () {
                  setState(() {
                    _offset += 19;
                  });
                },
              ),
            );
          }
        });
  }
}
