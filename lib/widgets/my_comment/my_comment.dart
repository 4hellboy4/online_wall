import 'package:flutter/material.dart';

class MyComment extends StatelessWidget {
  const MyComment({
    Key? key,
    required this.text,
    required this.user,
    required this.time,
  }) : super(key: key);
  final String text;
  final String user;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: <Widget>[
          Text(text),
          Row(
            children: <Widget>[
              Text(user),
              const Text(" * "),
              Text(time),
            ],
          )
        ],
      ),
    );
  }
}
