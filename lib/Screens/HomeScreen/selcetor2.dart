import 'package:flutter/material.dart';

class Selector2 extends StatefulWidget {
 final List<String> selectors;
 Selector2({@required this.selectors});


  @override
  _Selector2State createState() => _Selector2State();
}

class _Selector2State extends State<Selector2> {

  int _currentIndex = 0;
  bool _isSelected;

    List<Widget> _buildItems() {
    return widget.selectors.map((selector) {
      var index = widget.selectors.indexOf(selector);
      _isSelected = _currentIndex == index;
      return Padding(
        padding: EdgeInsets.only(left: 20.0,right: 20),
        child: GestureDetector(
          onTap: () {
            setState(() {
              _currentIndex = index;
              print(index);
            });
          },
          child: Container(
            decoration: BoxDecoration(
              border: (_isSelected
                  ? Border(bottom: BorderSide(color: Colors.black, width: 3.0))
                  : Border()),
            ),
            child: Text(
              selector,
              style: TextStyle(
                  color: _isSelected ? Colors.black : Colors.grey,
                  fontSize: 20.0,
                  fontWeight:  _isSelected ? FontWeight.bold : FontWeight.w400),
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: _buildItems(),
    );
  }
}