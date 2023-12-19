import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyAppTheme {
  final Color primaryColor = Colors.pink.shade400;
  final Brightness brightness;
  final Color primaryThemColor;
  final Color backgroundColor;
  final Color appBarColor;
  final Color secondaryColor;
  final Color surfaceColor;

  MyAppTheme.dark()
      : brightness = Brightness.dark,
        primaryThemColor = Colors.white,
        secondaryColor = Colors.white70,
        backgroundColor = Color.fromARGB(255, 30, 30, 30),
        surfaceColor = Colors.white,
        appBarColor = Colors.black;

  MyAppTheme.light()
      : brightness = Brightness.light,
        primaryThemColor = Colors.black45,
        secondaryColor = Colors.black45,
        backgroundColor = Colors.white,
        surfaceColor = Color(0x0d000000),
        appBarColor = Color.fromARGB(255, 235, 235, 235);

  ThemeData getTheme(String languageCode) {
    return ThemeData(
      primaryColor: primaryColor,
      primarySwatch: Colors.blue,
      brightness: brightness,
      dividerTheme: DividerThemeData(
          color: secondaryColor, indent: 40, endIndent: 40, thickness: 2),
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: AppBarTheme(
          backgroundColor: appBarColor, foregroundColor: primaryThemColor),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(primaryColor),
        ),
      ),
      textTheme: languageCode == 'en' ? enPrimeryTextthem : faPrimeryTextthem,
    );
  }

  TextTheme get enPrimeryTextthem => GoogleFonts.latoTextTheme(
        TextTheme(
          bodyText2: TextStyle(
            color: secondaryColor,
            fontSize: 15,
          ),
        ),
      );

  TextTheme get faPrimeryTextthem => TextTheme(
        bodyText2: TextStyle(
          color: secondaryColor,
          fontSize: 15,
          fontFamily: 'vazir',
        ),
      );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.dark;
  Locale _locale = Locale('en');

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Colors.pink.shade400;
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      theme: _themeMode == ThemeMode.dark
          ? MyAppTheme.dark().getTheme(_locale.languageCode)
          : MyAppTheme.light().getTheme(_locale.languageCode),
      home: MyHomePage(
        toggleThemeMode: () {
          setState(
            () {
              if (_themeMode == ThemeMode.dark) {
                _themeMode = ThemeMode.light;
                print(ThemeData.light.toString());
              } else {
                _themeMode = ThemeMode.dark;
                print(ThemeData.light.toString());
              }
            },
          );
        },
        changeLanguage: (_Language newLanguage) {
          setState(
            () {
              _locale = newLanguage == _Language.en
                  ? const Locale('en')
                  : const Locale('fa');
            },
          );
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Function() toggleThemeMode;
  final Function(_Language _language) changeLanguage;

  const MyHomePage(
      {super.key, required this.toggleThemeMode, required this.changeLanguage});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum _skilType { photoshop, xd, illustrator, aftereffect, lightroom }

enum _Language {
  en,
  fa,
}

class _MyHomePageState extends State<MyHomePage> {
  _skilType _skill = _skilType.photoshop;
  _Language _language = _Language.en;

  void upadatLN(_Language language) {
    widget.changeLanguage(language);
    setState(() {
      _language = language;
    });
  }

  void update(_skilType skilType) {
    setState(() {
      this._skill = skilType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.profileTitle),
        actions: [
          const SizedBox(
            width: 5,
          ),
          const Icon(CupertinoIcons.chat_bubble),
          const SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: widget.toggleThemeMode,
            child: const Icon(CupertinoIcons.ellipsis_vertical),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/images/profile_image.png',
                      width: 60,
                      height: 60,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.name,
                          // style: Theme.of(context).textTheme.subtitle1,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(AppLocalizations.of(context)!.job),
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.location_solid,
                              size: 15,
                            ),
                            Text(AppLocalizations.of(context)!.location)
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    CupertinoIcons.heart,
                    color: Colors.pink.shade800,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 16),
              child: Text(AppLocalizations.of(context)!.summery),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 12, 32, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(AppLocalizations.of(context)!.selectedln),
                  CupertinoSlidingSegmentedControl<_Language>(
                    groupValue: _language,
                    children: {
                      _Language.en: Text(
                        AppLocalizations.of(context)!.enlanguage,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      _Language.fa: Text(
                        AppLocalizations.of(context)!.falanguage,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    },
                    onValueChanged: (value) {
                      if (value != null) upadatLN(value);
                    },
                  ),
                ],
              ),
            ),
            Divider(),
             Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 12, 0, 20),
                    child: Text(
                      AppLocalizations.of(context)!.skils,
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: Icon(
                      CupertinoIcons.chevron_down,
                      size: 12,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Wrap(
                direction: Axis.horizontal,
                spacing: 8,
                runSpacing: 8,
                children: [
                  Skill(
                    type: _skilType.photoshop,
                    title: 'Photoshop',
                    path: 'assets/images/app_icon_01.png',
                    ShadowColor: Colors.blue,
                    isActive: false,
                    onTap: () => update(_skilType.photoshop),
                  ),
                  Skill(
                    type: _skilType.xd,
                    title: 'Adob XD',
                    path: 'assets/images/app_icon_02.png',
                    ShadowColor: Colors.blue,
                    isActive: false,
                    onTap: () => update(_skilType.xd),
                  ),
                  Skill(
                    type: _skilType.illustrator,
                    title: 'Illustrator',
                    path: 'assets/images/app_icon_03.png',
                    ShadowColor: Colors.blue,
                    isActive: false,
                    onTap: () => update(_skilType.illustrator),
                  ),
                  Skill(
                    type: _skilType.aftereffect,
                    title: 'After Effect',
                    path: 'assets/images/app_icon_04.png',
                    ShadowColor: Colors.blue,
                    isActive: false,
                    onTap: () => update(_skilType.aftereffect),
                  ),
                  Skill(
                    type: _skilType.lightroom,
                    title: 'Lightroom',
                    path: 'assets/images/app_icon_05.png',
                    ShadowColor: Colors.blue,
                    isActive: false,
                    onTap: () => update(_skilType.lightroom),
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                   Text(AppLocalizations.of(context)!.pesrsonalinformation),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hoverColor: Colors.blue,
                      labelText: AppLocalizations.of(context)!.email,
                      prefixIcon: const Icon(
                        CupertinoIcons.at,
                      ),
                      focusColor: Colors.grey,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hoverColor: Colors.blue,
                      labelText: AppLocalizations.of(context)!.password,
                      prefixIcon: const Icon(
                        CupertinoIcons.padlock_solid,
                      ),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {}, child:  Text(AppLocalizations.of(context)!.save)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Skill extends StatelessWidget {
  final Function() onTap;
  final _skilType type;
  final String title;
  final String path;
  final Color ShadowColor;
  final bool isActive;

  const Skill(
      {super.key,
      required this.title,
      required this.path,
      required this.ShadowColor,
      required this.isActive,
      required this.type,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 120,
        height: 100,
        decoration: isActive
            ? BoxDecoration(
                color: Theme.of(context).disabledColor,
                borderRadius: BorderRadius.circular(16),
              )
            : null,
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Image.asset(
                path,
                width: 60,
                height: 60,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}
