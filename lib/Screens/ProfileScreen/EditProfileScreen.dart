import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:ozone_managment/Animation/animation.dart';
import 'package:ozone_managment/Screens/ProfileScreen/profile_screen.dart';
import 'package:ozone_managment/Screens/ProfileScreen/test_img.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../LoginScreen/login_screen.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  void initState() {
    getuserid().then(_updateuserid);
    getName().then(_updatename);
    getemail().then(_updateemail);
    getuserImg().then(_updateuserImg);
    getPassword().then(_updatepassword);
      

    super.initState();


  }

  TextEditingController controllerusername;
  TextEditingController controllerEmail;
  TextEditingController controllerPassword;

  //// get  SharedPreferences userid /////
  String _userid = '';

  Future<String> getuserid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid = prefs.getString("userid");

    return userid;
  }

  void _updateuserid(String userid) {
    setState(() {
      this._userid = userid;
    });
  }
  ///////
  

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

  //// get  SharedPreferences Password /////
  String _password = '';

  Future<String> getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String password = prefs.getString("user_password");

    return password;
  }

  void _updatepassword(String password) {
    setState(() {
      this._password = password;
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


 

  @override
  
  Widget build(BuildContext context) {
controllerusername=  TextEditingController(text: _name );
    controllerEmail=  TextEditingController(text: _email );
    controllerPassword =  TextEditingController(text: _password );
   
void updateUser() {
    var url="http://192.168.1.110/api/updateuser.php";
    http.post(url,body: {
      "user_id": _userid,
      "user_name": controllerusername.text == null ? controllerusername.text == _name : controllerusername.text ,
      "user_email": controllerEmail.text == null ?  controllerEmail.text == _email: controllerEmail.text ,
      "user_password": controllerPassword.text == null ? controllerPassword.text == _email : controllerPassword.text ,
  //  if(controllerusername.text == null){
  //    controllerusername.text == _name

  //  }
     
    });
  }

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage( 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTDh6FxmYhUI0Fnem-zHXIW8dQzmCTZA7qvjkZvJRUGBPuiPiUm') ,
                         colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
                         fit: BoxFit.fill
                    )
                  ),
                ),
            ),
            Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      // color: Colors.amber,
                      height: 320,
                      child: Stack(
                        children: <Widget>[
                          Container(
                              height: 200,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: NetworkImage(
                                  _imgUrlData,
                                ),
                                fit: BoxFit.cover,
                              )),
                              child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.black.withOpacity(1),
                                        Colors.black.withOpacity(0.6),
                                      ],
                                    ),
                                  ),
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 50, right: 20, left: 20),
                                      child: FadeAnimation(
                                          1,
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                height: 35,
                                                width: 35,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: Colors.white)),
                                                child: Icon(
                                                  Icons.menu,
                                                  color: Colors.white,
                                                  size: 15,
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  children: <Widget>[
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      'الملف الشخصي',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                  height: 35,
                                                  width: 35,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          color: Colors.white)),
                                                  child: IconButton(
                                                    icon: Icon(
                                                      Icons.arrow_forward,
                                                      color: Colors.white,
                                                      size: 15,
                                                    ),
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                  )),
                                            ],
                                          )),
                                    ),
                                  ))),
                          Positioned(
                            bottom: 70,
                            right: MediaQuery.of(context).size.width / 2 - 80,
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: Colors.white, width: 6)),
                              child: Hero(
                                tag: _email,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(_imgUrlData),
                                  radius: 70,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 25,
                            width: MediaQuery.of(context).size.width,
                            child: FadeAnimation(
                              0.3,
                              Text(
                                _name,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Positioned(
                              bottom: 5,
                              width: MediaQuery.of(context).size.width,
                              child: FadeAnimation(
                                0.5,
                                Text(
                                  _email,
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(),
                SizedBox(
                  height: 20,
                ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                      TextField(
                    controller: controllerusername,
                    decoration:  InputDecoration(
                        hintText: "إسم المستخدم", labelText: "إسم المستخدم",),
                  ),
                    TextField(
                    controller: controllerEmail,
                    decoration:  InputDecoration(
                        hintText: "البريد الإلكتروني", labelText: "البريد الإلكتروني"),
                  ),
                    TextField(
                    controller: controllerPassword,
                    decoration:  InputDecoration(
                        hintText: "كلمة المرور", labelText: "كلمة المرور"),
                  ),
                  ],
                ),
              ),
                 SizedBox(
                  height: 50,
                ),
                FlatButton(
                  onPressed: () async {
                      updateUser();
                     Toast.show("تم تعديل الملف بنجاح!", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);
                   
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.remove('email');
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext ctx) => LoginScreen()));
                     Toast.show("عليك تسجيل الدخول بالبيانات المحدثة", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);

                            
                  },
                  
              
                  child: Text('حفظ التعديلات',style: TextStyle(color: Colors.white),),
                  color: Colors.green,
                ),

                           FlatButton(
                  onPressed: ()  {
                   
                            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => UploadImageDemo(

                  )));
                  },
                  
              
                  child: Text('حفظ التعديلات',style: TextStyle(color: Colors.white),),
                  color: Colors.green,
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
