import 'package:flutter/material.dart';

class CardsCountRow extends StatelessWidget {
  final List list;
  CardsCountRow({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 1,
        itemBuilder: (context, i) {
          return Container(
            width: MediaQuery.of(context).size.width - 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(list[i]['A'],
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18)),
                    SizedBox(
                      height: 8,
                    ),
                    Text('مواد مقترحة',
                        style: TextStyle(
                            color: Color(0xff2559e7),
                            fontWeight: FontWeight.w200,
                            fontSize: 14)),
                  ],
                ),
                SizedBox(width: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(list[i]['B'],
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18)),
                    SizedBox(
                      height: 8,
                    ),
                    Text('قيد التحرير',
                        style: TextStyle(
                            color: Color(0xff2559e7),
                            fontWeight: FontWeight.w200,
                            fontSize: 14)),
                  ],
                ),
                SizedBox(width: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(list[i]['C'],
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18)),
                    SizedBox(
                      height: 8,
                    ),
                    Text('قيد المونتاج',
                        style: TextStyle(
                            color: Color(0xff2559e7),
                            fontWeight: FontWeight.w200,
                            fontSize: 14)),
                  ],
                ),
                SizedBox(width: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(list[i]['D'],
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18)),
                    SizedBox(
                      height: 8,
                    ),
                    Text('جاهز للنشر',
                        style: TextStyle(
                            color: Color(0xff2559e7),
                            fontWeight: FontWeight.w200,
                            fontSize: 14)),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
