import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:poseti/add_landmark_page2.dart';
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
class AddLandmarkPage1 extends StatefulWidget {
  final ProfileData profileData;
  const AddLandmarkPage1({required this.profileData, super.key});

  @override
  State<AddLandmarkPage1> createState() => _AddLandmarkPage1State();
}

class _AddLandmarkPage1State extends State<AddLandmarkPage1> {

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final definitionController = TextEditingController();
  String? isNotEmptyValidator(String? value){
    if (value == null || value.isEmpty) {
      return 'Это поле обязательно для заполнения';
    }
    return null;
  }
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    definitionController.dispose();
    super.dispose();
  }
  Future<void> validateAndSubmit() async {
    if (_formKey.currentState!.validate())
    {
      var name= nameController.text;
      var definition= definitionController.text;
      Navigator.of(context).pushReplacement( PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => AddLandmarkPage2(name: name,definition: definition,profileData: widget.profileData),
        transitionDuration: Duration(seconds: 0),
      ));
    }

  }
  Widget build(BuildContext context) {
    //return

    return MaterialApp(home:Scaffold(
        resizeToAvoidBottomInset : false,
        appBar: const PreferredSize(
        preferredSize: Size.fromHeight(56), //height of appbar
    child: MyAppBar(),
    ),
    body: Container(

        child: Form(
            key: _formKey,

            child: ListView(   padding: const EdgeInsets.fromLTRB(16, 0, 16, 0), children: [
              SizedBox(
                height: 24,
              ),
              Text(
                "Добавь новую достопримечательность!",
                style: CustomTheme.lightTheme.textTheme.headline1,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 36,
              ),
              Text(
                "Название",
                style: CustomTheme.lightTheme.textTheme.headline2,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                validator: isNotEmptyValidator,
                controller: nameController,
                minLines: 2,
                maxLines: 5,
                style: TextStyle(fontFamily:'Roboto',fontSize: 16),
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF20ADEA), width: 2)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.black, width: 2))),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                "Описание",
                style: CustomTheme.lightTheme.textTheme.headline2,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                validator: isNotEmptyValidator,
                controller: definitionController,
                minLines: 2,
                maxLines: 5,
                style: TextStyle(fontFamily:'Roboto',fontSize: 18),
                decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Color(0xFF20ADEA), width: 2)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.black, width: 2))),
              ),
              SizedBox(
                height: 16,
              ),
              PositiveButton(
                text: "Далее",
                padding: 0,
                borderRadius: 8,
                onPressed: validateAndSubmit, //TODO:Здесь тоже
              ),
              SizedBox(height: 16,),


            ]
            )
        )
    )));
  }
}
