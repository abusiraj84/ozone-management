import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:toast/toast.dart';

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  //for _videoType dropdown
  String _videoType;

  final String url = "http://192.168.1.110/api/getvideodata.php";

  List data = List(); //edited line

  Future<String> getVideoData() async {
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      data = resBody;
    });

    print(resBody);

    return "Sucess";
  }

  @override
  void initState() {
    super.initState();
    this.getVideoData();
    this.getDomainData();
  }

/////


//for domain dropdown

  String _videoDomain;

  final String domainUrl = "http://192.168.1.110/api/getdomaindata.php";

  List dataDomain = List(); //edited line

  Future<String> getDomainData() async {
    var res = await http.get(Uri.encodeFull(domainUrl),
        headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      dataDomain = resBody;
    });

    print(resBody);

    return "Sucess";
  }

/////

  TextEditingController controllervideoname = TextEditingController();

  var now = new DateTime.now();

  void addData() {
    var url = "http://192.168.1.110/api/adddata.php";

    http.post(url, body: {
      "video_name": controllervideoname.text,
      "video_type": _videoType,
      "video_domain": _videoDomain,
      "video_status": "1",
      "video_date": new DateTime.now().toString(),
      "video_user_id": "1"
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("إضافة مهمة"),
        backgroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                TextField(
                  controller: controllervideoname,
                  decoration: InputDecoration(
                      hintText: "المادة المقترحة", labelText: "المادة المقترحة"),
                ),
                  SizedBox(
                  height: 50,
                ),
                DropdownButton(
                  isExpanded: true,
                  hint: Text('اختر نوع المادة'),
                  items: data.map((item) {
                    return DropdownMenuItem(
                      child: Text(item['vid_type_name']),
                      value: item['vid_type_id'].toString(),
                    );
                  }).toList(),
                  onChanged: (newVal) {
                    setState(() {
                      _videoType = newVal;
                    });
                  },
                  value: _videoType,
                ),
                  SizedBox(
                  height: 50,
                ),
                DropdownButton(
                  isExpanded: true,
                   hint: Text('اختر المنصة'),
                  items: dataDomain.map((item) {
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
               
                Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
                RaisedButton(
                  child: Text("أضف مهمة" ,style: TextStyle(color: Colors.white),),
                  color: Colors.blueAccent,
                  onPressed: () {
                    addData();
                     Toast.show("تم إضافة مهمة بنجاح!", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);
                    Navigator.pop(context);
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
