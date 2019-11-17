import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:ozone_managment/Animation/animation.dart';

import 'package:ozone_managment/Screens/CrudScreens/adddata.dart';
import 'package:ozone_managment/Screens/CrudScreens/detail.dart';
import 'package:ozone_managment/Screens/LoginScreen/login_screen.dart';
import 'package:ozone_managment/Screens/MenuScreen/user_profile.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    getName().then(_updatename);
    getemail().then(_updateemail);
    getuserImg().then(_updateuserImg);
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

  Future<String> getuserImg() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userImg = prefs.getString("userImg");

    return userImg;
  }

  void _updateuserImg(String userImg) {
    setState(() {
      this._userImg = userImg;
    });
  }
  ///////////////

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
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    right: 25
                  ),
                  child: CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(
                      _userImg,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Column(
                    children: <Widget>[
                      Text(_name,
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(_email,
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w200,
                              fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              color: Colors.grey[400],
              indent: 20,
              endIndent: 20,
            ),
            ListTile(
              leading: Icon(Icons.person_outline),
              title: Text("بروفايلي"),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => UserProfle(),
              )),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("الرئيسية"),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.view_module),
              title: Text("منصات"),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("الإعدادات"),
            ),
            Divider(),
            ListTile(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => AddData(),
              )),
              leading: Icon(Icons.info),
              title: Text("مساعدة"),
            ),
            Divider(),
            ListTile(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('email');
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext ctx) => LoginScreen()));
              },
              leading: Icon(Icons.exit_to_app),
              title: Text("تسجيل خروج"),
            ),
            Divider(),
          ],
        ),
      ),
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
          AppBar(
            title: Text('إدارة آرام',
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20)),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: GestureDetector(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.add,
                        color: Colors.yellow,
                        size: 25,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.filter_list,
                        color: Colors.yellow,
                        size: 25,
                      ),
                    ],
                  ),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => AddData(),
                  )),
                ),
              )
            ],
          ),
          Positioned(
            top: 80,
            left: (MediaQuery.of(context).size.width -
                    MediaQuery.of(context).size.width * 0.9) /
                2,
            child: Container(
              height: 100,
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 500,
              width: 500,
              child: Flex(
                children: <Widget>[
                  Expanded(
                    flex: 1,
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
