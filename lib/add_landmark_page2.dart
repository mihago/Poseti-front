import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:poseti/determine_position.dart';
import 'package:poseti/landmark_bottom_card.dart';
import 'package:poseti/landmark_suggestions.dart';
import 'package:poseti/landmark_with_distance.dart';
import 'package:poseti/map_page.dart';
import 'package:poseti/my_app_bar.dart';
import 'package:poseti/positive_button.dart';
import 'package:poseti/profile_data.dart';
import 'package:poseti/profile_page.dart';
import 'package:poseti/theme/custom_theme.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'bottom_card.dart';
import 'bottom_navigation_item.dart';
import 'landmark_request.dart';
import 'landmark_tile.dart';

//Страница с картой
class AddLandmarkPage2 extends StatefulWidget {
  final String name;
  final String definition;
  final ProfileData profileData;
  const AddLandmarkPage2(
      {super.key, required this.name, required this.definition, required this.profileData});

  @override
  State<AddLandmarkPage2> createState() => _AddLandmarkPage2State();
}

class _AddLandmarkPage2State extends State<AddLandmarkPage2> {
  final adressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Completer<YandexMapController> completer = Completer();
  final List<MapObject> mapObjects = [];
  Point? landmarkLocation;
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    adressController.dispose();
    super.dispose();
  }

  String? isNotEmptyAdressValidator(String? value) {
    if ((value == null || value.isEmpty) && landmarkLocation == null) {
      return 'Укажите геолокацию любым способом';
    }
    return null;
  }

  Future<void> validateAndSubmit() async {
    if (_formKey.currentState!.validate()) {
      var adress  =adressController.text;
      String message = "${widget.definition}\n$adress\nlatitude:${landmarkLocation?.latitude}\nlongitude:${landmarkLocation?.longitude}";
      http.get(
          Uri.parse('http://90.156.228.153:8000/dispatcher/landmarks/suggest_landmark/?name=${widget.name}&login=${widget.profileData.email}&password=${widget.profileData.password}&message=$message')).then((response){
        for(var i in response.headers.keys){
          print("debugging${i} ${response.headers[i]}");
        }
showDialog(context: context, builder: (context)=>Text("ggg"));
      });
      Navigator.of(context).pop();
      /* Navigator.of(context).pushReplacement( PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => Container(),
        transitionDuration: Duration(seconds: 0),
      ));*/
    }
  }

  Future<void> createPoint(Point point) async {
    final mapObject = PlacemarkMapObject(
        mapId: MapObjectId("newLandmarkLocation"),
        point: point,
        icon: PlacemarkIcon.single(PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage('assets/place.png'),
            rotationType: RotationType.rotate)));
    setState(() {
      mapObjects.add(mapObject);
    });
    YandexMapController controller = await completer.future;
    controller.moveCamera(
        CameraUpdate.newCameraPosition(CameraPosition(target: point)),
        animation: MapAnimation(type: MapAnimationType.linear, duration: 1.0));
  }

  Future<void> setLocation(Point point) async {
    landmarkLocation = point;
    createPoint(point);
  }

  void _onMapCreated(YandexMapController controller) {
    completer.complete(controller);
  }

  Widget build(BuildContext context) {
    //return
    return MaterialApp(
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: const PreferredSize(
              preferredSize: Size.fromHeight(56), //height of appbar
              child: MyAppBar(),
            ),
            body: Container(
                padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                child: Form(
                    key: _formKey,
                    child: Column(children: [
                      SizedBox(
                        height: 24,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          child: Stack(
                            children: [
                              GestureDetector(
                                child: YandexMap(
                                  mapObjects: mapObjects,
                                  onMapCreated: _onMapCreated,
                                  onMapTap: setLocation,
                                ),
                              ),
                              Positioned(
                                height: 56,
                                width: 56,
                                bottom: 14,
                                right: 14,
                                child: FloatingActionButton(
                                  child: Icon(Icons.my_location_outlined),
                                  onPressed: () async {
                                    Position position =
                                        await determinePosition();
                                    createPoint(Point(
                                        latitude: position.latitude,
                                        longitude: position.longitude));
                                  },
                                ),
                              )
                            ],
                          )),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Введите адрес, нажмите на нужное место на карте или нажмите на синюю кнопку для определения местоположения устройства:",
                        style: TextStyle(fontFamily:'Roboto',fontSize: 14),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      const Text("ИЛИ",
                          style: TextStyle(fontFamily:'Roboto',fontWeight: FontWeight.w600)),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        validator: isNotEmptyAdressValidator,
                        controller: adressController,
                        minLines: 1,
                        maxLines: 1,
                        style: TextStyle(fontFamily:'Roboto',fontSize: 16),
                        decoration: InputDecoration(
                            hintText: "Адрес",
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF20ADEA), width: 2)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2))),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                      PositiveButton(
                        text: "Далее",
                        padding: 0,
                        borderRadius: 8,
                        onPressed: validateAndSubmit, //TODO:Здесь тоже
                      ),
                      SizedBox(
                        height: 32,
                      )
                    ])))));
  }
}
