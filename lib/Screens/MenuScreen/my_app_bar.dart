import 'package:flutter/material.dart';
import 'package:ozone_managment/Screens/CrudScreens/adddata.dart';

class MYAppBar extends StatefulWidget {
  const MYAppBar({Key key}) : super(key: key);

  @override
  _MYAppBarState createState() => _MYAppBarState();
}

class _MYAppBarState extends State<MYAppBar> {
  @override
  Widget build(BuildContext context) {
    return           AppBar(
            title: Text('المدير الإداري',
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20)),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                    children: <Widget>[
                      InkWell(
                                              child: Icon(
                          Icons.add,
                          color: Colors.yellow,
                          size: 25,
                        ),
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => AddData(),
                  )),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                                              child: Icon(
                          Icons.refresh,
                          color: Colors.yellow,
                          size: 25,
                        ),
                        onTap: () => null,
                      ),
                      
                    ],
                  ),
                  
               
              )
            ],
          );
  }


}