import 'package:flutter/material.dart';

class gif_page extends StatelessWidget {

  final Map _data;

  gif_page(this._data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(_data["title"]),
      ),
      body: Center(
        child:Image.network(_data["images"]["fixed_height"]["url"]),
      ),
      backgroundColor: Colors.deepPurple,
    );
  }
}
