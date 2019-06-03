import 'package:flutter/material.dart';
import 'package:jeparapedia/home/carousel.dart';
import 'package:jeparapedia/home/grid.dart';
import 'package:jeparapedia/home/list_vertical.dart';

class Home extends StatelessWidget {
  
  final _appBar = AppBar(
    title: Text('JeparaPedia', style: TextStyle(
      fontWeight: FontWeight.bold,
      fontFamily: 'Paul',
      fontSize: 25.0,
    ),),
    centerTitle: true,
    leading: IconButton(
        icon: Icon(Icons.search, color: Colors.black),
        onPressed: () {},
    ),
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.person_outline, color: Colors.black),
        onPressed: () {},
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: ListView(
        children: <Widget>[
          Carousel(),
          Grid(),
          ListVertical(),
        ],
      ),
    );
  }
}