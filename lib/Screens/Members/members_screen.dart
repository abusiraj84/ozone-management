import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:ozone_managment/Animation/animation.dart';
import 'package:ozone_managment/Screens/CrudScreens/detail.dart';

class MembersScreen extends StatefulWidget {
  MembersScreen({Key key}) : super(key: key);

  @override
  _MembersScreenState createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  Future<List> getUser() async {
    final response = await http.get("http://192.168.1.110/api/getuser.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('جميع الأعضاء'),
        backgroundColor: Colors.black87,
        leading: InkWell(
            onTap: (){
              Navigator.of(context).pop();
            },
                      child: Padding(
              padding: EdgeInsets.only(right: 20),
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white)),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 15,
                ),
              ),
            ),
          ),
      ),
      body: FutureBuilder<List>(
        future: getUser(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? MemberList(
                  list: snapshot.data,
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class MemberList extends StatelessWidget {
  final List list;
  MemberList({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 20),
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return Column(
          children: <Widget>[
            InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Detail(
                        list: list,
                        index: i,
                      ))),
              child: FadeAnimation(
                1,
                Padding(
                  padding:
                      const EdgeInsets.only(left: 22, right: 22, bottom: 10),
                  child: ListTile(
                    title: Text(
                      list[i]['user_name'],
                    ),
                    subtitle: Text(
                      list[i]['user_email'],
                    ),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'http://192.168.1.110/api/images/' +
                              list[i]['user_image']),
                    ),
                    trailing: Chip(label: Text(list[i]['user_type_name'])),
                  ),
                ),
              ),
            ),
            Divider()
          ],
        );
      },
    );
  }
}
