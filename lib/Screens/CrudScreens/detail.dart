import 'package:flutter/material.dart';
import 'package:ozone_managment/Screens/HomeScreen/home_screen.dart';
import 'package:ozone_managment/Screens/HomeScreen/home_screen_old.dart';
import 'package:toast/toast.dart';
import './editdata.dart';
import 'package:http/http.dart' as http;



class Detail extends StatefulWidget {
  final List list;
  final int index;
  final int domainid;
  Detail({this.index, this.list, this.domainid});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  void deleteData() {
    var url = "http://192.168.1.110/api/deleteData.php";
    http.post(url, body: {'video_id': widget.list[widget.index]['video_id']});
  }

  void confirm() {
    AlertDialog alertDialog = AlertDialog(
      content: Text(
          "هل أنت متأكد من حذفك للمهمة  '${widget.list[widget.index]['video_name']}'"),
      actions: <Widget>[
        RaisedButton(
          child: Text(
            "نعم بالتأكيد"
            ,style: TextStyle(color: Colors.white),
          ),
          color: Colors.red,
          onPressed: () {
            deleteData();
            Toast.show("تم حذف المهمة بنجاح!", context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => HomeScreen(),
              ),
            );
          },
        ),
        RaisedButton(
          child: Text("ألغي",style: TextStyle(color: Colors.white),),
          color: Colors.green,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(context: context, builder: (_) => alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.list[widget.index]['video_name']}",
          style: TextStyle(color: Colors.blue, fontSize: 15),
        ),
        iconTheme: IconThemeData(color: Colors.blue),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                    ),

                  

                    ListTile(
                      leading: CircleAvatar(
                        child:Text("${widget.list[widget.index]['video_id']}"),),
                      title: Text(
                        widget.list[widget.index]['video_name'],
                      ),
                      subtitle: Row(
                        children: <Widget>[
                          Chip(
                            label:
                                Text("المنصة: ${widget.list[widget.index]['domain_name']}"),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Chip(
                            label: Text("الحالة: ${widget.list[widget.index]['vid_status_name']}"),
                          ),
                        ],
                      ),
                    ),
                    //  Text(widget.list[widget.index]['domain_id'].toString(), style:  TextStyle(fontSize: 20.0),),

                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                    ),

                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        RaisedButton(
                          child: Text(
                            "تعديل",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.green,
                          onPressed: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => EditData(
                              list: widget.list,
                              index: widget.index,
                            ),
                          )),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        RaisedButton(
                          child: Text(
                            "حذف",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.red,
                          onPressed: () => confirm(),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
