import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ozone_managment/Screens/HomeScreen/home_screen.dart';
import 'package:ozone_managment/Screens/HomeScreen/home_screen_old.dart';
import 'package:toast/toast.dart';



class EditData extends StatefulWidget {
  final List list;
  final int index;

  EditData({this.list, this.index});

  @override
  _EditDataState createState() =>  _EditDataState();
}

class _EditDataState extends State<EditData> {
//for videoType dropdown
  String videoType;

  final String url = "http://192.168.1.110/api/getvideodata.php";

  List videoTypeData = List(); //edited line

  Future<String> getVideoData() async {
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      videoTypeData = resBody;
    });

    print(resBody);

    return "Sucess";
  }

  @override
  void initState() {
    super.initState();
    this.getVideoData();
    this.getDomainData();
    this.getvideostatusdata();
    controllervideoname=  TextEditingController(text: widget.list[widget.index]['video_name'] );
     videoType = widget.list[widget.index]['vid_type_id'] ;
     _videoDomain =widget.list[widget.index]['domain_id'];
     _videostatus = widget.list[widget.index]['vid_status_id'] ;

print(widget.list[widget.index]['domain_id']);

  }

/////


//for domain dropdown

  String _videoDomain;

  final String domainUrl = "http://192.168.1.110/api/getdomaindata.php";

  List videodomain = List(); //edited line

  Future<String> getDomainData() async {
    var res = await http.get(Uri.encodeFull(domainUrl),
        headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      videodomain = resBody;
    });

    print(resBody);

    return "Sucess";
  }

/////

//for domain dropdown

  String _videostatus;

  final String videostatusURL = "http://192.168.1.110/api/getvideostatus.php";

  List videostatusdata = List(); //edited line

  Future<String> getvideostatusdata() async {
    var res = await http.get(Uri.encodeFull(videostatusURL),
        headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      videostatusdata = resBody;
    });

    print(resBody);

    return "Sucess";
  }

/////



  TextEditingController controllervideoname;
  


  void editData() {
    var url="http://192.168.1.110/api/editdata.php";
    http.post(url,body: {
      "video_id": widget.list[widget.index]['video_id'],
      "video_name": controllervideoname.text,
      "video_type": videoType,
      "video_domain": _videoDomain,
      "video_status": _videostatus,
      "video_date": new DateTime.now().toString(),
      "video_user_id": "1"
    });
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(
        title:  Text("تعديل مهمة",style: TextStyle(color: Colors.blue),),
       iconTheme: IconThemeData(color: Colors.blue),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
             Column(
              children: <Widget>[
                 TextField(
                  controller: controllervideoname,
                  decoration:  InputDecoration(
                      hintText: "عنوان المادة", labelText: "عنوان المادة"),
                ),
                 SizedBox(
                  height: 50,
                ),
                DropdownButton(
                   isExpanded: true,
                  hint: Text('اختر نوع المادة'),
                  items: videoTypeData.map((item) {
                    return DropdownMenuItem(
                      child: Text(item['vid_type_name']),
                      value: item['vid_type_id'].toString(),
                    );
                  }).toList(),
                  onChanged: (newVal) {
                    setState(() {
                      videoType = newVal;
                    });
                  },
                  value: videoType,
                ),
                SizedBox(
                  height: 50,
                ),
                DropdownButton(
                   isExpanded: true,
                   hint: Text('اختر المنصة'),
                  items: videodomain.map((item) {
                    return DropdownMenuItem(
                      child: Text(item['domain_name']),
                      value: item['domain_id'].toString(),
                    );
                  }).toList(),
                  onChanged: (newVal) {
                    setState(() {
                      _videoDomain = newVal;
                    });
                  },
                  value: _videoDomain,
                ), 
                 SizedBox(
                  height: 50,
                ),
                    DropdownButton(
                     isExpanded: true,
                   hint: Text('اختر الحالة'),
                  items: videostatusdata.map((item) {
                    return DropdownMenuItem(
                      child: Text(item['vid_status_name']),
                      value: item['vid_status_id'].toString(),
                    );
                  }).toList(),
                  onChanged: (newVal) {
                    setState(() {
                      _videostatus = newVal;
                    });
                  },
                  value: _videostatus,
                ),
                 
                 Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
                 RaisedButton(
                  child:  Text("تعديل والعودة",style: TextStyle(color: Colors.white),),
                  color: Colors.blueAccent,
                  onPressed: () {
                    editData();
                     Toast.show("تم تعديل المهمة بنجاح!", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);
                    Navigator.of(context).push(
                       MaterialPageRoute(
                        builder: (BuildContext context)=>HomeScreen(),
                      )
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
