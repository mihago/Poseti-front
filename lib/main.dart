import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:poseti/add_landmark_page1.dart';
import 'package:poseti/auth_page.dart';
import 'package:poseti/landmark_request.dart';
import 'package:poseti/login_page.dart';
import 'package:poseti/profile_page.dart';
import 'package:poseti/signup_page.dart';
import 'package:yandex_mapkit/example/examples/bicycle_page.dart';
import 'package:yandex_mapkit/example/examples/circle_map_object_page.dart';
import 'package:yandex_mapkit/example/examples/clusterized_placemark_collection_page.dart';
import 'package:yandex_mapkit/example/examples/driving_page.dart';
import 'package:yandex_mapkit/example/examples/map_controls_page.dart';
import 'package:yandex_mapkit/example/examples/map_object_collection_page.dart';
import 'package:yandex_mapkit/example/examples/placemark_map_object_page.dart';
import 'package:yandex_mapkit/example/examples/polygon_map_object_page.dart';
import 'package:yandex_mapkit/example/examples/polyline_map_object_page.dart';
import 'package:yandex_mapkit/example/examples/reverse_search_page.dart';
import 'package:yandex_mapkit/example/examples/search_page.dart';
import 'package:yandex_mapkit/example/examples/suggest_page.dart';
import 'package:yandex_mapkit/example/examples/user_layer_page.dart';
import 'package:yandex_mapkit/example/examples/widgets/map_page.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

// void main() {
//   runApp(MaterialApp(home: MainPage()));
// }
//
// const List _allPages = [
//   MapControlsPage(),
//   ClusterizedPlacemarkCollectionPage(),
//   MapObjectCollectionPage(),
//   PlacemarkMapObjectPage(),
//   PolylineMapObjectPage(),
//   PolygonMapObjectPage(),
//   CircleMapObjectPage(),
//   UserLayerPage(),
//   SuggestionsPage(),
//   SearchPage(),
//   ReverseSearchPage(),
//   BicyclePage(),
//   DrivingPage(),
// ];
import 'bottom_card.dart';
import 'bottom_navigation_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState(){
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFF06B20)),
      ),
      home: const AuthPage(),
    );
  }
}


