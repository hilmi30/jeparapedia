import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:great_circle_distance/great_circle_distance.dart';
import 'package:jeparapedia/model/newdata.dart';

final lat = -6.590642; 
final lng = 110.667343;

List<NewData> newData = List();

class ListVertical extends StatelessWidget {
  const ListVertical({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 1, color: Colors.black12, margin: EdgeInsets.all(8),),
        Container(
          margin: const EdgeInsets.all(8),
          child: Text('Lokasi Terdekat', style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        Container(
          // height of list
          height: 250.0,
          margin: EdgeInsets.symmetric(horizontal: 4),
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('data').where("kategori", isEqualTo: "9Yv22V1aiOPQFP4r1C39")
            .limit(10).snapshots(),
            builder: (context, snapshot) {

              if (snapshot.hasError || !snapshot.hasData) {
                return Text('');
              } else if (snapshot.connectionState == ConnectionState.none) {
                return Text('');
              } else {
                newData.clear();
                final data = snapshot.data.documents;
                for (var i = 0; i < data.length; i++) {
                  final gdc = GreatCircleDistance.fromDegrees(
                    latitude1: lat, longitude1: lng,
                    latitude2: double.parse(data[i]['latitude']), longitude2: double.parse(data[i]['longitude'])
                  );

                  newData.add(NewData(
                    kategori: data[i]['kategori'],
                    latitude: data[i]['latitude'],
                    longitude: data[i]['longitude'],
                    nama: data[i]['nama'],
                    src: data[i]['src'],
                    distance: gdc.haversineDistance().toStringAsFixed(0)
                  ));
                }

                // sort data berdasarkan jarak terdekat
                newData.sort((a, b) => b.distance.compareTo(a.distance));

                return ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: List.generate(data.length, (i) {

                    var dist;
                    final dataDist = int.parse(newData[i].distance);

                    if (dataDist < 1000) {
                      dist = '$dataDist m';
                    } else {
                      final km = dataDist / 1000;
                      dist = '${km.toStringAsFixed(1)} Km';
                    }

                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: FadeInImage.assetNetwork(
                                  image: newData[i].src,
                                  placeholder: 'assets/images/placeholder-image.png',
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 8,
                                child: Chip(
                                  backgroundColor: Colors.blue,
                                  label: Text(dist, style: TextStyle(fontSize: 12, color: Colors.white),),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(newData[i].nama, style: TextStyle(fontSize: 12),),
                          )
                        ],
                      ),
                    );
                  })
                );
              }
            }
          ),
        ),
      ],
    );
  }
}