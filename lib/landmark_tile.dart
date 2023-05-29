import 'package:flutter/material.dart';
import 'package:poseti/landmark_with_distance.dart';

class LandmarkTile extends StatelessWidget {
  final LandmarkWithDistance landmark;
  const LandmarkTile({required this.landmark, super.key});
  //TODO:Подумать насчёт того, что, если нажатие идёт из списка, надо сначала на карту пробросить

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 12, 10),
      height: 72,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border.all()),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              image: DecorationImage(
                  image: Image.network(landmark.landmarkInfo.image).image,
                  fit: BoxFit.cover),
            ),
          ),
          SizedBox(width: 20),
          Flexible(

                      child: Text(
            landmark.landmarkInfo.name,
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily:'Roboto',fontSize: 20, fontWeight: FontWeight.w600),
          )),
          SizedBox(width: 20),
          Text('${landmark.distance.floor()} m',style: const TextStyle(fontFamily:'Roboto',color: Color(0x4d000000), fontWeight: FontWeight.w500),),
        ],
      ),
    );
  }
}
