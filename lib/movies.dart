// ignore_for_file: avoid_unnecessary_containers

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tmdb_api/tmdb_api.dart';

class movies extends StatefulWidget {
  const movies({super.key});

  @override
  State<movies> createState() => _moviesState();
}

class _moviesState extends State<movies> {
  List popularl = [];
  List nowplayingl = [];
  List upcomingl = [];
  List topratedl = [];
  List trendingl = [];

  final tmbd = TMDB(
    ApiKeys('38795e6decb3f2a4ebea79725e5721d2',
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzODc5NWU2ZGVjYjNmMmE0ZWJlYTc5NzI1ZTU3MjFkMiIsInN1YiI6IjY0OGVlYmM5MmY4ZDA5MDBhZDM1MzRiMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.O-RmGGquRM6CU0JAOfn48kB77pNw2abPkutlWDYAx2U'),
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

  int _selectedindex = 0;
  void _onItemtap(int index) {
    setState(() {
      _selectedindex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gettrending();
  }

  static final _defaultLightColorScheme =
      ColorScheme.fromSwatch(primarySwatch: Colors.blue);

  static final _defaultDarkColorScheme = ColorScheme.fromSwatch(
      primarySwatch: Colors.blue, brightness: Brightness.dark);
  @override
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
          appBar: AppBar(
            title: Text('Movies'),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Align(
                child: Text(
                  'Popular movies',
                  style: GoogleFonts.roboto(
                      fontSize: 25.0, fontWeight: FontWeight.w500),
                ),
                alignment: Alignment.topLeft,
              ),
              Expanded(
                // ignore: avoid_unnecessary_containers
                child: Container(
                  child: ListView.builder(
                    itemCount: popularl.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Expanded(
                        child: GestureDetector(
                          onTap: (){
                            showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: CachedNetworkImage(
                                imageUrl: 'https://image.tmdb.org/t/p/w500' +
                                    popularl[index]['poster_path'],
                                placeholder: (context, url) {
                                  return Placeholder();
                                },
                                
                              ),
                      ),
                      Text(popularl[index]['original_title'],style: GoogleFonts.roboto(fontSize: 20.0,fontWeight: FontWeight.w800),),
                      Padding(
                        padding: const EdgeInsets.only(left:10.0),
                        child: Align(child: Text('Rating :'+popularl[index]['vote_average'].toString(),style: GoogleFonts.roboto(fontSize: 15.0,fontWeight: FontWeight.w600),),alignment: Alignment.bottomLeft,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:10.0,top: 20.0),
                        child: Align(child: Text('Overview :'+popularl[index]['overview'].toString(),style: GoogleFonts.roboto(fontSize: 15.0,fontWeight: FontWeight.w600),),alignment: Alignment.bottomLeft,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:10.0,top: 20.0),
                        child: Align(child: Text('Release date :'+popularl[index]['release_date'].toString(),style: GoogleFonts.roboto(fontSize: 15.0,fontWeight: FontWeight.w600),),alignment: Alignment.bottomLeft,),
                      )
                      


                      
                      
                    ],
                  ),
                ),
              );
            },
          );
                          },
                          child: Card(
                            elevation: 50.0,
                            margin: EdgeInsets.only(right: 20.0, left: 5.0),
                            child: CachedNetworkImage(
                              imageUrl: 'https://image.tmdb.org/t/p/w500' +
                                  popularl[index]['poster_path'],
                              placeholder: (context, url) {
                                return Placeholder();
                              },
                              
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              
              SizedBox(height: 20.0,),
              Align(child: Text('Upcoming',style: GoogleFonts.roboto(fontSize: 25.0,fontWeight: FontWeight.w500),),alignment: Alignment.topLeft,),
                 Expanded(
                // ignore: avoid_unnecessary_containers
                child: Container(
                  child: ListView.builder(
                    itemCount: upcomingl.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Expanded(
                        child: GestureDetector(
                          onTap: (){
                            showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: CachedNetworkImage(
                                imageUrl: 'https://image.tmdb.org/t/p/w500' +
                                    upcomingl[index]['poster_path'],
                                placeholder: (context, url) {
                                  return Placeholder();
                                },
                                
                              ),
                      ),
                      Text(upcomingl[index]['original_title'],style: GoogleFonts.roboto(fontSize: 20.0,fontWeight: FontWeight.w800),),
                      Padding(
                        padding: const EdgeInsets.only(left:10.0),
                        child: Align(child: Text('Rating :'+upcomingl[index]['vote_average'].toString(),style: GoogleFonts.roboto(fontSize: 15.0,fontWeight: FontWeight.w600),),alignment: Alignment.bottomLeft,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:10.0,top: 20.0),
                        child: Align(child: Text('Overview :'+upcomingl[index]['overview'].toString(),style: GoogleFonts.roboto(fontSize: 15.0,fontWeight: FontWeight.w600),),alignment: Alignment.bottomLeft,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:10.0,top: 20.0),
                        child: Align(child: Text('Release date :'+upcomingl[index]['release_date'].toString(),style: GoogleFonts.roboto(fontSize: 15.0,fontWeight: FontWeight.w600),),alignment: Alignment.bottomLeft,),
                      )
                      


                      
                      
                    ],
                  ),
                ),
              );
            },
          );
                          },
                          child: Card(
                            elevation: 50.0,
                            margin: EdgeInsets.only(right: 20.0, left: 5.0),
                            child: CachedNetworkImage(
                              imageUrl: 'https://image.tmdb.org/t/p/w500' +
                                  upcomingl[index]['poster_path'],
                              placeholder: (context, url) {
                                return Placeholder();
                              },
                              
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              Align(child: Text('Top Rated',style: GoogleFonts.roboto(fontSize: 25.0,fontWeight: FontWeight.w500),),alignment: Alignment.topLeft,),
                 Expanded(
                // ignore: avoid_unnecessary_containers
                child: Container(
                  child: ListView.builder(
                    itemCount: topratedl.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Expanded(
                        child: GestureDetector(
                          onTap: (){
                            showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: CachedNetworkImage(
                                imageUrl: 'https://image.tmdb.org/t/p/w500' +
                                    topratedl[index]['poster_path'],
                                placeholder: (context, url) {
                                  return Placeholder();
                                },
                                
                              ),
                      ),
                      Text(topratedl[index]['original_title'],style: GoogleFonts.roboto(fontSize: 20.0,fontWeight: FontWeight.w800),),
                      Padding(
                        padding: const EdgeInsets.only(left:10.0),
                        child: Align(child: Text('Rating :'+topratedl[index]['vote_average'].toString(),style: GoogleFonts.roboto(fontSize: 15.0,fontWeight: FontWeight.w600),),alignment: Alignment.bottomLeft,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:10.0,top: 20.0),
                        child: Align(child: Text('Overview :'+topratedl[index]['overview'].toString(),style: GoogleFonts.roboto(fontSize: 15.0,fontWeight: FontWeight.w600),),alignment: Alignment.bottomLeft,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:10.0,top: 20.0),
                        child: Align(child: Text('Release date :'+topratedl[index]['release_date'].toString(),style: GoogleFonts.roboto(fontSize: 15.0,fontWeight: FontWeight.w600),),alignment: Alignment.bottomLeft,),
                      )
                      


                      
                      
                    ],
                  ),
                ),
              );
            },
          );
                          },
                          child: Card(
                            elevation: 50.0,
                            margin: EdgeInsets.only(right: 20.0, left: 5.0),
                            child: CachedNetworkImage(
                              imageUrl: 'https://image.tmdb.org/t/p/w500' +
                                  topratedl[index]['poster_path'],
                              placeholder: (context, url) {
                                return Placeholder();
                              },
                              
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
