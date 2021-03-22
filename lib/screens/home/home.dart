import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hygieia/services/auth.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{
  final autoSizeGroup = AutoSizeGroup();
  final AuthService _auth = AuthService();
  var _bottomNavIndex = 0;
  AnimationController _animationController;

  Animation<double> animation;

  CurvedAnimation curve;

  final doughnutData = <_ChartData>[
    _ChartData(xData: "Recyclable",yData: 45, text:"recyclable"),
    _ChartData(xData: "Non-Recyclable",yData: 15, text:"non-recyclable"),
    _ChartData(xData: "Hazardous Waste",yData: 10, text:"hazard"),
    _ChartData(xData: "Biodegradable",yData: 5, text:"bio"),
    _ChartData(xData: "Organic",yData: 15, text:"organic"),
  ];

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
        body: SingleChildScrollView(
          child: Container(
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
                SizedBox(height: 5),
                Card(
                  elevation: 5,
                  shadowColor: Colors.grey[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SizedBox(
                    width: 1000,
                    height: 300,
                    child: Column(
                      children:[
                        Expanded(
                            child: SfCircularChart(
                                legend: Legend(isVisible: true),
                                series: <DoughnutSeries<_ChartData, String>>[
                                  DoughnutSeries<_ChartData, String>(
                                      explode: true,
                                      explodeIndex: 1,
                                      dataSource: doughnutData,
                                      xValueMapper: (_ChartData data, _) => data.xData,
                                      yValueMapper: (_ChartData data, _) => data.yData,
                                      dataLabelMapper: (_ChartData data, _) => data.text,
                                      dataLabelSettings: DataLabelSettings(isVisible: false)),
                                ]
                            )
                        ),
                        Divider(
                          height: 25,
                          thickness: 2,
                          indent: 50,
                          endIndent: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:[
                            SizedBox(
                              height: 75,
                              width: 180,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(25, 7, 7, 7),
                                child: AutoSizeText(
                                  'You have reduced 16 years if composting by utilizing, 45% recyclable items weekly. \nGood job!',
                                  maxLines: 5,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w400,
                                    color: HexColor("707070"),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 75,
                              width: 100,
                              child: Container(
                                child: Icon(
                                  FontAwesomeIcons.recycle,
                                  color: Colors.green[600],
                                  size: 35,
                                ),
                              ),
                            ),
                          ]
                        ),
                        SizedBox(height:15),
                      ]
                    ),
                  ),
                ),
                SizedBox(height:15),
                TextButton.icon(
                    onPressed: () async{
                      await _auth.signOut();
                    },
                    icon: Icon(Icons.person),
                    label: Text("Logout")),
              ],
            ),
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

class _ChartData{
  final String xData;
  final num yData;
  final String text;
  _ChartData({this.xData,this.yData,this.text});
}