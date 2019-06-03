import 'package:flutter/material.dart';

import 'carousel.dart';
import 'grid.dart';
import 'list_vertical.dart';

class Body extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Carousel(),
        Grid(),
        ListVertical(),
      ],
    );
  }
}