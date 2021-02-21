import 'dart:math';

import 'package:flutter/material.dart';
import 'package:circular_check_box/circular_check_box.dart';

class TaskTile extends StatefulWidget {
  final String title;
  final String createdAt;
  TaskTile({this.title, this.createdAt});

  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {

    Color blue = Color(0xff0176E1);
    final Color randomColor = Colors.primaries[Random().nextInt(Colors.primaries.length)].withOpacity(0.2);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 70,
          decoration: BoxDecoration(
              color: randomColor,
              borderRadius: BorderRadius.all(Radius.circular(5.0))
          ),
        ),
        SizedBox(width: 5.0,),
        Flexible(
          child: Card(
            color: Color(0XFFF8F8F8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: ListTile(
              title: Text(widget.title),
              subtitle: Text(widget.createdAt),
              trailing: CircularCheckBox(
                  activeColor: blue,
                  inactiveColor: blue,
                  value: selected,
                  onChanged: (value){
                    setState(() {
                      this.selected = value;
                    });
                  }),
            ),
          ),
        )
      ],
    );
  }
}