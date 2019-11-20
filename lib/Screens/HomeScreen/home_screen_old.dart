import 'package:flutter/material.dart';
import 'package:ozone_managment/Screens/MenuScreen/drawer_menu.dart';



import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:ozone_managment/Animation/animation.dart';

import 'package:ozone_managment/Screens/CrudScreens/detail.dart';
import 'package:ozone_managment/Screens/MenuScreen/my_app_bar.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  Future<List> getData() async {
    final response = await http.get("http://192.168.1.110/api/getdata.php");
    return json.decode(response.body);
  }

  Future<List> getvideocountData() async {
    final response =
        await http.get("http://192.168.1.110/api/getdatacount.php");
    return json.decode(response.body);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Menu Items // هنا كلاس عناصر المنيو
      drawer: DrawerMenu(),
      ////
      
      backgroundColor: Color(0xfff6f6f6),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: ClippingClass(),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                        colors: [
                      Color(0xff4b7ef6),
                      Color(0xff2559e7),
                    ])),
              ),
            ),
          ),

          //My AppBar // هنا كلاس الأب بار
            MYAppBar(),
          ///
        
          Positioned(
            top: MediaQuery.of(context).size.height * 0.125,
            left: (MediaQuery.of(context).size.width - MediaQuery.of(context).size.width * 0.9) / 2,
            
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      spreadRadius: 0.5,
                      blurRadius: 20)
                ],
              ),
              child: FutureBuilder<List>(
                future: getvideocountData(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);

                  return snapshot.hasData
                      ? CardsContRow(
                          list: snapshot.data,
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        );
                },
              ),
            ),
          ),
          Positioned(
            top:  MediaQuery.of(context).size.height *0.24,
            left: 0,
            right: 0,
            bottom: null,
            height:  MediaQuery.of(context).size.height,
                      child: Container(
             
              width: 500,
              child: Flex(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: FutureBuilder<List>(
                      future: getData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) print(snapshot.error);

                        return snapshot.hasData
                            ? MyCard(
                                list: snapshot.data,
                              )
                            : Center(
                                child: CircularProgressIndicator(),
                              );
                      },
                    ),
                  ),
                ],
                direction: Axis.vertical,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardsContRow extends StatelessWidget {
  final List list;
  CardsContRow({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 1,
        itemBuilder: (context, i) {
          return Container(
            width: MediaQuery.of(context).size.width - 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(list[i]['A'],
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18)),
                    SizedBox(
                      height: 8,
                    ),
                    Text('مواد مقترحة',
                        style: TextStyle(
                            color: Color(0xff2559e7),
                            fontWeight: FontWeight.w200,
                            fontSize: 14)),
                  ],
                ),
                SizedBox(width: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(list[i]['B'],
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18)),
                    SizedBox(
                      height: 8,
                    ),
                    Text('قيد التحرير',
                        style: TextStyle(
                            color: Color(0xff2559e7),
                            fontWeight: FontWeight.w200,
                            fontSize: 14)),
                  ],
                ),
                SizedBox(width: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(list[i]['C'],
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18)),
                    SizedBox(
                      height: 8,
                    ),
                    Text('قيد المونتاج',
                        style: TextStyle(
                            color: Color(0xff2559e7),
                            fontWeight: FontWeight.w200,
                            fontSize: 14)),
                  ],
                ),
                SizedBox(width: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(list[i]['D'],
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18)),
                    SizedBox(
                      height: 8,
                    ),
                    Text('جاهز للنشر',
                        style: TextStyle(
                            color: Color(0xff2559e7),
                            fontWeight: FontWeight.w200,
                            fontSize: 14)),
                  ],
                ),
              ],
            ),
          );
        });
  }
}

class MyCard extends StatelessWidget {
  final List list;
  MyCard({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => Detail(
                    list: list,
                    index: i,
                  ))),
          child: FadeAnimation(
            1,
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 3),
                child: Card(
                  elevation: 0.1,
                  child: ClipPath(
                    child: Container(
                        height: 165,
                        decoration: BoxDecoration(
                            border: Border(
                                left: BorderSide(
                                    color: Color(
                                        int.parse(list[i]['vid_status_color'])),
                                    width: 4))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Chip(
                                    label: Text(
                                      list[i]['vid_status_name'],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    backgroundColor: Color(
                                        int.parse(list[i]['vid_status_color'])),
                                  ),
                                  Spacer(),
                                  CircleAvatar(
                                    radius: 15,
                                    backgroundImage: NetworkImage(
                                      'https://scontent.fist7-2.fna.fbcdn.net/v/t1.0-9/39467861_1974066275972645_1391056009283239936_n.jpg?_nc_cat=102&_nc_oc=AQn0_k7guSVu5cw92Ve6QxebW-HJXEqTcI3A3_8LCmDdESDE0k6yElgiulhjcoKIzOY&_nc_ht=scontent.fist7-2.fna&oh=6dc9730603242d7344d6100b85b28240&oe=5E4F7EAC',
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CircleAvatar(
                                    radius: 15,
                                    backgroundImage: NetworkImage(
                                      'https://scontent.fist7-2.fna.fbcdn.net/v/t1.0-0/p480x480/44842686_2023795604367980_4798176187069235200_o.jpg?_nc_cat=101&_nc_oc=AQn-QMV8dSq06Fig_yIgWb7YXNcwuhDOoLPXp-f7uuiF2sGDgYAeh52Y5VFMFSxsAx4&_nc_ht=scontent.fist7-2.fna&oh=65b52f9d3be10e07fe29cea15b983c87&oe=5E421B18',
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CircleAvatar(
                                    radius: 15,
                                    backgroundImage: NetworkImage(
                                      'https://scontent.fist7-1.fna.fbcdn.net/v/t1.0-9/50110061_2134320890121979_165856286758404096_n.jpg?_nc_cat=109&_nc_oc=AQmpoeIeiK9cghLmhQm3P_QCHuBs9RRWpN2hLFyq2dy9L_AP2qeSxCEbuO0IVx9Xvhs&_nc_ht=scontent.fist7-1.fna&oh=e164c4da4bd46648520a27f8bada1b27&oe=5E55E808',
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    width: double.infinity,
                                    child: Text(
                                      list[i]['video_name'],
                                      style: TextStyle(),
                                      textAlign: TextAlign.start,
                                    )),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Chip(
                                    label: Text(
                                      list[i]['video_date'],
                                      style: TextStyle(
                                          fontSize: 9,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    backgroundColor: Colors.grey[200],
                                  ),
                                  Spacer(),
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundImage: NetworkImage(
                                      list[i]['domain_image_url'],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                    clipper: ShapeBorderClipper(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4))),
                  ),
                )),
          ),
        );
      },
    );
  }
}

class ClippingClass extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 10);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(size.width - (size.width / 4), size.height,
        size.width, size.height - 10);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => false;
}
