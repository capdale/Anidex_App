import 'dart:io';

import 'package:anidex_app/src/root.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_auth/kakao_flutter_sdk_auth.dart';
import 'package:provider/provider.dart';
import 'src/theme/_init.dart' as style;
import 'src/providers/_init.dart' as providers;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  String apiKey = Platform.environment['API_KEY'] ?? 'Default_API_Key';
  print('Your API Key is: $apiKey');
  KakaoSdk.init(
    nativeAppKey: apiKey,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (create) => providers.Tabs()),
    ChangeNotifierProvider(create: (create) => providers.UserInfo()),
    ChangeNotifierProvider(create: (create) => providers.SelectImage()),
    ChangeNotifierProvider(create: (create) => providers.UserInfo()),
    ChangeNotifierProvider(create: (create) => providers.CameraProvider()..setCamera(firstCamera)),
  ], child: MaterialApp(theme: style.mainTheme, home: const Root())));
}
