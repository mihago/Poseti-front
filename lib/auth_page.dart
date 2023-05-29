import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:poseti/main_page.dart';
import 'package:poseti/map_page.dart';
import 'package:poseti/my_app_bar.dart';
import 'package:poseti/normal_button.dart';
import 'package:poseti/positive_button.dart';
import 'package:poseti/profile_data.dart';
import 'package:poseti/signup_page.dart';

import 'login_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(56), //height of appbar
        child: MyAppBar(),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              height: 40,
            ),
            Image.asset(
              "assets/logo_v.png",
              height: 157,
            ),
            const SizedBox(
              height: 30,
            ),
            NormalButton(
              text: "Войти",
              padding: 24,
              onPressed: () => {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                )
              },
            ),
            const SizedBox(
              height: 16,
            ),
            PositiveButton(
              text: "Зарегистрироваться",
              padding: 24,
              borderRadius: 50,
              onPressed: () => {
                Navigator.of(context).pushReplacement(PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      SignupPage(),
                  transitionDuration: Duration(seconds: 0),
                ))
              },
            ),
            const SizedBox(height: 16),
            const Text("ИЛИ", style: TextStyle(fontFamily:'Roboto',fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            NormalButton(
              text: "Продолжить без аккаунта",
              padding: 24,
              onPressed: () => {
                Navigator.of(context).pushReplacement(PageTransition(
                    type: PageTransitionType.fade,
                    child: MainPage(
                        title: ' ', profileData: ProfileData(email: "na",password: "na",landmarks: [-1]))))
              },
            ),
          ],
        ),
      ),
    );
  }
}
