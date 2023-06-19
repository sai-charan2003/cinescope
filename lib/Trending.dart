// ignore_for_file: avoid_unnecessary_containers

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tmdb_api/tmdb_api.dart';

class trending extends StatefulWidget {
  const trending();
  

  @override
  State<trending> createState() => _trendingState();
}

class _trendingState extends State<trending> {
  List popularl = [];
  List nowplayingl = [];
  List upcomingl = [];
  List trendingl = [];
  

  final tmbd = TMDB(
    ApiKeys('',
        'JhdWQiOiIzODc5NWU2ZGVjYjNmMmE0ZWJlYTc5NzI1ZTU3MjFkMiIsInN1YiI6IjY0OGVlYmM5MmY4ZDA5MDBhZDM1MzRiMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.O-RmGGquRM6CU0JAOfn48kB77pNw2abPkutlWDYAx2U'),
    logConfig: const ConfigLogger(
      showLogs: true,
      showErrorLogs: true,
    ),
  );
  Future gettrending() async {
    Map trending = await tmbd.v3.trending.getTrending();


    setState(() {
      
      trendingl = trending['results'];
    });

    print(trending);
  }

  void _onItemtap(int index) {
    setState(() {
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
            title: Text('Trending'),
            centerTitle: true,
          ),
          body: Center(
            child: CarouselSlider.builder(
              options: CarouselOptions(
                height: 400,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                scrollDirection: Axis.horizontal,
              ),
              itemCount: trendingl.length,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) =>
                      Container(
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
                                    trendingl[itemIndex]['poster_path'],
                                placeholder: (context, url) {
                                  return Placeholder();
                                },
                                
                              ),
                      ),
                      Text(trendingl[itemIndex]['title'],style: GoogleFonts.roboto(fontSize: 20.0,fontWeight: FontWeight.w800),),
                      Padding(
                        padding: const EdgeInsets.only(left:10.0),
                        child: Align(child: Text('Rating :'+trendingl[itemIndex]['vote_average'].toString(),style: GoogleFonts.roboto(fontSize: 15.0,fontWeight: FontWeight.w600),),alignment: Alignment.bottomLeft,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:10.0,top: 20.0),
                        child: Align(child: Text('Overview :'+trendingl[itemIndex]['overview'].toString(),style: GoogleFonts.roboto(fontSize: 15.0,fontWeight: FontWeight.w600),),alignment: Alignment.bottomLeft,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:10.0,top: 20.0),
                        child: Align(child: Text('Release date :'+trendingl[itemIndex]['release_date'].toString(),style: GoogleFonts.roboto(fontSize: 15.0,fontWeight: FontWeight.w600),),alignment: Alignment.bottomLeft,),
                      )
                      


                      
                      
                    ],
                  ),
                ),
              );
            },
          );
                          },
                  child: CachedNetworkImage(
                    imageUrl: 'https://image.tmdb.org/t/p/w500' +
                        trendingl[itemIndex]['poster_path'],
                    placeholder: (context, url) {
                      return Placeholder();
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
