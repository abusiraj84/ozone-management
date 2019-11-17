import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfle extends StatefulWidget {
  UserProfle({Key key}) : super(key: key);

  @override
  _UserProfleState createState() => _UserProfleState();
}

class _UserProfleState extends State<UserProfle> {

  @override
  void initState() {
     getName().then(_updatename);
     getemail().then(_updateemail);
     getuserImg().then(_updateuserImg);
        super.initState();
        
    
    
      }

      //// get name /////
       String _name= '';
    
      Future<String> getName() async {
         SharedPreferences prefs = await SharedPreferences.getInstance();
         String name = prefs.getString("name");
     
         return name;
    
    }
        void   _updatename(String name) {
     setState(() {
    this._name = name;
  });     
  }
  ///////


 //// get email /////
    String _email= '';
    Future<String> getemail() async {
         SharedPreferences prefs = await SharedPreferences.getInstance();
         String email = prefs.getString("email");
     
         return email;
    
    }

            void   _updateemail(String email) {
     setState(() {
    this._email = email;
  });     
  }


  //////////

 //// get _userImg /////
    String _userImg= '';

    Future<String> getuserImg() async {
         SharedPreferences prefs = await SharedPreferences.getInstance();
         String userImg = prefs.getString("userImg");
     
         return userImg;
    
    }

     void   _updateuserImg(String userImg) {
     setState(() {
    this._userImg = userImg;
  });     
  }
  ///////////////
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Title')),
      ),
      body:Container(
      child: Column(
        children: <Widget>[
          Image.network(_userImg),
          Center(child: Text(_name,style:TextStyle(fontSize: 30)),),
          Center(child: Text(_email,style:TextStyle(fontSize: 30)),),
        ],
      ),
    ),
    );
  }
}