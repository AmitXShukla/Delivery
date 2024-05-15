// Copyright 2021 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// import 'dart:convert';

import 'package:servicenow/views/inbox.dart';
import 'package:servicenow/views/login.dart';
import 'package:servicenow/views/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:web_startup_analyzer/web_startup_analyzer.dart';

import '../shared/constants.dart';
// import '../shared/home.dart';
import '../views/signup.dart';
import '../views/settings.dart';
import '../views/rides.dart';
import '../views/message.dart';
import '../views/ride.dart';
import '../views/bids.dart';
import '../views/bid.dart';

void main() async {
  // var analyzer = WebStartupAnalyzer(additionalFrameCount: 10);
  // debugPrint(json.encode(analyzer.startupTiming));
  // analyzer.onFirstFrame.addListener(() {
  //   debugPrint(json.encode({'firstFrame': analyzer.onFirstFrame.value}));
  // });
  // analyzer.onFirstPaint.addListener(() {
  //   debugPrint(json.encode({
  //     'firstPaint': analyzer.onFirstPaint.value?.$1,
  //     'firstContentfulPaint': analyzer.onFirstPaint.value?.$2,
  //   }));
  // });
  // analyzer.onAdditionalFrames.addListener(() {
  //   debugPrint(json.encode({
  //     'additionalFrames': analyzer.onAdditionalFrames.value,
  //   }));
  // });
  runApp(
    const App(),
  );
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
  // static _AppState? of(BuildContext context) => context.findAncestorStateOfType<_AppState>();
}

class _AppState extends State<App> {
  bool useMaterial3 = true;
  ThemeMode themeMode = ThemeMode.system;
  ColorSeed colorSelected = ColorSeed.baseColor;
  ColorImageProvider imageSelected = ColorImageProvider.leaves;
  ColorScheme? imageColorScheme = const ColorScheme.dark();
  ColorSelectionMethod colorSelectionMethod = ColorSelectionMethod.colorSeed;

  bool get useLightMode => switch (themeMode) {
        ThemeMode.system =>
          View.of(context).platformDispatcher.platformBrightness ==
              Brightness.light,
        ThemeMode.light => true,
        ThemeMode.dark => false
      };

  void handleBrightnessChange(bool useLightMode) {
    // useLightMode = true;
    setState(() {
      themeMode = useLightMode ? ThemeMode.light : ThemeMode.dark;
    });
  }

  void handleMaterialVersionChange() {
    setState(() {
      useMaterial3 = !useMaterial3;
    });
  }

  void handleColorSelect(int value) {
    setState(() {
      colorSelectionMethod = ColorSelectionMethod.colorSeed;
      colorSelected = ColorSeed.values[value];
    });
  }

  void handleImageSelect(int value) {
    final String url = ColorImageProvider.values[value].url;
    ColorScheme.fromImageProvider(provider: NetworkImage(url))
        .then((newScheme) {
      setState(() {
        colorSelectionMethod = ColorSelectionMethod.image;
        imageSelected = ColorImageProvider.values[value];
        imageColorScheme = newScheme;
      });
    });
  }

  // Locale _locale = "en" as Locale;
  Locale _locale = const Locale('es');

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: AppLocalizations.of(context)!.helloWorld,
      onGenerateTitle: (context) {
        return AppLocalizations.of(context)!.helloWorld;
      },
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // supportedLocales: const [
      //   Locale('en'), // English
      //   Locale('es'), // Spanish
      //   Locale('hi'), // Hindi
      // ],
      supportedLocales: AppLocalizations.supportedLocales,
      // locale: const Locale('en'),
      locale: _locale,
      themeMode: themeMode,
      theme: ThemeData.dark(),
      darkTheme: ThemeData.light(),
      // theme: ThemeData(
      //   colorSchemeSeed: colorSelectionMethod == ColorSelectionMethod.colorSeed
      //       ? colorSelected.color
      //       : null,
      //   colorScheme: colorSelectionMethod == ColorSelectionMethod.image
      //       ? imageColorScheme
      //       : null,
      //   useMaterial3: useMaterial3,
      //   // change theme colors here - TODOL read from user preferences
      //   brightness: Brightness.dark,
      // ),
      // darkTheme: ThemeData(
      //   colorSchemeSeed: colorSelectionMethod == ColorSelectionMethod.colorSeed
      //       ? colorSelected.color
      //       : imageColorScheme!.primary,
      //   useMaterial3: useMaterial3,
      //   // change theme colors here - TODOL read from user preferences
      //   brightness: Brightness.dark,
      // ),
      // home: Home(
      //   useLightMode: useLightMode,
      //   useMaterial3: useMaterial3,
      //   colorSelected: colorSelected,
      //   imageSelected: imageSelected,
      //   handleBrightnessChange: handleBrightnessChange,
      //   handleMaterialVersionChange: handleMaterialVersionChange,
      //   handleColorSelect: handleColorSelect,
      //   handleImageSelect: handleImageSelect,
      //   colorSelectionMethod: colorSelectionMethod,
      // ),
      home: LogIn(handleBrightnessChange: handleBrightnessChange, setLocale: setLocale),
        routes: {
        // '/': (context) => const LogIn(), //- can not set if home: ERPHomePage() is setup, only works with initiated route
        SignUp.routeName: (context) => SignUp(handleBrightnessChange: handleBrightnessChange, setLocale: setLocale),
        Dashboard.routeName: (context) => Dashboard(handleBrightnessChange: handleBrightnessChange, setLocale: setLocale),
        Settings.routeName: (context) => Settings(handleBrightnessChange: handleBrightnessChange, setLocale: setLocale),
        Inbox.routeName: (context) => Inbox(handleBrightnessChange: handleBrightnessChange, setLocale: setLocale),
        Rides.routeName: (context) => Rides(handleBrightnessChange: handleBrightnessChange, setLocale: setLocale),
        Message.routeName: (context) => Message(handleBrightnessChange: handleBrightnessChange, setLocale: setLocale),
        Ride.routeName: (context) => Ride(handleBrightnessChange: handleBrightnessChange, setLocale: setLocale),
        Bids.routeName: (context) => Bids(handleBrightnessChange: handleBrightnessChange, setLocale: setLocale),
        Bid.routeName: (context) => Bid(handleBrightnessChange: handleBrightnessChange, setLocale: setLocale),
      },
    );
  }
}