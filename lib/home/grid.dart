import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../dummydata.dart';

final data = DummyData();

class Grid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('kategori').snapshots(),
      builder: (context, snapshot) {

        if (snapshot.hasError || !snapshot.hasData) {
          return Text('');
        } else if (snapshot.connectionState == ConnectionState.none) {
          return Text('');
        } else {

          final data = snapshot.data.documents;

          return GridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 4,
            children: List.generate(data.length, (i) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/placeholder-image.png',
                      image: data[i]['icon'],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 8,),
                  Text(data[i]['nama'], style: TextStyle(fontSize: 12),)
                ],
              );
            }),
          ); 
        }
      }
    );
  }
}