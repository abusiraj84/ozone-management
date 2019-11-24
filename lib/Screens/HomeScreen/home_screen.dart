import 'dart:convert';
import 'dart:async';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:ozone_managment/Animation/animation.dart';
import 'package:ozone_managment/Screens/CrudScreens/adddata.dart';
import 'package:ozone_managment/Screens/CrudScreens/detail.dart';
import 'package:ozone_managment/Screens/HomeScreen/my_custum_paint.dart';
import 'package:ozone_managment/Screens/ProfileScreen/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cards_count_row.dart';

class HomeScreen2 extends StatefulWidget {
  HomeScreen2({Key key}) : super(key: key);

  @override
  _HomeScreen2State createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2>
    with TickerProviderStateMixin {
  AnimationController _scaleController;

  int vidStatID = 0;

  void initState() {
    getName().then(_updatename);
    getemail().then(_updateemail);
    getuserImg().then(_updateuserImg);
    _scaleController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));

    super.initState();
  }

  //// get  SharedPreferences NAME /////
  String _name = '';

  Future<String> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString("name");

    return name;
  }

  void _updatename(String name) {
    setState(() {
      this._name = name;
    });
  }
  ///////

  //// get SharedPreferences EMAIL /////
  String _email = '';
  Future<String> getemail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString("email");

    return email;
  }

  void _updateemail(String email) {
    setState(() {
      this._email = email;
    });
  }

  //////////

  //// get IMAGE /////
  String _userImg = '';
  String _imgUrlData ='';

  Future<String> getuserImg() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userImg = prefs.getString("userImg");

    return userImg;
  }

  void _updateuserImg(String userImg) {
    setState(() {
      this._userImg = userImg;
      this._imgUrlData = 'http://192.168.1.110/api/images/' +userImg;
      print(_imgUrlData);
    });
  }
  ///////////////

  Future<List> getData() async {
    final response = await http.get("http://192.168.1.110/api/getdata.php");
    return json.decode(response.body);
  }

  Future<List> getDataViaID(int id) async {
    final response = await http.get(
        "http://192.168.1.110/api/getdataviaid.php?video_status=" +
            id.toString());

    return json.decode(response.body);
  }

  Future<List> getvideocountData() async {
    final response =
        await http.get("http://192.168.1.110/api/getdatacount.php");
    return json.decode(response.body);
  }

  getVideoStatus(int vidStatusId) {
    if (vidStatusId != 0) {
      return getDataViaID(vidStatusId);
    } else {
      return getData();
    }
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);

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
                    height: 210,
                    child: Stack(
                      children: <Widget>[
                        MyCustomPaint(),
                        Positioned(
                          top: 50,
                          left: 20,
                          right: 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              InkWell(
                                                              child: Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white)),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                                  return AddData();
                                  }));
                                },
                              ),
                              Expanded(
                                child: Text(
                                  "WorkFollow",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xffffffff),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              InkWell(
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.white, width: 2)),
                                  child: Hero(
                                    tag: _email,
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        _imgUrlData,
                                      ),
                                      radius: 20,
                                    ),
                                  ),
                                ),
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            ProfileScreen())),
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height / 7.6,
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
                              height: 50,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Chip(
                                        backgroundColor: vidStatID == 0
                                            ? Colors.blue
                                            : Colors.grey.shade200,
                                        label: InkWell(
                                          child: Text("الجميع",style: TextStyle(color: vidStatID == 0 ?Colors.white:Colors.black),),
                                          onTap: () {
                                            setState(() {
                                              vidStatID = 0;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child:  Chip(
                                        backgroundColor: vidStatID == 1
                                            ? Color(0xff4b6584)
                                            : Colors.grey.shade200,
                                        label:  InkWell(
                                          child: Text("مقترح",style: TextStyle(color: vidStatID == 1 ?Colors.white:Colors.black),),
                                          onTap: () {
                                            setState(() {
                                              vidStatID = 1;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Chip(
                                        backgroundColor: vidStatID == 2
                                            ? Color(0xfffa8231)
                                            : Colors.grey.shade200,
                                        label: InkWell(
                                          child: Text("قيد التحرير",style: TextStyle(color: vidStatID == 2 ?Colors.white:Colors.black),),
                                          onTap: () {
                                            setState(() {
                                              vidStatID = 2;
                                             
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child:  Chip(
                                        backgroundColor: vidStatID == 3
                                            ? Color(0xffa55eea)
                                            : Colors.grey.shade200,
                                        label:  InkWell(
                                          child: Text("قيد المراجعة",style: TextStyle(color: vidStatID == 3 ?Colors.white:Colors.black),),
                                          onTap: () {
                                            setState(() {
                                              vidStatID = 3;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child:  Chip(
                                        backgroundColor: vidStatID == 4
                                            ? Color(0xff45aaf2)
                                            : Colors.grey.shade200,
                                        label:  InkWell(
                                          child: Text("جاهز للمونتاج",style: TextStyle(color: vidStatID == 4 ?Colors.white:Colors.black),),
                                          onTap: () {
                                            setState(() {
                                              vidStatID = 4;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child:  Chip(
                                        backgroundColor: vidStatID == 5
                                            ? Color(0xfffed330)
                                            : Colors.grey.shade200,
                                        label:  InkWell(
                                          child: Text("قيد المونتاج",style: TextStyle(color: vidStatID == 5 ?Colors.white:Colors.black),),
                                          onTap: () {
                                            setState(() {
                                              vidStatID = 5;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Chip(
                                        backgroundColor: vidStatID == 6
                                            ? Color(0xffeb3b5a)
                                            : Colors.grey.shade200,
                                        label:  InkWell(
                                          child: Text("جاهز للنشر",style: TextStyle(color: vidStatID == 6 ?Colors.white:Colors.black),),
                                          onTap: () {
                                            setState(() {
                                              vidStatID = 6;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child:  Chip(
                                        backgroundColor: vidStatID ==7
                                            ? Color(0xff20bf6b)
                                            : Colors.grey.shade200,
                                        label:  InkWell(
                                          child: Text("تم النشر",style: TextStyle(color: vidStatID == 7 ?Colors.white:Colors.black),),
                                          onTap: () {
                                            setState(() {
                                              vidStatID = 7;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ))),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 1.7,
                  child: Container(
                    width: 500,
                    child: Flex(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: FutureBuilder<List>(
                            future: getVideoStatus(vidStatID),
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
      padding: EdgeInsets.only(top: 0),
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
                padding: const EdgeInsets.only(left: 22, right: 22, bottom: 10),
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
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      width: double.infinity,
                                      child: Text(
                                        list[i]['video_name'],
                                        style: TextStyle(),
                                        textAlign: TextAlign.start,
                                      )),
                                ),
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
