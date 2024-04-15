import 'package:flutter/material.dart';
import '../widgets/_init.dart' as widgets;

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    final imageSize = MediaQuery.of(context).size.width / 3;
    var nickname = "user1234";
    var email = "user1234@naver.com";
    var introduction = "안녕하세요, 만나서 반갑습니다.";

    return Column(
      children: [
        Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.width * 0.5,
            minWidth: MediaQuery.of(context).size.width,
          ),
          child: Center(
            child: Icon(
              Icons.account_circle,
              size: imageSize,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12, width: 2),
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Table(
            border: TableBorder.symmetric(
              inside: BorderSide(color: Colors.black12, width: 2),
              outside: BorderSide.none,
            ),
            children: [
              TableRow(children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangeNickName(
                                  nickname: nickname,
                                )));
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(15, 20, 5, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '닉네임',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        Row(
                          children: [
                            Text(
                              nickname,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: Colors.grey,
                              size: 30,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ]),
              TableRow(children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangeEmail(
                                  email: email,
                                )));
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(15, 20, 5, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '대표 이메일',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        Row(
                          children: [
                            Text(
                              'User1234@naver.com',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: Colors.grey,
                              size: 30,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ]),
              TableRow(children: [
                InkWell(
                  onTap: () {
                    // TODO : 소셜 계정 구현
                    print("1");
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(15, 20, 5, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '연동된 소셜 계정',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        Row(
                          children: [
                            Text(
                              'User1234',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: Colors.grey,
                              size: 30,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ]),
              TableRow(children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangeIntroduction(
                                  introduction: introduction,
                                )));
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(15, 20, 5, 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '소개',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: Colors.grey,
                                size: 30,
                              )
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 14),
                            child: Text(
                              introduction,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ]),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ],
    );
  }
}

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
