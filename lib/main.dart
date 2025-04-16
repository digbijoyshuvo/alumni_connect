import 'dart:io';

import 'package:alumni_connect/data/saved_data.dart';
import 'package:alumni_connect/routes/routes.dart';
import 'package:alumni_connect/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await SavedData.init();
  HttpOverrides.global =MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.darkThemeMode,
      routerConfig: router,
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
    ..badCertificateCallback =
    (X509Certificate cert, String host, int port) => true;
  }
}
