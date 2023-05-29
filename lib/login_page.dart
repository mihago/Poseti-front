import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:poseti/auth_form.dart';
import 'package:poseti/danger_button.dart';
import 'package:poseti/map_page.dart';
import 'package:poseti/my_app_bar.dart';
import 'package:poseti/normal_button.dart';
import 'package:poseti/positive_button.dart';
import 'package:poseti/profile_data.dart';
import 'package:poseti/signup_page.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import "package:http/http.dart" as http;
import 'AuthTextFormField.dart';
import 'main_page.dart';
const invalidPassword="-1";
const invalidEmail="0";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoginIncorrect=false;
  bool isPasswordIncorrect=false;
   var authStatus="10";
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoginIncorrect=false;
    isPasswordIncorrect=false;
  }
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  Future<void> validateAndSubmit() async {
      if (_formKey.currentState!.validate())
        {
           var email= emailController.text;
           var password= passwordController.text;

           http.get(Uri.parse('http://90.156.228.153:8000/dispatcher/authorisation/sign_in/?login=$email&password=$password&token=mgGp76209aN4AJUaGZA1ByVoLVBHcfpfJ1nF5D/a08TbcRlXOIIvmdd9Wkw!KdV?lwz5xSeEYsoPl0mkN76lmYYzdxLVQ!KqfWwX-NTGiXy00F?YXeRqGfP93dfOng9jhA=zG9nnHzQojZG!KEtxJGShgNRG2rhWLW4zBJIqngMMBEkDdpzoXZ8CnefF0!/13KrTBoff6H2xN5L9Ttt8?0nqmLdnPsZiPXrZ2T32w8t7KaEaAe72zMxvluEhT!8L')).then((response) {
            if(response.statusCode==200){
              String? loginAccept=response.headers["login_accept"] ;
              String? passwordAccept=response.headers["password_accept"] ;
              for(var i in response.headers.keys ){
                if (kDebugMode) {
                  print("$i ${response.headers[i]}");
                }
              }
              if(loginAccept=="1"&&passwordAccept=="1"){
                ProfileData profileData;
                if(response.headers["landmark"] != null&&response.headers["landmark"] != "None"&&response.headers["landmark"] != ""){
                  var l = response.headers["landmark"]!;
                  List<int> x;
                   l.substring(1,l.length-1);
                   x = l.split(",").cast<int>();





                  profileData   = ProfileData(email: email,password: password,landmarks:x );
                  print("rrss${profileData.landmarks[0]}");
                }else{
                  print("rr");
                  profileData =  ProfileData(email: email,password: password,landmarks: [-1]);
                }
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                       MainPage(title: "",profileData: profileData,),
                  ),
                );
              }else if(loginAccept=="0"){
               setState((){
               isLoginIncorrect = true;
               isPasswordIncorrect = false;
               _formKey.currentState!.validate();
               });

              }
              else{
                setState((){
                  isLoginIncorrect = false;
                  isPasswordIncorrect = true;
                  _formKey.currentState!.validate();
                });
              }
            }
           }).catchError((error){
             print("Error: $error");
           });

        }

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        //wrap with PreferredSize
        preferredSize: const Size.fromHeight(56), //height of appbar
        child: MyAppBar(),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(34, 0, 34, 0),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Вход",
                  style: TextStyle(fontFamily:'Roboto',fontWeight: FontWeight.w600, fontSize: 24),
                ),
                const SizedBox(
                  height: 36,
                ),
                Form(

                    key: _formKey,
                    child: Column(
                      children: [
                        AuthTextFormField(
                          controller: emailController,
                          labelText: "Эл.почта",
                          icon: Icons.mail_outline,
                          type: "email",
                          wasInvalid: false,
                        ),
                        isLoginIncorrect==true?const Text("Нет такого пользователя",style: TextStyle(fontFamily:'Roboto',fontSize: 12,color: Colors.red),):Container(),
                        const SizedBox(
                          height: 24,
                        ),
                         AuthTextFormField(
                          controller: passwordController,
                          labelText: "Пароль",
                          icon: Icons.lock_outline,
                          type: "password",
                           wasInvalid: false,
                        ),
                        isPasswordIncorrect==true?const Text("Неправильный пароль",style: TextStyle(fontFamily:'Roboto',fontSize: 12,color: Colors.red),):Container(),
                        const SizedBox(
                          height: 24,
                        ),
                        PositiveButton(
                          text: "Войти",
                          padding: 0,
                          borderRadius: 8,
                          onPressed:validateAndSubmit,
                        ),

                      ],
                    )),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Забыли пароль?",
            style: TextStyle(fontFamily:'Roboto',color: Color(0xFFF06B20)),
          ),
          const SizedBox(height: 40),
          const Text("Впервые здесь?"),
          GestureDetector(
            onTap: () => {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SignupPage(),
                ),
              )
            },
            child: const Text(
              "Зарегистрироваться?",
              style: TextStyle(fontFamily:'Roboto',color: Color(0xFFF06B20)),
            ),
          )
        ],
      ),
    );
  }
}
