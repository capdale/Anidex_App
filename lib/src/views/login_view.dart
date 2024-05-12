import 'package:anidex_app/src/providers/_init.dart' as providers;
import 'package:anidex_app/src/Root.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:provider/provider.dart';

class LoginModel {
  final Login _login;
  bool isLogined = false;
  User? user;

  LoginModel(this._login);

  Future login(BuildContext context) async {
    isLogined = await _login.login(context);
    if (isLogined) {
      user = await UserApi.instance.me();
      if (context.mounted) {
        context.read<providers.UserInfo>().changeUser(user);
        context.read<providers.UserInfo>().changeIsLogined(isLogined);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const Root()),
                (route) => false);
      }
    }
  }

  Future logout(BuildContext context) async {
    await _login.logout(context);
    if (context.mounted) {
      context.read<providers.UserInfo>().changeUser(null);
      context.read<providers.UserInfo>().changeIsLogined(false);
    }
  }
}

abstract class Login {
  Future<bool> login(BuildContext context);

  Future<void> logout(BuildContext context);
}

class KakaoLogin extends Login {
  bool isLogined = false;
  var user;

  @override
  Future<bool> login(BuildContext context) async {
    print(await KakaoSdk.origin);
    if (await isKakaoTalkInstalled()) {
      try {
        await UserApi.instance.loginWithKakaoTalk();
        print('카카오톡으로 로그인 성공');
        return true;
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');

        if (error is PlatformException && error.code == 'CANCELED') {
          if (context.mounted) {
            Navigator.of(context).pop(false);
          }
        }
        try {
          await UserApi.instance.loginWithKakaoAccount();
          print('카카오톡으로 로그인 성공');
          return true;
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
          return false;
        }
      }
    } else {
      try {
        await UserApi.instance.loginWithKakaoAccount();
        print('카카오계정으로 로그인 성공');
        return true;
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
        return false;
      }
    }
  }

  @override
  Future<void> logout(BuildContext context) async {
    await UserApi.instance.unlink();
    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const Root()),
              (route) => false);
    }
  }
}
