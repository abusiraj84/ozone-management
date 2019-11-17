import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ozone_managment/Screens/CrudScreens/adddata.dart';
import 'package:ozone_managment/Screens/LoginScreen/login_screen.dart';
import 'package:ozone_managment/Screens/MenuScreen/user_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({Key key}) : super(key: key);

  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
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
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
      );
  }
}