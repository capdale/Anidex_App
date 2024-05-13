import 'package:flutter/material.dart';
import 'package:anidex_app/src/widgets/_init.dart' as widgets;

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    var nickname = "user1234";
    var email = "user1234@naver.com";
    var introduction = "안녕하세요, 만나서 반갑습니다.";

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.width * 0.5,
              minWidth: MediaQuery.of(context).size.width,
            ),
            child: Center(child: widgets.ProfileImageSetting()),
          ),
          widgets.profileTable(context, nickname, email, introduction),
          SizedBox(height: 60),
          widgets.withdrawButton(context)
        ],
      ),
    );
  }
}

// ChangeNickName
class ChangeNickName extends StatefulWidget {
  const ChangeNickName({super.key, this.nickname});

  final String? nickname;

  @override
  State<ChangeNickName> createState() => _ChangeNickNameState();
}

class _ChangeNickNameState extends State<ChangeNickName> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.nickname);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: widgets.DefaultAppBar(
          title: "닉네임 변경",
          showActions: false,
        ),
        body: Container(
          margin: EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "닉네임",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _controller.clear();
                    },
                  )),
              style: TextStyle(fontSize: 18),
            ),
          ]),
        ),
        bottomNavigationBar: widgets.ChangeProfileButton(
          formName: "닉네임",
        ));
  }
}

// ChangeEmail
class ChangeEmail extends StatefulWidget {
  const ChangeEmail({super.key, this.email});

  final String? email;

  @override
  State<ChangeEmail> createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.email);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: widgets.DefaultAppBar(
          title: "이메일 변경",
          showActions: false,
        ),
        body: Container(
          margin: EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "이메일",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _controller.clear();
                    },
                  )),
              style: TextStyle(fontSize: 18),
            ),
          ]),
        ),
        bottomNavigationBar: widgets.ChangeProfileButton(
          formName: "이메일",
        ));
  }
}

// ChangeIntroduction
class ChangeIntroduction extends StatefulWidget {
  const ChangeIntroduction({super.key, this.introduction});

  final String? introduction;

  @override
  State<ChangeIntroduction> createState() => _ChangeIntroductionState();
}

class _ChangeIntroductionState extends State<ChangeIntroduction> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.introduction);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: widgets.DefaultAppBar(
          title: "소개 변경",
          showActions: false,
        ),
        body: Container(
          margin: EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "소개",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.multiline,
              maxLines: 10,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
              style: TextStyle(fontSize: 18),
            ),
          ]),
        ),
        bottomNavigationBar: widgets.ChangeProfileButton(
          formName: "소개",
        ));
  }
}
