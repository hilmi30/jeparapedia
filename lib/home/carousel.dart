import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

int _current = 0;

class Carousel extends StatefulWidget {
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('event-slider').snapshots(),
      builder: (context, snapshot) {

        if (snapshot.hasError || !snapshot.hasData) {
          return Text('');
        } else if (snapshot.connectionState == ConnectionState.none) {
          return Text('');
        } else {
          return Stack(
            children: [
              Container(
                margin: EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CarouselSlider(
                    height: 200.0,
                    enableInfiniteScroll: true,
                    viewportFraction: 1.0,
                    items: snapshot.data.documents.map((doc) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/images/placeholder-image.png',
                            image: doc['src'],
                            fit: BoxFit.cover,
                          ),
                      );
                    }).toList(),
                    autoPlay: true,
                    aspectRatio: 2.0,
                    onPageChanged: (index) {
                      setState(() {
                        _current = index;
                      });
                    },
                  ),
                ),
              ),
              Positioned(
                bottom: 8.0,
                left: 0.0,
                right: 0.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(snapshot.data.documents.length, (i) {
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == i ? Colors.white : Color.fromRGBO(0, 0, 0, 0.4)
                      ),
                    );
                  })
                )
              )
            ]
          );
        }
      }
    );
  }
}