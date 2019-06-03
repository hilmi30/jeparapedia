import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventDetail extends StatelessWidget {

  final DocumentSnapshot doc;
  EventDetail(this.doc);

  @override
  Widget build(BuildContext context) {

    final _appBar = AppBar(
      title: Text('Event'),
      centerTitle: true,
    );

    final _imageEvent = Container(
      margin: EdgeInsets.all(8.0),
      height: 200.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/images/placeholder-image.png',
          image: doc['src'],
          fit: BoxFit.cover,
        ),
      ),
    );

    final _titleEvent = Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        doc['title'], style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0
        ),
      ),
    );

    final _descEvent = Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        doc['desc'], textAlign: TextAlign.justify,
      ),
    );

    return Scaffold(
      appBar: _appBar,
      body: ListView(
        children: <Widget>[
          _imageEvent,
          _titleEvent,
          _descEvent,
        ],
      ),
    );
  }
}