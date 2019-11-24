import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:ozone_managment/Screens/LoginScreen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
 
class UploadImageDemo extends StatefulWidget {
  UploadImageDemo() : super();
 
  final String title = "Upload Image Demo";
 
  @override
  UploadImageDemoState createState() => UploadImageDemoState();

  
}
 
class UploadImageDemoState extends State<UploadImageDemo> {
  //
    void initState() {
    getuserid().then(_updateuserid);

      

    super.initState();

  }

  static final String uploadEndPoint =
      'http://192.168.1.110/api/images/upload_image.php';
  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';
 

  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
    setStatus('');
  }
 
  setStatus(String message) {
    setState(() {
      status = message;
    });
  }
 
  startUpload() {
    setStatus('Uploading Image...');
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }
    String fileName = tmpFile.path.split('/').last;
    upload(fileName);
  }
 
  upload(String fileName) {
    http.post(uploadEndPoint, body: {
      "image": base64Image,
      "name": fileName,
    }).then((result) async {
      setStatus(result.statusCode == 200 ? result.body : errMessage);
          var url="http://192.168.1.110/api/updateimage.php";
    http.post(url,body: {
      "user_id": _userid,
      "user_image": fileName,
    
     
    });

    
    
    }).catchError((error) {
      setStatus(error);
    });
  }
 
//  void updateUser() {

//   }
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
  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Flexible(
            child: Image.file(
              snapshot.data,
              fit: BoxFit.fill,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("تغيير صورة الملف الشخصي"),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            OutlineButton(
              onPressed: chooseImage,
              child: Text('اختر الصورة'),
            ),
            SizedBox(
              height: 20.0,
            ),
            showImage(),
            SizedBox(
              height: 20.0,
            ),
            OutlineButton(
              onPressed: startUpload,
              child: Text('ارفع الصورة'),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              status,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w500,
                fontSize: 20.0,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
             FlatButton(
                  onPressed: () async {
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
          ],
        ),
      ),
    );
  }
}
