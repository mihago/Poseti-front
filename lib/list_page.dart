import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:poseti/landmark_bottom_card.dart';
import 'package:poseti/landmark_suggestions.dart';
import 'package:poseti/landmark_with_distance.dart';
import 'package:poseti/map_page.dart';
import 'package:poseti/my_app_bar.dart';
import 'package:poseti/profile_data.dart';
import 'package:poseti/profile_page.dart';
import 'package:poseti/theme/custom_theme.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'bottom_card.dart';
import 'bottom_navigation_item.dart';
import 'landmark_request.dart';
import 'landmark_tile.dart';

//Страница с картой
class ListPage extends StatelessWidget {
  const ListPage({required this.title, required this.landmarks, super.key});
  final String title;
  final List<LandmarkWithDistance> landmarks;

Widget build(BuildContext context){
  if(landmarks.length==0){
    return Text("Что-то пошло не так - пожалуйста перезайдите",style: TextStyle(fontFamily:'Roboto',color: Color(0xFFF06B20),fontWeight: FontWeight.w700, fontSize: 20));
  }
  else{
    return
      ListView.builder(

        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.all(8),
        itemCount: landmarks.length,
        itemBuilder: (BuildContext context, int index) {
          return LandmarkTile(landmark: landmarks[index]);
        },

      );
  }

}

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
