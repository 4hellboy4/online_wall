import 'package:flutter/material.dart';

class WallPostMsg extends StatelessWidget {
  final String msg;
  final String user;
  const WallPostMsg({
    Key? key,
    required this.msg,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            Text(user),
            Text(msg),
          ],
        ),
      ],
    );
  }
}
