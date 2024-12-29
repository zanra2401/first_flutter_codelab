import 'package:flutter/material.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          height: 60.0,
          color: Colors.grey,
          child: const Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0, bottom: 20.0, right: 5.0),
            child: Text("Anjay",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0
              ),
            ),
          ),
        )
      ],
    );
  }
}