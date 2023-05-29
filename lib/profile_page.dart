import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:poseti/add_landmark_page1.dart';
import 'package:poseti/auth_page.dart';
import 'package:poseti/danger_button.dart';
import 'package:poseti/my_app_bar.dart';
import 'package:poseti/normal_button.dart';
import 'package:poseti/positive_button.dart';
import 'package:poseti/profile_data.dart';
import 'package:poseti/signup_page.dart';
import 'package:poseti/stats_item.dart';
import 'package:poseti/theme/custom_theme.dart';

import 'bottom_navigation_item.dart';
import 'login_page.dart';
import 'map_page.dart';

class ProfilePage extends StatefulWidget {
  final ProfileData profileData;
  const ProfilePage({required this.profileData, super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 0;

  //Функция для работы нижнего меню
  void _onItemTapped(int index) {
    int old_index = _selectedIndex;
    setState(() {
      _selectedIndex = index;
    });

    if (old_index != index) {
      if (index == 0) {
        //TODO:Продумать процесс навигации

      } else {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const PreferredSize(
        //wrap with PreferredSize
        preferredSize: Size.fromHeight(56), //height of appbar
        child: MyAppBar(),
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
      body: Center(
        child: ListView(
          children: [
            const SizedBox(
              height: 32,
            ),
            Center(
                child: Container(
                    width: 130,
                    height: 130,
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(70)),
                        color: Colors.green,
                        boxShadow: [
                          BoxShadow(
                              color: Color(0x20000000),
                              blurRadius: 4,
                              offset: Offset(1, 5)),
                        ]),
                    child: FittedBox(
                        child: Text(
                            widget.profileData.email != "na"
                                ? widget.profileData.email![0]
                                : "А",
                            style: const TextStyle(fontFamily:'Roboto',
                                fontSize: 36, color: Colors.white))))),
            const SizedBox(
              height: 32,
            ),

            Center(
              child: Text(
                widget.profileData.email! != "na"
                    ? widget.profileData.email!
                    : "Аноним",
                style: const TextStyle(fontFamily:'Roboto',fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
                child: Text(
              "Статистика",
              style: CustomTheme.lightTheme.textTheme.headline1,
            )),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.fromLTRB(44, 0, 44, 0),
              child: Column(
                children: [
                  StatsItem(
                      definition: "Достопримечательностей посещено",
                      index: "${widget.profileData.landmarks?.first==-1?0:widget.profileData.landmarks?.length}")
                ],
              ),
            ),

            /* NormalButton(
              text: "Сменить пароль",
              padding: 24,
              onPressed: () => {},
            ),*/ //Todo:Здесь сделать сброс пароля

            const SizedBox(
              height: 40,
            ),

            widget.profileData.email != "na"
                ? Column(children: [
                    DangerButton(
                        text: "Выйти из аккаунта",
                        padding: 24,
                        onPressed: () => {
                              Navigator.of(context)
                                  .pop(), //TODO:Подумать про Routing
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const AuthPage(),
                                ),
                              )
                            }),
              SizedBox(
                height: 16,
              ),
                    NormalButton(
                      text: "Добавить достопримечательность",
                      onPressed: () => Navigator.of(context).push(
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: AddLandmarkPage1(
                                  profileData: widget.profileData))),
                      padding: 24,
                    ),
                  ])
                : Column(
                    children: [
                      NormalButton(
                        text: "Войти",
                        padding: 24,
                        onPressed: () => {
                          Navigator.of(context).push(
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
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SignupPage(),
                            ),
                          )
                        },
                      ),
                      SizedBox(
                        height: 16,
                      )
                    ],
                  ),

            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
