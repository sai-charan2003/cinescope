
import 'dart:io' show Platform;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinescope/TVshows.dart';
import 'package:cinescope/Trending.dart';
import 'package:cinescope/movies.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:window_size/window_size.dart';

void main() {
  ErrorWidget.builder = (FlutterErrorDetails details) => Container();
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowMinSize(const Size(1000, 1000));
    setWindowMaxSize(Size.infinite);
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  List popularl = [];
  List nowplayingl = [];
  List upcomingl = [];
  List topratedl = [];
  List trendingl = [];
  late int length;

  final tmbd = TMDB(
    ApiKeys('API_key',
        'key'),
    logConfig: const ConfigLogger(
      showLogs: true,
      showErrorLogs: true,
    ),
  );
  gettrending() async {
    Map trending = await tmbd.v3.trending.getTrending();
    Map popular = await tmbd.v3.movies.getPopular();
    Map nowplaying = await tmbd.v3.movies.getNowPlaying();
    Map upcoming = await tmbd.v3.movies.getUpcoming();
    Map toprated = await tmbd.v3.movies.getTopRated();

    setState(() {
      popularl = popular['results'];
      nowplayingl = nowplaying['results'];
      upcomingl = upcoming['results'];
      topratedl = toprated['results'];
      trendingl = trending['results'];
    });

    print(popularl);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gettrending();
    length = trendingl.length;
  }

  int _selectedindex = 0;
  void _onItemtap(int index) {
    setState(() {
      _selectedindex = index;
    });
  }

  final pages = [const movies(), const tvshows(), trending()];

  static final _defaultLightColorScheme =
      ColorScheme.fromSwatch(primarySwatch: Colors.blue);

  static final _defaultDarkColorScheme = ColorScheme.fromSwatch(
      primarySwatch: Colors.blue, brightness: Brightness.dark);

  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: lightColorScheme ?? _defaultLightColorScheme,
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: darkColorScheme ?? _defaultDarkColorScheme,
          useMaterial3: true,
        ),
        themeMode: ThemeMode.dark,
        home: Scaffold(
          body: pages[_selectedindex],
          bottomNavigationBar: NavigationBar(
            selectedIndex: _selectedindex,
            onDestinationSelected: _onItemtap,
            destinations: [
              const NavigationDestination(
                  icon: Icon(Icons.movie), label: 'Movies'),
              const NavigationDestination(
                  icon: Icon(Icons.tv), label: 'TV Shows'),
              const NavigationDestination(
                  icon: Icon(Icons.trending_up), label: 'Trending')
            ],
          ),
        ),
      );
    });
  }
}
