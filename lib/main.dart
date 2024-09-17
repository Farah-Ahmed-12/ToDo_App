import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/home/home_screen.dart';
import 'package:to_do_app/my_theme_data.dart';
import 'package:to_do_app/providers/app_language_provider.dart';
import 'package:to_do_app/providers/list_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: FirebaseOptions(
              apiKey: 'AIzaSyCRbvzqwfci-pe5A-lQf6bgpBsn3pchpck',
              appId: 'com.example.to_do_app',
              messagingSenderId: '66187982227',
              projectId: 'todo-app-online-d7640'))
      : await Firebase.initializeApp();
  await FirebaseFirestore.instance.disableNetwork();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppLanProvider()),
        ChangeNotifierProvider(create: (context) => ListProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppLanProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: homescreen.routeName,
      routes: {
        homescreen.routeName: (context) => homescreen(),
      },
      theme: MyThemeData.lightTheme,
      locale: Locale(provider.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
