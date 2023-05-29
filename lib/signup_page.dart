import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import 'package:poseti/login_page.dart';
import 'package:poseti/positive_button.dart';
import 'package:poseti/profile_data.dart';
import 'package:poseti/user_data.dart';
import 'AuthTextFormField.dart';
import 'main_page.dart';
import 'map_page.dart';
import 'my_app_bar.dart';
class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool wasEmailTaken = false;
  final _formKey = GlobalKey<FormState>();
  //Переменные для контроля состояния текстового файла
  final passwordController = TextEditingController();
  final passwordRepeatController = TextEditingController();
  final emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordRepeatController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    wasEmailTaken = false;
  }
  void validateAndSubmit(){


      if (_formKey.currentState!.validate())
        {
          setState(() {
            wasEmailTaken=false;
          });
          var email= emailController.text;
          var password= passwordController.text;
          var passwordRepeat =passwordRepeatController.text;
          UserData userdata = UserData(login:email, password: password);
          String jsonUserData = jsonEncode(userdata);
            http.get(
            Uri.parse('http://90.156.228.153:8000/dispatcher/authorisation/sign_up/?login=$email&password=$password&token=mgGp76209aN4AJUaGZA1ByVoLVBHcfpfJ1nF5D/a08TbcRlXOIIvmdd9Wkw!KdV?lwz5xSeEYsoPl0mkN76lmYYzdxLVQ!KqfWwX-NTGiXy00F?YXeRqGfP93dfOng9jhA=zG9nnHzQojZG!KEtxJGShgNRG2rhWLW4zBJIqngMMBEkDdpzoXZ8CnefF0!/13KrTBoff6H2xN5L9Ttt8?0nqmLdnPsZiPXrZ2T32w8t7KaEaAe72zMxvluEhT!8L'),
          ).then((response){
              for(var i in response.headers.keys){
                print("debugging${i} ${response.headers[i]}");
              }
              if(response.headers["login_accept"]=="1"){

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) =>
                        MainPage(title: "",profileData: ProfileData(email: email,password:password,landmarks: [-1]),),
                  ),
                );
              }else{
setState(() {
  wasEmailTaken=true;
});

              }



            });

        }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const PreferredSize(
          //wrap with PreferredSize
          preferredSize: Size.fromHeight(56), //height of appbar
          child: PreferredSize(
            //wrap with PreferredSize
            preferredSize: Size.fromHeight(56), //height of appbar
            child: MyAppBar(),
          ),
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
                    "Регистрация",
                    style: TextStyle(fontFamily:'Roboto',fontWeight: FontWeight.w600, fontSize: 24),
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  Form(
key:_formKey,
                      child: Column(
                    children: [
                      AuthTextFormField(
                        controller: emailController,
                          labelText: "Эл.почта",
                          icon: Icons.mail_outline,
                          type: "email",
                        wasInvalid: false,
                      ),
                      wasEmailTaken==true?const Text("Аккаунт с такой почтой уже существует",style: TextStyle(fontFamily:'Roboto',fontSize: 12,color: Colors.red),):Container(),
                      const SizedBox(
                        height: 16,
                      ),
                      AuthTextFormField(
                        controller: passwordController,
                          labelText: "Пароль",
                          icon: Icons.lock_outline,
                          type: "password",
                        wasInvalid: false,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        validator: (value){
                      if (value == null || value.isEmpty) {
                      return 'Это поле обязательно для заполнения';

                      }else if(passwordRepeatController.text!=passwordController.text){
                        return 'Пароли не совпадают';
                      }
                      return null;
                      },
                        controller: passwordRepeatController,
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: "Введите пароль ещё раз",
                              labelStyle: const TextStyle(fontFamily:'Roboto',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF20ADEA), width: 2)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 2)))),
                      const SizedBox(
                        height: 16,
                      ),
                      PositiveButton(
                        text: "Зарегистрироваться",
                        padding: 0,
                        borderRadius: 8,
                        onPressed: validateAndSubmit, //TODO:Здесь тоже
                      ),
                    ],
                  )),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            const Text("Уже есть аккаунт?"),
            GestureDetector(
              onTap: () => {
                Navigator.of(context).pop(),//TODO:Подумать про Routing
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                )
              },
              child: const Text(
                "Войти",
                style: TextStyle(fontFamily:'Roboto',color: Color(0xFFF06B20)),
              ),
            ),
          ],
        ));
  }
}
