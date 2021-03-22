import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{
  final autoSizeGroup = AutoSizeGroup();

  var _bottomNavIndex = 0;
  AnimationController _animationController;

  Animation<double> animation;

  CurvedAnimation curve;

  final iconList = <IconData>[
    Icons.home,
    Icons.location_on_outlined,
    Icons.settings,
    Icons.account_circle,
  ];

  @override
  void initState() {
    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);

    Future.delayed(
      Duration(seconds: 1),
          () => _animationController.forward(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.fromLTRB(30, 72, 30, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hello, User',
                style: GoogleFonts.montserrat(
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
               ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15),
              Card(
                elevation: 5,
                shadowColor: Colors.grey[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SizedBox(
                  width: 700,
                  height: 250,
                  child: Column(
                    children:[
                      Expanded(child: Text("Charts and stuff")),
                      Divider(
                        height: 15,
                        thickness: 2,
                        indent: 50,
                        endIndent: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children:[
                          Container(
                            padding: EdgeInsets.all(1),
                            child: AutoSizeText(
                              'You have saved bla bla bla bla BLA BLA BLA',
                              maxLines: 2,
                              style: GoogleFonts.montserrat(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                color: HexColor("707070"),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: EdgeInsets.all(20),
                              child: Icon(
                                FontAwesomeIcons.recycle,
                                color: Colors.green[600],
                                size: 46,
                              ),
                            ),
                          ),
                        ]
                      ),
                    ]
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: ScaleTransition(
          scale: animation,
            child: FloatingActionButton(
              elevation: 8,
              onPressed: () {
                _animationController.reset();
                _animationController.forward();
              },
              backgroundColor: Colors.white,
              child: Icon(
                Icons.camera_alt_outlined,
                color: HexColor("#184E77"),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          itemCount: iconList.length,
          tabBuilder: (int index, bool isActive) {
            final color = isActive ? Colors.white : Colors.white38;
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconList[index],
                  size: 24,
                  color: color,
                ),
              ],
            );
          },
          backgroundColor: HexColor("#184E77"),
          activeIndex: _bottomNavIndex,
          splashColor: HexColor('#FFA400'),
          notchAndCornersAnimation: animation,
          splashSpeedInMilliseconds: 300,
          notchSmoothness: NotchSmoothness.defaultEdge,
          gapLocation: GapLocation.center,
          leftCornerRadius: 32,
          rightCornerRadius: 32,
        ),
      ),
    );
  }
}
