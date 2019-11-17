import 'package:flutter_localizations/flutter_localizations.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screens/home_screen.dart';
import 'signup_screen.dart';
import './Detail.dart';
import './adddata.dart';
import 'Screens/login_screen.dart';



Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
   SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
    print(email);
  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "المدير الاداري",
    home:  email == null ? LoginScreen() : HomeScreen(),
    theme: ThemeData(
      fontFamily: 'ExpoArabic-Book',
        
    
    ),

    // عربي
localizationsDelegates: [
   // ... app-specific localization delegate[s] here
   GlobalMaterialLocalizations.delegate,
   GlobalWidgetsLocalizations.delegate,
   GlobalCupertinoLocalizations.delegate,
 ],
 supportedLocales: [
    const Locale('ar'), // English

  ],
  routes: {
    LoginScreen.id: (cotext) =>  LoginScreen(),
    SignupScreen.id: (cotext) =>  SignupScreen(),
    
  },
    
  ));
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class Home extends StatefulWidget {
  @override
  _HomeState createState() =>  _HomeState();
}

class _HomeState extends State<Home> {
  Future<List> getData() async {
    final response = await http.get("http://192.168.1.110/api/getdata.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(
        title:  Text("MY STORE"),
      ),
      floatingActionButton:  FloatingActionButton(
        child:  Icon(Icons.add),
        onPressed: ()=> Navigator.of(context).push(
           MaterialPageRoute(
            builder: (BuildContext context)=>  AddData(),
          )
        ),
      ),

      body:  FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ?  ItemList(
                  list: snapshot.data,
                )
              :  Center(
                  child:  CircularProgressIndicator(),
                );
        },
      ),

      
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return  Container(
          padding: const EdgeInsets.all(10.0),
          child:  GestureDetector(
            onTap: ()=>Navigator.of(context).push(
               MaterialPageRoute(
                builder: (BuildContext context)=>  Detail(list:list , index: i,)
              )
            ),
            child:  Card(

              child:  ListTile(
                title:  Text(list[i]['video_name']),
                leading:  Icon(Icons.video_library,color: Colors.amber,),
                subtitle:  Text("نوع المادة: : ${list[i]['vid_type_name']}"),
              ),
            ),
          ),
        );
      },
    );
  }
}


