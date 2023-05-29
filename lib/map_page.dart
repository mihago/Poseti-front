import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:poseti/landmark_bottom_card.dart';
import 'package:poseti/landmark_suggestions.dart';
import 'package:poseti/landmark_with_distance.dart';
import 'package:poseti/my_app_bar.dart';
import 'package:poseti/profile_data.dart';
import 'package:poseti/profile_page.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'bottom_card.dart';
import 'bottom_navigation_item.dart';
import 'landmark_request.dart';


//Страница с картой
class MapPage extends StatefulWidget {
  const MapPage({required this.beginListenPosition, required this.landmarks, super.key, required this.completer});
  final List<LandmarkRequest> landmarks;
  final VoidCallback beginListenPosition;
  final Completer<YandexMapController> completer;

  @override
  State<MapPage> createState() => _MapPageState();
}
class _MapPageState extends State<MapPage> with AutomaticKeepAliveClientMixin  {
  GlobalKey mapKey = GlobalKey();
  var date2;
  bool isOpened = false;
  //Создаём объект для управления картой
  final List<MapObject> mapObjects = [];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        YandexMap(
                mapObjects: mapObjects,
                key: mapKey,
                onMapCreated: _onMapCreated,
              ),
        Positioned(
          bottom: 24,
          right: 24,
          child:
        FloatingActionButton(
        child: Icon(Icons.my_location_outlined),
    onPressed: () async {
    final meObject = PlacemarkMapObject(
    mapId: MapObjectId("mehikkj"),
    point: const Point(
    latitude: 37,
    longitude: 58,
    ),
    icon: PlacemarkIcon.single(PlacemarkIconStyle(
    image: BitmapDescriptor.fromAssetImage(
    'assets/route_end.png'),
    rotationType: RotationType.rotate)));
    setState(() {
    mapObjects.add(meObject);
    });
    YandexMapController controller = await widget.completer.future;
    final mediaQuery = MediaQuery.of(context);
    final height = mapKey.currentContext!.size!.height * mediaQuery.devicePixelRatio;
    final width = mapKey.currentContext!.size!.width * mediaQuery.devicePixelRatio;
    controller.toggleUserLayer(
    visible: true,
    autoZoomEnabled: true,
    anchor: UserLocationAnchor(
    course: Offset(0.5 * width, 0.5 * height),
    normal: Offset(0.5 * width, 0.5 * height)
    )
    );
    },
    ),)
      ],
    );
  }

  void _onMapCreated(YandexMapController controller) {
    widget.beginListenPosition();//TODO: Подумать, а может по нажатию на кнопку только всё считать?
    controller.moveCamera(CameraUpdate.newCameraPosition(const CameraPosition(target: Point(latitude: 55.750511, longitude:37.631229))));
    controller.moveCamera(CameraUpdate.zoomTo(15));
    widget.completer.complete(controller);
    for (int i = 0; i < widget.landmarks.length; i++) {
      final mapObject = PlacemarkMapObject(
          mapId: MapObjectId("placemark$i"),
          onTap: (object, point) {
            if (!isOpened) {
              isOpened = true;
              showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20))),
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (BuildContext context) {
                    return makeDismissible(DraggableScrollableSheet(
                      initialChildSize: 0.3,
                      minChildSize: 0.3,
                      maxChildSize: 1,
                      builder: (BuildContext context,
                          ScrollController scrollController) {
                        return LandmarkBottomCard(
                            changeIsOpened: () {
                              isOpened = false;
                              if (kDebugMode) {
                                print(isOpened);
                              }
                            },
                            controller: scrollController,
                            header: widget.landmarks[i].name,
                            definition: widget.landmarks[i].description,
                            image: widget.landmarks[i].image);
                      },
                    ));
                  });
            }
          },
          point: Point(
              latitude: widget.landmarks[i].latitude,
              longitude: widget.landmarks[i].longitude),
          icon: PlacemarkIcon.single(PlacemarkIconStyle(
              image: BitmapDescriptor.fromAssetImage('assets/place.png'),
              rotationType: RotationType.rotate)));

      setState(() {
        mapObjects.add(mapObject);
      });
    }
  }
  Widget makeDismissible(Widget child) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => {isOpened = false, Navigator.of(context).pop()},
        child: GestureDetector(onTap: () {}, child: child));
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

