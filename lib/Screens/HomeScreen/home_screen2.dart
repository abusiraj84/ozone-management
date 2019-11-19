import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:ozone_managment/Animation/animation.dart';
import 'package:ozone_managment/Screens/CrudScreens/detail.dart';
import 'package:ozone_managment/Screens/HomeScreen/my_custum_paint.dart';
import 'package:ozone_managment/Screens/HomeScreen/selcetor2.dart';

import 'cards_count_row.dart';

class HomeScreen2 extends StatefulWidget {
  HomeScreen2({Key key}) : super(key: key);

  @override
  _HomeScreen2State createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
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
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Container(
                    height: 220,
                    child: Stack(
                      children: <Widget>[
                        MyCustomPaint(),
                        Positioned(
                          top: 60,
                          left: 20,
                          right: 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.menu,
                                size: 25,
                                color: Color(0xffffffff),
                              ),
                              Spacer(),
                              Text(
                                "المتابعة",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xffffffff),
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.person,
                                size: 25,
                                color: Color(0xffffffff),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.125,
                          left: (MediaQuery.of(context).size.width -
                                  MediaQuery.of(context).size.width * 0.9) /
                              2,
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
                                    ? CardsCountRow(
                                        list: snapshot.data,
                                      )
                                    : Center(
                                        child: CircularProgressIndicator(),
                                      );
                              },
                            ),
                          ),
                        ),
                      ],
                    )),
                Container(
                  height: MediaQuery.of(context).size.height * .1,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                          top: 20,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 35,
                            child: Selector2(selectors: ["الجميع","مواد مقترحة","قيد المونتاج","جاهز للنشر","تم النشر"]),
                          )),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
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
                )
              ],
            ),
          ),
        ),
      ),
    );
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
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 0),
                child: Card(
                  elevation: 1,
                  child: ClipPath(
                    child: Container(
                        height: 200,
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