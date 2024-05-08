import 'package:flutter/material.dart';
import 'package:anidex_app/src/app.dart';
import 'package:provider/provider.dart';
import 'package:anidex_app/src/providers/_init.dart' as providers;
import 'package:anidex_app/src/widgets/_init.dart' as widgets;

class EmailLogin extends StatefulWidget {
  const EmailLogin({super.key});

  @override
  State<EmailLogin> createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLogin> {
  final TextEditingController _emailController = TextEditingController();
  var isValid = false;
  var emailHint = Text('가입된 계정인지 확인할게요 😽',
      style: TextStyle(fontSize: 22, color: Color.fromRGBO(96, 96, 96, 1)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widgets.DefaultAppBar(
        barColor: Colors.white,
        showActions: false,
        elevation: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
            ),
            Text('모두의 동물도감을\n시작해 봅시다!',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 36)),
            SizedBox(
              height: 10,
            ),
            emailHint,
            SizedBox(height: 140),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                  hintText: '이메일 주소를 입력해 주세요.',
                  hintStyle: TextStyle(fontSize: 28)),
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 30),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50)),
                onPressed: () {
                  var key = true; // 가입된 이메일이냐?
                  isValid = _validateEmail(_emailController.text);
                  if (isValid) {
                    context
                        .read<providers.UserEmail>()
                        .changeUserEmail(_emailController.text);
                    if (key) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PasswordInput()));
                    } else {
                      widgets.showSignUpDialog(context);
                    }
                  } else {
                    setState(() {
                      emailHint = Text('잘못된 이메일 형식입니다 🙊',
                          style:
                              TextStyle(fontSize: 22, color: Colors.redAccent));
                    });
                  }
                },
                child: Text('계속하기',
                    style: TextStyle(
                      fontSize: 20,
                    )))
          ],
        ),
      ),
    );
  }

  bool _validateEmail(String email) {
    if (email.length > 64) {
      return false;
    }
    final RegExp emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    return emailRegExp.hasMatch(email);
  }
}

class PasswordInput extends StatefulWidget {
  const PasswordInput({super.key});

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  var pwdHint = Text('다시 만나서 반가워요! 😻',
      style: TextStyle(fontSize: 22, color: Color.fromRGBO(96, 96, 96, 1)));
  bool isIconVisible = true;
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widgets.DefaultAppBar(
        title: '로그인',
        barColor: Colors.white,
        showActions: false,
        elevation: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
              ),
              Text('비밀번호 입력',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 36)),
              SizedBox(height: 10),
              pwdHint,
              SizedBox(
                height: 130,
              ),
              SizedBox(height: 20),
              TextField(
                obscureText: hidePassword,
                decoration: InputDecoration(
                  hintText: '비밀번호를 입력해 주세요.',
                  hintStyle: TextStyle(fontSize: 28),
                  suffixIcon: isIconVisible
                      ? IconButton(
                          onPressed: () {
                            setState(() => hidePassword = !hidePassword);
                          },
                          icon: Icon(
                            hidePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        )
                      : null,
                ),
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50)),
                  onPressed: () {
                    var pwdRight = false;
                    if (pwdRight) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => const App()),
                          (route) => false);
                    } else {
                      setState(() {
                        pwdHint = Text('비밀번호가 달라요. 다시 입력해 주실래요?',
                            style: TextStyle(
                                fontSize: 22, color: Colors.redAccent));
                      });
                    }
                  },
                  child: Text('로그인',
                      style: TextStyle(
                        fontSize: 20,
                      ))),
              SizedBox(height: 30),
              Container(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    '비밀번호를 잊으셨나요?',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 22,
                        color: Color.fromRGBO(0, 0, 0, 0.6)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _pwdController1 = TextEditingController();
  final TextEditingController _pwdController2 = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  bool isIconVisible = true;
  bool hidePassword = true;

  bool pwd1Check = true;
  bool pwd2Check = true;
  bool nameCheck = true;

  @override
  Widget build(BuildContext context) {
    final userEmail = context.read<providers.UserEmail>().userEmail;
    return Scaffold(
      appBar: widgets.DefaultAppBar(
        title: '가입하기',
        barColor: Colors.white,
        showActions: false,
        elevation: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Text('아래 이메일로 가입합니다!',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 32)),
              SizedBox(height: 10),
              Text(
                userEmail,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 28,
                ),
              ),
              SizedBox(
                height: 70,
              ),
              Text('비밀번호 입력',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28)),
              TextField(
                obscureText: hidePassword,
                controller: _pwdController1,
                onChanged: (text) {
                  setState(() {
                    pwd1Check = _validatePwd(text);
                  });
                },
                decoration: InputDecoration(
                  hintText: '8~16자리를 입력해 주세요.',
                  hintStyle: TextStyle(fontSize: 24),
                  suffixIcon: isIconVisible
                      ? IconButton(
                          onPressed: () {
                            setState(() => hidePassword = !hidePassword);
                          },
                          icon: Icon(
                            hidePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        )
                      : null,
                ),
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 5),
              pwd1Check ? _showHint('') : _showHint('비밀번호 자릿수를 확인해 주세요.'),
              SizedBox(height: 20),
              Text('비밀번호 확인',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28)),
              TextField(
                obscureText: hidePassword,
                controller: _pwdController2,
                onChanged: (text) {
                  setState(() {
                    pwd2Check = _samePwd(text, _pwdController1.text);
                  });
                },
                decoration: InputDecoration(
                  hintText: '다시 한번 입력해 주세요.',
                  hintStyle: TextStyle(fontSize: 24),
                  suffixIcon: isIconVisible
                      ? IconButton(
                          onPressed: () {
                            setState(() => hidePassword = !hidePassword);
                          },
                          icon: Icon(
                            hidePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        )
                      : null,
                ),
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 5),
              pwd2Check ? _showHint('') : _showHint('비밀번호가 일치하지 않아요.'),
              SizedBox(height: 20),
              Text('이름',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28)),
              TextField(
                controller: _nameController,
                onChanged: (text) {
                  setState(() {
                    nameCheck = _validateName(text);
                  });
                },
                decoration: InputDecoration(
                  hintText: '이름을 입력해 주세요.',
                  hintStyle: TextStyle(fontSize: 24),
                ),
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 5),
              nameCheck ? _showHint('') : _showHint('올바른 이름을 입력해 주세요.'),
              SizedBox(height: 50),
              Text(
                '아래 버튼을 누르면 인증 메일이 발송됩니다.\n인증을 완료하시고 다시 한번 로그인해 주세요.',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50)),
                  onPressed: () {
                    bool pwdRight = (_pwdController1.text.isNotEmpty &&
                        _pwdController2.text.isNotEmpty &&
                        _nameController.text.isNotEmpty &&
                        pwd1Check &&
                        pwd2Check &&
                        nameCheck);
                    if (pwdRight) {
                      widgets.showMessageDialog(context, '인증 메일이 발송되었습니다.', popAll: true);
                    } else {
                      widgets.showMessageDialog(
                          context, '입력한 내용을 다시 한번 확인해주세요.');
                    }
                  },
                  child: Text('인증 메일 발송',
                      style: TextStyle(
                        fontSize: 20,
                      ))),
            ],
          ),
        ),
      ),
    );
  }

  bool _validatePwd(String pwd) {
    if (pwd.length <= 16 && pwd.length >= 8) {
      return true;
    }
    return false;
  }

  bool _samePwd(String pwd1, String pwd2) {
    if (pwd1.isNotEmpty && pwd1 == pwd2) {
      return true;
    }
    return false;
  }

  bool _validateName(String name) {
    if (name.isNotEmpty && name.length < 30) {
      return true;
    }
    return false;
  }

  Text _showHint(String hint) {
    return Text(hint, style: TextStyle(fontSize: 18, color: Colors.redAccent));
  }
}
