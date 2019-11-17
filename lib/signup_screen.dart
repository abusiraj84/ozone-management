import 'package:flutter/material.dart';
import 'package:toast/toast.dart';


import 'Screens/home_screen.dart';

class SignupScreen extends StatefulWidget {
  static final String id = "signup_screen";
  const SignupScreen({Key key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formkey = GlobalKey<FormState>();
    String _email, _password,_username;
    _submit() {
      if (_formkey.currentState.validate()) {
        _formkey.currentState.save();
        print(_email);
        print(_password);
        print(_username);
        //Login the user
        Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => HomeScreen(),
        ));
         Toast.show(" تم الإشتراك بنجاح أهلا بك يا $_username", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM,backgroundColor: Colors.blue);
      }
    }
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'عضوية جديدة',
          style: TextStyle(color: Colors.blue),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.blue),
      ),
      body: ListView(
        children: <Widget>[
          Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "برنامج المتابعة الإدارية",
                    style: TextStyle(color: Color(0xff4b7ef6), fontSize: 25),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'اسم المستخدم'),
                    style: TextStyle(fontSize: 14),
                    validator: (input) =>
                       input.trim().isEmpty 
                        ? 'يجب أن يكون إسم المستخدم أكثر من حرفين'
                        : null,
                    onSaved: (input) => _username = input,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'البريد الإلكتروني'),
                    style: TextStyle(fontSize: 14),
                    validator: (input) =>
                        !input.contains('@') ? 'من فضلك أدخل بريد صالح' : null,
                    onSaved: (input) => _email = input,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'كلمة المرور'),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'اشترك اللآن',
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                      onPressed: () => _submit(),
                    ),
                  ),
                  Container(
                    width: 250,
                    child: FlatButton(
                      color: Color(0xff000000),
                      textColor: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'العودة لتسجيل الدخول',
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
