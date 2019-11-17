import 'package:flutter/material.dart';
import 'package:ozone_managment/Screens/HomeScreen/home_screen.dart';
import 'package:ozone_managment/Screens/LoginScreen/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:toast/toast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;




class LoginScreen extends StatefulWidget {
  static final String id = "login_screen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  String msg = '';
  String username = '';

  Future<List> _login() async {
    final response =
        await http.post("http://192.168.1.110/api/login.php", body: {
      "user_email": user.text,
      "user_password": pass.text,
    });

    var datauser = json.decode(response.body);

    if (datauser.length == 0) {
      Toast.show("اكتب كلمة عدل يا شرمت", context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
          backgroundColor: Colors.red);
    } else {
      if (datauser[0]['user_type_id'] == '1') {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('userid', datauser[0]['user_id']);
        prefs.setString('name', datauser[0]['user_name']);
        prefs.setString('email', datauser[0]['user_email']);
        prefs.setString('userImg', datauser[0]['user_image']);
        prefs.setString('usertype', datauser[0]['user_type_id']);

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext ctx) => HomeScreen()));

        Toast.show("hello", context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.blue);
      } else if (datauser[0]['user_type_id'] == '1') {
        Navigator.pushReplacementNamed(context, '/bodegaPage');
      }

      setState(() {
        username = datauser[0]['username'];
      });
    }

    return datauser;
  }

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();

    String _email, _password;

    _submit() {
      if (_formkey.currentState.validate()) {
        _formkey.currentState.save();

        //Login the user
        _login();
      }
    }

    return Scaffold(
        backgroundColor: Color(0xff4b7ef6),
        body: ListView(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://images.pexels.com/photos/273222/pexels-photo-273222.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                          fit: BoxFit.cover),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomRight,
                              colors: [
                            Color(0xff4b7ef6).withOpacity(1),
                            Color(0xff2559e7).withOpacity(0.3),
                          ])),
                    ),
                  ),
                  SizedBox(
                    height: 400,
                    child: Card(
                      color: Colors.white,
                      child: Container(
                        width: 350,
                        height: 300,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: _formkey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "برنامج المتابعة الإدارية",
                                  style: TextStyle(
                                      color: Color(0xff4b7ef6), fontSize: 25),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: user,
                                  decoration: InputDecoration(
                                      labelText: 'اسم المستخدم'),
                                  style: TextStyle(fontSize: 14),
                                  validator: (input) => !input.contains('@')
                                      ? 'من فضلك أدخل بريد صالح'
                                      : null,
                                  onSaved: (input) => _email = input,
                                ),
                                TextFormField(
                                  controller: pass,
                                  obscureText: true,
                                  decoration:
                                      InputDecoration(labelText: 'كلمة المرور'),
                                  style: TextStyle(fontSize: 14),
                                  validator: (input) => input.length < 6
                                      ? 'يجب أن تكون كلمة المرور على الأقل 6 أحرف'
                                      : null,
                                  onSaved: (input) => _password = input,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  width: 250,
                                  child: FlatButton(
                                    color: Color(0xff4b7ef6),
                                    textColor: Colors.white,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          'تسجيل الدخول',
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                    onPressed: () async => _submit(),
                                  ),
                                ),
                                Container(
                                  width: 250,
                                  child: FlatButton(
                                    color: Color(0xff000000),
                                    textColor: Colors.white,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          'عضوية جديدة',
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                    onPressed: () => Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          SignupScreen(),
                                    )),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}

//
