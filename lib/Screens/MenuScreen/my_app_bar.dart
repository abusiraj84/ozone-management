import 'package:flutter/material.dart';
import 'package:ozone_managment/Screens/CrudScreens/adddata.dart';

class MYAppBar extends StatelessWidget {
  const MYAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return           AppBar(
            title: Text('إدارة آرام',
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20)),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: GestureDetector(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.add,
                        color: Colors.yellow,
                        size: 25,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.filter_list,
                        color: Colors.yellow,
                        size: 25,
                      ),
                    ],
                  ),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => AddData(),
                  )),
                ),
              )
            ],
          );
  }
}