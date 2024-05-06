import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:anidex_app/src/pages/_init.dart' as pages;
import 'package:anidex_app/src/store/_init.dart' as store;
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            SystemNavigator.pop();
          },
          icon: Icon(Icons.close, size: 30,),
        ),
      ),
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '모두의 동물도감',
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: 5),
          Text(
            '🐶 내 손으로 완성하는 나만의 동물도감 😺',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color.fromRGBO(0, 0, 0, 0.7)),
          ),
          SizedBox(height: 80),
          InkWell(
            onTap: () {},
            child: Image.asset('assets/login_btn/kakao_login.png'),
          ),
          SizedBox(height: 15),
          InkWell(
            onTap: () {},
            child: Image.asset('assets/login_btn/naver_login.png'),
          ),
          SizedBox(height: 15),
          InkWell(
            onTap: () {},
            child: Image.asset('assets/login_btn/google_login.png'),
          ),
          SizedBox(height: 15),
          InkWell(
            onTap: () {},
            child: Image.asset('assets/login_btn/facebook_login.png'),
          ),
          SizedBox(height: 100),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => pages.EmailLogin()),
              );
            },
            child: SizedBox(
              width: 160,
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  '이메일로 시작하기',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Icon(
                  Icons.keyboard_arrow_right,
                  size: 22,
                )
              ]),
            ),
          ),
          SizedBox(height: 70),
        ],
      ),
    ));
  }
}
