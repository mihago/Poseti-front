import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:poseti/landmark_suggestions.dart';
import 'package:poseti/landmark_with_distance.dart';
import 'package:poseti/list_page.dart';
import 'package:poseti/map_page.dart';
import 'package:poseti/profile_data.dart';
import 'package:poseti/profile_page.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'bottom_navigation_item.dart';
import 'determine_position.dart';
import 'landmark_request.dart';

//Страница с картой
class MainPage extends StatefulWidget {
  const MainPage({required this.title, required this.profileData, super.key});
  final String title;
  final ProfileData profileData;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with AutomaticKeepAliveClientMixin {
  GlobalKey mapKey = GlobalKey();

  var date2;
  bool isOpened = false;
  //Создаём объект для управления картой
  Completer<YandexMapController> _completer = Completer();
  Position? _position;
  int _selectedIndex = 1;
  final List<MapObject> mapObjects = [];
  late Future<List<LandmarkRequest>> landmarksF;
  late List<LandmarkRequest> landmarks;
  List<LandmarkWithDistance> landmarksWithDistance= [];
  List<int> nearest= [];
  List<int> viewed = [];


  void beginListenPosition(){
    getCurrentPosition();
    setPositionListener();

  }
  void setPositionListener(){
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 1,//TODO:Поменять в продакшн
    );
    StreamSubscription<Position> positionStream =Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position? position) {
      setState(() {
        _position=position;

      });
      calculateDistances();
      checkNearestLandmarks();
    });
  }



  void getCurrentPosition () async {
    Position position =await determinePosition();
    setState(() {
      _position=position;
      if (kDebugMode) {
        print("rtdrjy678yu$_position");
      }
    });
  }



  void calculateDistances(){
    double userLatitude=_position!.latitude;
    double userLongitude=_position!.longitude;
    if(landmarksWithDistance.isEmpty){
for(int i=0;i<landmarks.length;i++){
  landmarksWithDistance.add(LandmarkWithDistance(landmarkInfo: landmarks[i], distance:0));
}
    }
    for(int i=0;i<landmarks.length;i++){
      double distance=Geolocator.distanceBetween(userLatitude, userLongitude, landmarks[i].latitude, landmarks[i].longitude);
      landmarksWithDistance[i].distance=distance;
  }



  }

  void checkNearestLandmarks() {
    var isSomethingNew=false;
    double userLatitude=_position!.latitude;
    double userLongitude=_position!.longitude;
    for(int i=0;i<landmarks.length;i++){
      double distance=Geolocator.distanceBetween(userLatitude, userLongitude, landmarks[i].latitude, landmarks[i].longitude);
      bool wasThisLandmarkNear=false;
      bool wasThisLandmarkChecked=false;
      for(int j=0;j<nearest.length;j++){
        if(nearest[j]==i){
          wasThisLandmarkNear=true;
        }
      }
      for(int j=0;j<viewed.length;j++){
        if(viewed[j]==i){
          wasThisLandmarkChecked=true;//
        }
      }
      if(distance<40000&&!wasThisLandmarkNear){
        nearest.add(i);
        isSomethingNew=true;
      }

      if(distance<100&&!wasThisLandmarkChecked){

        viewed.add(i);
        if(widget.profileData.landmarks?.first==-1){
          widget.profileData.landmarks?.clear();
        }
        widget.profileData.landmarks?.add(i);
        http.get(Uri.parse('http://90.156.228.153:8000/dispatcher/users/visit/?login=${widget.profileData.email}'
            '&password=${widget.profileData.password}'
            '&token=mgGp76209aN4AJUaGZA1ByVoLVBHcfpfJ1nF5D/a08TbcRlXOIIvmdd9Wkw!KdV?lwz5xSeEYsoPl0mkN76lmYYzdxLVQ!KqfWwX-NTGiXy00F?YXeRqGfP93dfOng9jhA=zG9nnHzQojZG!KEtxJGShgNRG2rhWLW4zBJIqngMMBEkDdpzoXZ8CnefF0!/13KrTBoff6H2xN5L9Ttt8?0nqmLdnPsZiPXrZ2T32w8t7KaEaAe72zMxvluEhT!8L&landmark=$i'))
            .then((response) {
          if(kDebugMode) print(response.headers["landmark_accept"]);
        });
        //TODO:Вот здесь пишем запрос к серваку
      }
    }
    if(nearest.length!=0&&isSomethingNew){
      //TODO:Сделать проверку, открыты ли другие карточки
      if(!isOpened){
        isOpened=true;
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
                  return LandmarkSuggestons(controller: scrollController, changeIsOpened: (){
                    isOpened=false;
                  }, landmarks: nearest.map((e) => landmarksWithDistance[e]).toList());
                },
              ));
            });
      }

    }
  }
  Future<List<LandmarkRequest>> fetchLandmarks() async {
    var time1 = DateTime.now();
    final response = await http.get(Uri.parse(
        'http://90.156.228.153:8000/dispatcher/landmarks/get_landmark/'));


    if (response.statusCode == 200) {
      date2 = DateTime.now();

      // If the server did return a 200 OK response,
      // then parse the JSON.

      var LandmarksListJson = jsonDecode(response.body)['data'] as List;
      return LandmarksListJson.map(
          (landmark) => LandmarkRequest.fromJson(landmark)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();
    landmarksF =
        fetchLandmarks();
    viewed =widget.profileData.landmarks;//TODO//Запрашиваем достопримечательности и сохраняем в переменную json
  }

  //Функция для работы нижнего меню
  void _onItemTapped(int index) {
    int oldIndex = _selectedIndex;
    if (oldIndex != index) {
      if (index == 0) {

        Navigator.of(context).push(
         PageTransition(type: PageTransitionType.fade, child: ProfilePage(profileData: widget.profileData)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
            //wrap with PreferredSize
            preferredSize: Size.fromHeight(56), //height of appbar
            child: AppBar(
              automaticallyImplyLeading: false,
              bottom: const TabBar(
                tabs: [
                  Tab(text: "Карта"),
                  Tab(text: "Список"),
                ],
              ),
              title: Text(""),
              backgroundColor: Color(0xFFF06B20),
            ),
          ),

          bottomNavigationBar: SizedBox(
            height: 56,
            child: Row(
              children: [
                BotNavItem(
                    title: "Профиль",
                    icondata: Icons.account_circle_sharp,
                    isSelected: (0 == _selectedIndex) ? true : false,
                    onChanged: _onItemTapped,
                    index: 0),
                BotNavItem(
                  title: "Достопримечательности",
                  icondata: Icons.place_outlined,
                  isSelected: (1 == _selectedIndex) ? true : false,
                  onChanged: _onItemTapped,
                  index: 1,
                )
              ],
            ),
          ),
          body: FutureBuilder<List<LandmarkRequest>>(
            //Функция для определения, пришёл ли ответ на запрос
            future: landmarksF,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                //var date3 = DateTime.now();
                //print("ggggggg${date3.difference(date2)}");
                landmarks = snapshot.data!;
                //landmarksWithDistance=landmarks.map((e) => LandmarkWithDistance(landmarkInfo: e, distance: 0)).toList();
                debugPrint(landmarks[0].description);
                return TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    MapPage(
                      key: mapKey,
                      beginListenPosition: beginListenPosition,
                      landmarks: landmarks,
                      completer: _completer,
                    ),
                    ListPage(title: "", landmarks: landmarksWithDistance),
                    //ListPage(title: 'ffff', landmarks: landmarksWithDistance),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return TabBarView(
                children: [
                  Center(
                      child: Column(children: const [
                    SizedBox(height: 200),
                    CircularProgressIndicator(),
                    SizedBox(height: 32),
                    Text(
                      "Подождите немного,\n карта грузится)",
                      style: TextStyle(fontFamily:'Roboto',color: Color(0xFFF06B20)),
                    )
                  ])),
                  Center(
                      child: Column(children: const [
                    SizedBox(height: 200),
                    CircularProgressIndicator(),
                    SizedBox(height: 32),
                    Text(
                      "Подождите немного,\n карта грузится)",
                      style: TextStyle(fontFamily:'Roboto',color: Color(0xFFF06B20)),
                    )
                  ])),
                ],
              );
            },
          ),
        ),
      ),
    );
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
